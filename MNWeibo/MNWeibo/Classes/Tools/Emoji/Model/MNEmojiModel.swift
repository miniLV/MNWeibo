//
//  MNEmojiModel.swift
//  MNWeibo
//
//  Created by miniLV on 2020/4/12.
//  Copyright © 2020 miniLV. All rights reserved.
//

import UIKit

class MNEmojiModel: NSObject {
    ///图片表情，true = emoji，false = 图片表情
    @objc var type = false
    
    /// 表情字符串 - 提交给服务端
    @objc var chs:String?
    
    /// 表情图片，本地图文混排
    @objc var png:String?
    
    /// emoji - 16进制编码字符串
    @objc var code:String?
    
    /// 表情所在目录
    @objc var directory: String?
    
    /// 图片表情图片
    @objc var image: UIImage?{
        if type{
            //is emoji
            return nil
        }
        
        guard let path = Bundle.main.path(forResource: "MNEmoji.bundle", ofType: nil),
            let bundle = Bundle(path:path),
            let directory = directory,
            let png = png else{
                return nil
        }
        return UIImage(named: "\(directory)/\(png)",in: bundle, compatibleWith: nil)
    }
    
    override var description: String{
        return yy_modelDescription()
    }
}
