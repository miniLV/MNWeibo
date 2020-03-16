//
//  MNStatusListViewModel.swift
//  MNWeibo
//
//  Created by miniLV on 2020/3/15.
//  Copyright © 2020 miniLV. All rights reserved.
//

import Foundation
import YYModel

// 超过5次上拉加载失败，就停止上拉刷新
private let maxPullupTimes = 5

// weibo data handle
class MNStatusListViewModel {
    lazy var statusList = [MNStatusModel]()
    
    private var pullupErrorTimes = 0
    /// 处理微博首页数据
    /// - Parameters:
    ///   - pullup: 是否下拉刷新
    ///   - completion: 完成请求,needRefresh = 是否需要刷新表格

    func loadStatus(pullup:Bool, completion:@escaping ( _ isSuccess:Bool, _ needRefresh:Bool) -> ()){
        
        if pullup && pullupErrorTimes >= maxPullupTimes{
            completion(true, false)
            return
        }
        
        //取出当前最新的数据 -> 越上面越新
        let since_id = pullup ? 0 : (statusList.first?.id ?? 0)
        // 上拉加载更多 -> 取最旧的一条(last)
        let max_id = !pullup ? 0 : (statusList.last?.id ?? 0)
        
        MNNetworkManager.shared.fetchHomePageList(since_id: since_id, max_id: max_id){ (isSuccess, list) in
            
            //swift 版 字典转模型
            guard let array = NSArray.yy_modelArray(with: MNStatusModel.self, json: list ?? []) as? [MNStatusModel] else{
                completion(isSuccess, false)
                return
            }
            
            print("刷新了 -- \(array.count) 条")
            //data handle
            if pullup{
                //上拉加载更多，拼接在数组最后
                self.statusList += array
            }else{
                //下拉刷新，拼接在数组最前面
                self.statusList = array + self.statusList
            }
            
            if pullup && array.count == 0{
                self.pullupErrorTimes += 1
                completion(isSuccess,false)
            }else{
                completion(isSuccess,true)
            }
        }
    }
    
}
