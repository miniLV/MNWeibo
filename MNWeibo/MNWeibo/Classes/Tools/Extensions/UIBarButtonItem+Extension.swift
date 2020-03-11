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
    ///   - action: touch event
    convenience init(title: String, fontSize: CGFloat = 16, target: AnyObject?, action:Selector) {
        let btn:UIButton = UIButton.cz_textButton(title,
                                                  fontSize:fontSize,
                                                  normalColor: UIColor.darkGray,
                                                  highlightedColor: UIColor.orange)
        btn.addTarget(target, action: action, for: .touchUpInside)
        self.init(customView: btn)
    }
}
