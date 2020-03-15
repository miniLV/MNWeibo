//
//  MNStatusListViewModel.swift
//  MNWeibo
//
//  Created by miniLV on 2020/3/15.
//  Copyright © 2020 miniLV. All rights reserved.
//

import Foundation
import YYModel

// weibo data handle
class MNStatusListViewModel {
    lazy var statusList = [MNStatusModel]()
    
    func loadStatus(completion:@escaping (_ isSuccess:Bool) -> ()){
        
        MNNetworkManager.shared.fetchHomePageList { (isSuccess, list) in
            
            guard let array = NSArray.yy_modelArray(with: MNStatusModel.self, json: list ?? []) as? [MNStatusModel] else{
                completion(isSuccess)
                return
            }
            
            self.statusList += array
            completion(isSuccess)
        }
    }
    
}
