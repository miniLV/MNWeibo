//
//  MNUserAccount.swift
//  MNWeibo
//
//  Created by miniLV on 2020/3/18.
//  Copyright © 2020 miniLV. All rights reserved.
//

import UIKit
import YYModel

class MNUserAccount: NSObject {

    //访问令牌
    var accessToken: String? //= "2.00xo2AICPKBYGDa1010f10b80BrjTU"
    //用户id
    var uid:String?
    //过期日期
    var expiresTime: TimeInterval = 0.0{
        didSet{
            expiresDate = Date(timeIntervalSinceNow: expiresTime)
        }
    }
    var expiresDate : Date?
    
    override var description: String{
        return yy_modelDescription()
    }
}
