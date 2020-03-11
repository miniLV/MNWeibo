//
//  MNBaseViewController.swift
//  MNWeibo
//
//  Created by miniLV on 2020/3/10.
//  Copyright © 2020 miniLV. All rights reserved.
//

import UIKit

class MNBaseViewController: UIViewController {

    //custom navigation bar
    lazy var navigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: UIScreen.cz_screenWidth(), height: 64))
    
    lazy var naviItem = UINavigationItem()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override var title: String? {
        didSet{
            naviItem.title = title
        }
    }
    
}

extension MNBaseViewController{
     @objc func setupUI() {
        view.backgroundColor = UIColor.cz_random()
        view.addSubview(navigationBar)
        
        navigationBar.items = [naviItem]
        navigationBar.barTintColor = UIColor.cz_color(withHex: 0xF6F6F6)
    }
}
