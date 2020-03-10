//
//  ViewController.swift
//  MNWeibo
//
//  Created by miniLV on 2020/3/9.
//  Copyright © 2020 miniLV. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
       
        setupUI()

    }


    func setupUI() {
        let label = UILabel()
        label.text = "test title"
        label.textColor = UIColor.orange
        label.center = self.view.center
        label.frame = CGRect(x: 100, y: 100, width: 200, height: 30)
        self.view.addSubview(label)
    }
}

