//
//  MNStatusPicture.swift
//  MNWeibo
//
//  Created by miniLV on 2020/3/28.
//  Copyright © 2020 miniLV. All rights reserved.
//

import UIKit

class MNStatusPicture: NSObject {
    
    ///缩略图
    @objc var thumbnail_pic: String?{
        didSet{
            
            //处理缩略图地址
            thumbnail_pic = thumbnail_pic?.replacingOccurrences(of: "/thumbnail/", with: "/wap360/")
            //原图
            largePic = thumbnail_pic?.replacingOccurrences(of: "/wap360/", with: "/large/")
            
        }
    }
    
    ///原图
    @objc var largePic:String?
    
    override var description: String{
        return self.yy_modelDescription()
    }
}
