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
        let vc = UIViewController.init()
        vc.view.backgroundColor = UIColor.white
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension MNHomeViewController{

    override func setupUI() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "好友", style: .plain, target: self, action: #selector(showFridends))
    }
}
