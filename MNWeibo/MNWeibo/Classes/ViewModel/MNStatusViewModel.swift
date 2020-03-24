//
//  MNStatusViewModel.swift
//  MNWeibo
//
//  Created by miniLV on 2020/3/24.
//  Copyright © 2020 miniLV. All rights reserved.
//

import UIKit

/// 单条微博数据
class MNStatusViewModel: CustomStringConvertible {

    var status: MNStatusModel
    
    init(model:MNStatusModel) {
        self.status = model
    }
    
    var description: String{
        return status.description
    }
}
