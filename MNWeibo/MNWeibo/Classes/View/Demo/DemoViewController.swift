//
//  DemoViewController.swift
//  MNWeibo
//
//  Created by miniLV on 2020/3/11.
//  Copyright © 2020 miniLV. All rights reserved.
//

import UIKit

class DemoViewController: MNBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let string = "离开了...[可爱][马到成功]"
        let label = UILabel()
        label.frame = CGRect(x: 0, y: 0, width: 300, height: 100)
        label.backgroundColor = UIColor.orange
        
        let temp = MNEmojiManager.shared.findEmoji(string: string)
        print("temp = \(temp)")
        
        let str = MNEmojiManager.shared.getEmojiString(string: string, font: label.font)
        
        label.attributedText = str
        view.addSubview(label)
    }
//    override func setupUI() {
//        super.setupUI()
//
//    }

}
