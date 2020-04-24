//
//  MNNavigationBar.swift
//  MNWeibo
//
//  Created by miniLV on 2020/4/22.
//  Copyright © 2020 miniLV. All rights reserved.
//

import UIKit

class MNNavigationBar: UINavigationBar {

    //Fix: navigation-contentView y = 0 bug.
    override func layoutSubviews() {
        super.layoutSubviews()
        
        for subview in self.subviews {
            let stringFromClass = NSStringFromClass(subview.classForCoder)
            if stringFromClass.contains("BarBackground") {
                subview.frame = self.bounds
            } else if stringFromClass.contains("UINavigationBarContentView") {
                subview.frame = CGRect(x: 0,
                                       y: MN_statusBarHeight,
                                       width: UIScreen.mn_screenW,
                                       height: MN_naviContentHeight)
            }
        }
    }
}
