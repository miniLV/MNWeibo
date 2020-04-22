//
//  NSAttributedString+Extension.swift
//  MNWeibo
//
//  Created by miniLV on 2020/4/22.
//  Copyright © 2020 miniLV. All rights reserved.
//

import Foundation

extension NSAttributedString{
    
    class func mn_imageText(image: UIImage, imageWH:CGFloat, title: String, fontSize: CGFloat, titleColor:UIColor,
                            speacing:CGFloat) -> NSAttributedString{
    
        //文本属性
        let titleDict = [NSAttributedString.Key.foregroundColor : titleColor,
                         NSAttributedString.Key.font : UIFont.systemFont(ofSize: fontSize)]
        let spacingDict = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: speacing)]
        
        //图片属性
        let attachment = NSTextAttachment()
        attachment.image = image
        attachment.bounds = CGRect(x: 0, y: 0, width: imageWH, height: imageWH)
        let imageText = NSAttributedString.init(attachment: attachment)
        let lineText = NSAttributedString.init(string: "\n\n", attributes: spacingDict)
        let titleText = NSAttributedString.init(string: title, attributes: titleDict)
        
        //属性合并
        let attrM = NSMutableAttributedString.init(attributedString: imageText)
        attrM.append(lineText)
        attrM.append(titleText)
     
        return attrM
    }
}

