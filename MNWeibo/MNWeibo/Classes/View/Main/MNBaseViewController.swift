//
//  MNBaseViewController.swift
//  MNWeibo
//
//  Created by miniLV on 2020/3/10.
//  Copyright © 2020 miniLV. All rights reserved.
//

import UIKit

class MNBaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

extension MNBaseViewController{
     @objc func setupUI() {
        self.view.backgroundColor = UIColor.cz_random()
    }
}
