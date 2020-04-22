//
//  UIButtion+Extension.swift
//  MNWeibo
//
//  Created by miniLV on 2020/4/22.
//  Copyright © 2020 miniLV. All rights reserved.
//

import Foundation
extension UIButton{
    
    class func mn_imageButton(normalImageName:String, highlightImageName:String) -> UIButton{
        let button = UIButton()
        button.setImage(UIImage(named: normalImageName), for: .normal)
        button.setImage(UIImage(named: highlightImageName), for: .highlighted)
        return button
    }
    
    class func mn_textButton(title:String, fontSize:CGFloat, normalColor:UIColor, highlightedColor:UIColor, backgroundImageName:String? = nil) -> UIButton{
        
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.setTitleColor(normalColor, for: .normal)
        button.setTitleColor(highlightedColor, for: .highlighted)
        button.titleLabel?.font = UIFont.systemFont(ofSize: fontSize)
        if let backgroundImageName = backgroundImageName{
            button.setBackgroundImage(UIImage(named: backgroundImageName), for: .normal)
            let backgroundImageNameHL = backgroundImageName + "_highlighted"
            button.setBackgroundImage(UIImage(named: backgroundImageNameHL), for: .highlighted)
        }
        return button
    }
    
    
}
