//
//  UIColor+Extentsion.swift
//  MNWeibo
//
//  Created by miniLV on 2020/4/22.
//  Copyright © 2020 miniLV. All rights reserved.
//

import Foundation
    
extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF)
    }
    
    class func mn_randomColor() -> UIColor {
        return UIColor(red: Int(arc4random_uniform(256)), green: Int(arc4random_uniform(256)), blue: Int(arc4random_uniform(256)))
      }
}
