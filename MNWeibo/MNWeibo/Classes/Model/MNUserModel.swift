//
//  MNUserModel.swift
//  MNWeibo
//
//  Created by miniLV on 2020/3/24.
//  Copyright © 2020 miniLV. All rights reserved.
//

import UIKit

class MNUserModel: NSObject {
    
    @objc var id: Int64 = 0
    
    @objc var screen_name: String?
    
    @objc var profile_image_url: String?

    // 认证类型（-1:没有认证, 0:认证用户, 2,3,5:企业认证, 220:达人）
    @objc var verified_type: Int = 0
    
    // 会员等级 0~6
    @objc var mbrank: Int = 0
    
    override var description: String{
        return yy_modelDescription()
    }
}
