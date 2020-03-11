//
//  MNHomeViewController.swift
//  MNWeibo
//
//  Created by miniLV on 2020/3/10.
//  Copyright © 2020 miniLV. All rights reserved.
//

import UIKit

class MNHomeViewController: MNBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @objc func showFridends() {
        let vc = DemoViewController.init()
        vc.view.backgroundColor = UIColor.white
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension MNHomeViewController{

    override func setupUI() {
   
        super.setupUI()
        naviItem.leftBarButtonItem = UIBarButtonItem(title: "好友", fontSize: 16, target: self, action: #selector(showFridends))
    }
}
