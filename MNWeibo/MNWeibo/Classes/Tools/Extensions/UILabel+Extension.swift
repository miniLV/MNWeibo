//
//  UILabel+Extension.swift
//  MNWeibo
//
//  Created by miniLV on 2020/4/21.
//  Copyright © 2020 miniLV. All rights reserved.
//

import Foundation

extension UILabel{
    class func mn_label(text:String, fontSize:CGFloat, color:UIColor) -> UILabel{
        
        let label = self.init()
        label.text = text
        label.font = UIFont.systemFont(ofSize: MNLayout.Layout(fontSize))
        label.textColor = color
        label.numberOfLines = 0
        label.sizeToFit()
        return label
    }
}
