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
    lazy var statusList = [MNStatusViewModel]()
    
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
        let since_id = pullup ? 0 : (statusList.first?.status.id ?? 0)
        // 上拉加载更多 -> 取最旧的一条(last)
        let max_id = !pullup ? 0 : (statusList.last?.status.id ?? 0)
        
        MNNetworkManager.shared.fetchHomePageList(since_id: since_id, max_id: max_id){ (isSuccess, list) in
            
            if !isSuccess{
                completion(false, false)
                return
            }
            
            var array = [MNStatusViewModel]()
            for dic in list ?? []{

                guard let model = MNStatusModel.yy_model(with: dic) else{
                    continue
                }
                //转换成 model -> MNStatusViewModel
                array.append(MNStatusViewModel(model: model))
            }
            
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
