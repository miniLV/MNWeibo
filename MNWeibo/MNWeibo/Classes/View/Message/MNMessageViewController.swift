//
//  MNMessageViewController.swift
//  MNWeibo
//
//  Created by miniLV on 2020/3/10.
//  Copyright © 2020 miniLV. All rights reserved.
//

import UIKit

class MNMessageViewController: MNBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.refreshControl?.endRefreshing()
        }
    }
}
