//
//  MNSQLiteManager.swift
//  MNWeibo
//
//  Created by miniLV on 2020/4/18.
//  Copyright © 2020 miniLV. All rights reserved.
//

import Foundation
import FMDB

// 最大缓存时间(7天), 负数表示过去时间
private let maxDBCacheTime:TimeInterval = -(60 * 60 * 24 * 7)

class MNSQLiteManager {
    
    /// 数据库单例
    static let shared = MNSQLiteManager()
    
    /// 数据库队列
    let queue: FMDatabaseQueue
    
    private init(){
        // 数据库路径
        let dbName = "MNDatabase.db"
        var path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        path = (path as NSString).appendingPathComponent(dbName)
        
        // 创建数据库队列，同时`创建或者打开`数据库
        queue = FMDatabaseQueue(path: path) ?? FMDatabaseQueue()
        print("数据库路径 = \(path)")
        
        createTable()
        
        //进入后台之后，清除缓存
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(clearDBCache),
            name: UIApplication.didEnterBackgroundNotification,
            object: nil)
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(clearDBCache),
            name: UIApplication.willTerminateNotification,
            object: nil)
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(clearDBCache),
            name: UIApplication.didReceiveMemoryWarningNotification,
            object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    //清理数据缓存
    @objc private func clearDBCache(){

        let dateString = Date.mn_dateString(delta: maxDBCacheTime)
        
        print("清理数据缓存 \(dateString)")
        
        let sql = "DELETE FROM T_WeiboStatus WHERE createTime < ?;"
        
        // 执行 SQL
        queue.inDatabase { (db) in
            
            if db.executeUpdate(sql, withArgumentsIn: [dateString]) == true {
                
                print("删除了 \(db.changes) 条记录")
            }
        }
    }
}


// MARK: - 创建数据表以及其他私有方法
extension MNSQLiteManager {
    
    /// 执行一个 SQL，返回查询结果(字典的数组)
    /// - parameter sql: sql语句
    /// - returns: 字典的数组
    func execRecordSet(sql: String) -> [[String: Any]] {
        
        // 结果数组
        var result = [[String: Any]]()
        
        // 查询不会修改
        queue.inDatabase { (db) in
            
            guard let rs = db.executeQuery(sql, withArgumentsIn: []) else {
                return
            }
            
            // 逐行 - 遍历结果集合
            while rs.next() {
                
                // 1> 查询到的总列数
                let columnCount = rs.columnCount
                
                // 2> 遍历所有列
                for column in 0..<columnCount {
                    
                    // 3> 列名 -> KEY / 值 -> Value
                    guard let name = rs.columnName(for: column),
                        let value = rs.object(forColumnIndex: column) else {
                            continue
                    }
                    result.append([name: value])
                }
            }
        }
        return result
    }
    
    /// 创建数据表
    func createTable() {
        
        // 1. SQL
        guard let path = Bundle.main.path(forResource: "MNWeibo.sql", ofType: nil),
            let sql = try? String(contentsOfFile: path)
            else {
                return
        }
        
         print(sql)
        
        // 2. 执行 SQL - FMDB 的内部队列，串行队列，同步执行
        // 可以保证同一时间，只有一个任务操作数据库，从而保证数据库的读写安全！
        queue.inDatabase { (db) in
            
            // 只有在创表的时候，使用执行多条语句，可以一次创建多个数据表
            // 在执行增删改的时候，一定不要使用 statements 方法，否则有可能会被注入！
            if db.executeStatements(sql) == true {
                print("创表成功")
            } else {
                print("创表失败 - 请检查你的sql文件是否格式错误")
            }
        }
    }
}

// MARK: - 微博数据操作
extension MNSQLiteManager {
    
    /// 从数据库加载微博数据数组
    ///
    /// - parameter userId:   当前登录的用户帐号
    /// - parameter since_id: 返回ID比since_id大的微博
    /// - parameter max_id:   返回ID小于max_id的微博
    ///
    /// - return : 微博的字典的数组，将数据库中 status 字段对应的二进制数据反序列化，生成字典
    func loadWeiboStatus(userId: String, since_id: Int64 = 0, max_id: Int64 = 0) -> [[String: AnyObject]] {
        
        var sql = "SELECT statusId, userId, status FROM T_WeiboStatus \n"
        sql += "WHERE userId = \(userId) \n"
        
        // 上拉加载更多／下拉刷新
        if since_id > 0 {
            sql += "AND statusId > \(since_id) \n"
        } else if max_id > 0 {
            sql += "AND statusId < \(max_id) \n"
        }
        
        // 降序排列 & 最多20条数据
        sql += "ORDER BY statusId DESC LIMIT 20;"
        
        // 拼接 SQL 结束后，一定一定一定要测试！
        print("sql === \(sql)")
        
        // 2. 执行 SQL
        let array = execRecordSet(sql: sql)
        
        // 3. 将存储数组中的 status(二进制数据) 反序列化 -> 字典的数组
        var result = [[String: AnyObject]]()
        
        for dict in array {
            
            // 反序列化
            guard let jsonData = dict["status"] as? Data,
                let json = try? JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: AnyObject]
                else {
                    continue
            }
            
            result.append(json)
        }
        return result
    }
    
    /// 新增或者修改微博数据，微博数据在刷新的时候，可能会出现重叠
    ///
    /// - parameter userId: 当前登录用户的 id
    /// - parameter array:  从网路获取的`字典的数组`
    func updateStatus(userId: String, array: [[String: AnyObject]]) {
        
        /**
         statusId:  要保存的微博代号
         userId:    当前登录用户的 id
         status:    完整微博字典的 json 二进制数据
         */
        let sql = "INSERT OR REPLACE INTO T_WeiboStatus (statusId, userId, status) VALUES (?, ?, ?);"
        
        // 2. 执行 SQL
        queue.inTransaction { (db, rollback) in
            
            // 遍历数组，逐条插入微博数据
            for dict in array {
                
                // 从字典获取微博代号／将字典序列化成二进制数据
                guard let statusId = dict["idstr"] as? String,
                    let jsonData = try? JSONSerialization.data(withJSONObject: dict, options: [])
                    else {
                        continue
                }
                
                // 执行 SQL(参数要根据sql的问号 -> 按顺序)
                if db.executeUpdate(sql, withArgumentsIn: [statusId, userId, jsonData]) == false {
                    
                    //回滚
                    print("sql 执行失败，回滚一哈 \(sql)")
                    rollback.pointee = true
                    break
                }
            }
        }
    }
}
