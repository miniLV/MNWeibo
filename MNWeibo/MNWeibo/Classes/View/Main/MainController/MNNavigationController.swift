//
//  MNNavigationController.swift
//  MNWeibo
//
//  Created by miniLV on 2020/3/10.
//  Copyright © 2020 miniLV. All rights reserved.
//

import UIKit

class MNNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //hidden NavigationBar
        navigationBar.isHidden = true
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        
        //hidden bottom tabBar
        if children.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
            
            //set left return item.
            if let vc = viewController as? MNBaseViewController{
                var title = "返回"
                
                //if only one children controller, show vc.title, eg. "首页"，"我的"...
                if children.count == 1{
                    title = children.first?.title ?? "返回"
                }
                
                vc.naviItem.leftBarButtonItem = UIBarButtonItem(title: title, target: self, action: #selector(popViewController(animated:)), isBackItem: true)
            }
        }
        super.pushViewController(viewController, animated: animated)
    }
    
    @objc func popToParent() {
        popViewController(animated: true)
    }
}
