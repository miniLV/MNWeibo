//
//  MNWriteController.swift
//  MNWeibo
//
//  Created by miniLV on 2020/4/8.
//  Copyright © 2020 miniLV. All rights reserved.
//

import UIKit

class MNWriteController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.darkGray
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "返回", target: self, action: #selector(dismissVC))
    }
    
    @objc func dismissVC(){
        dismiss(animated: true, completion: nil)
    }
}
