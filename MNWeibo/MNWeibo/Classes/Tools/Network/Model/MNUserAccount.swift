//
//  MNUserAccount.swift
//  MNWeibo
//
//  Created by miniLV on 2020/3/18.
//  Copyright © 2020 miniLV. All rights reserved.
//

import UIKit
import YYModel

private let accountFileName:NSString = "userAccount.json"

class MNUserAccount: NSObject {

    //访问令牌("2.00xo2AICPKBYGDa1010f10b80BrjTU")
    @objc var access_token: String?
    //用户id
    @objc var uid:String?
    //过期日期戳
    @objc var expires_in: TimeInterval = 0.0{
        didSet{
            expiresDate = Date(timeIntervalSinceNow: expires_in)
        }
    }
    //过期日期
    @objc var expiresDate : Date?
    
    override init() {
        super.init()
        
        //load save userAccount info form disk
        guard let filePath = accountFileName.cz_appendDocumentDir(),
            let data = NSData(contentsOfFile: filePath),
            let dic = try? JSONSerialization.jsonObject(with: data as Data, options: []) as? [String:AnyObject] else {
                print("filePath or data is nil")
                return
        }
        yy_modelSet(with: dic)
        
        //token expires
        if expiresDate?.compare(Date()) != .orderedDescending{
            //过期 == 过期时间 < 当前时间 == 降序排列
            print("账户过期")
            
            access_token = nil
            uid = nil
            
            //remove save userinfo
            try? FileManager.default.removeItem(atPath: filePath)
        }
        print("load user info form sandbox -> \(self)")
    }
    
    override var description: String{
        return yy_modelDescription()
    }
    
    /** Data Save
     1. UserDefault
     2. sandbox - 归档/json/plist
     3. 数据库
     4. keyChain(SSKeyChain)
     */
    func saveAccoutInfo(){
        
        //Model -> Dict
        var dic = self.yy_modelToJSONObject() as? [String: AnyObject] ?? [:]
        dic.removeValue(forKey: "expires_in")
        
        //序列化
        guard let data = try? JSONSerialization.data(withJSONObject: dic, options: []),
        let filePath = accountFileName.cz_appendDocumentDir()
            else{
            return
        }
        
        //write to disk
        (data as NSData).write(toFile: filePath, atomically: true)
    }
}
