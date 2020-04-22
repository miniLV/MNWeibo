//
//  UIBarButtonItem+Extension.swift
//  MNWeibo
//
//  Created by miniLV on 2020/3/11.
//  Copyright © 2020 miniLV. All rights reserved.
//

import UIKit

extension UIBarButtonItem{
    
    
    /// Create UIBarButtonItem
    /// - Parameters:
    ///   - title: title
    ///   - fontSize: fontSize, default = 16
    ///   - target: target
    ///   - isBackItem: if is back item, add a arrow image.
    ///   - action: touch event
    convenience init(title: String, fontSize: CGFloat = 16, target: AnyObject?, action:Selector, isBackItem:Bool = false) {
        let btn:UIButton = UIButton.mn_textButton(title:title,
                                                  fontSize:fontSize,
                                                  normalColor: UIColor.darkGray,
                                                  highlightedColor: UIColor.orange)

        if isBackItem{
            let imageName = "navigationbar_back_withtext"
            
            btn.setImage(UIImage(named: imageName), for: .normal)
            btn.setImage(UIImage(named: imageName + "_highlighted"), for: .highlighted)
            btn.sizeToFit()
        }
        
        btn.addTarget(target, action: action, for: .touchUpInside)
        self.init(customView: btn)
    }
}
