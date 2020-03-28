//
//  MNStatusPicture.swift
//  MNWeibo
//
//  Created by miniLV on 2020/3/28.
//  Copyright © 2020 miniLV. All rights reserved.
//

import UIKit

class MNStatusPicture: NSObject {
    
    @objc var thumbnail_pic: String?
    
    override var description: String{
        return self.yy_modelDescription()
    }
}
