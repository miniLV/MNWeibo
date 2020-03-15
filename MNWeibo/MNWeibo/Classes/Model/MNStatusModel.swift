//
//  MNStatusModel.swift
//  MNWeibo
//
//  Created by miniLV on 2020/3/15.
//  Copyright © 2020 miniLV. All rights reserved.
//

import UIKit
import YYModel

class MNStatusModel: NSObject {
    @objc var id: Int64 = 0
    @objc var text: String?
    
    override var description: String{
        return yy_modelDescription()
    }
}
