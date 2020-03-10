//
//  MNMainTabBarController.swift
//  MNWeibo
//
//  Created by miniLV on 2020/3/10.
//  Copyright © 2020 miniLV. All rights reserved.
//

import UIKit

class MNMainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.cz_random()
        setupChildrenControllers()
    }
}

extension MNMainTabBarController{
    
    private func setupChildrenControllers(){
        let array = [
            ["clsName":"MNHomeViewController","title":"首页", "imageName":"home"],
            ["clsName":"MNMessageViewController","title":"消息", "imageName":"message_center"],
            ["clsName":"MNDiscoverViewController","title":"发现", "imageName":"discover"],
            ["clsName":"MNProfileViewController","title":"我的", "imageName":"profile"],
        ]
        
        var arrayM = [UIViewController]()
        for dic in array {
            arrayM.append(controller(dic: dic))
        }
        viewControllers = arrayM
    }
    
    //[]
    private func controller(dic: [String: String]) -> UIViewController{
       guard let clsName = dic["clsName"],
        let title = dic["title"],
        let imageName = dic["imageName"],
        let cls = NSClassFromString(Bundle.main.namespace + "." + clsName) as? UIViewController.Type
        else{
            return UIViewController()
        }
        
        //create view controller ==> clsname -> class
        let vc = cls.init()
        vc.title = title

        let normalImage = "tabbar_" + imageName
        let selectedImage = "tabbar_" + imageName + "_selected"
        vc.tabBarItem.image = UIImage(named: normalImage)
        vc.tabBarItem.selectedImage = UIImage(named: selectedImage)?.withRenderingMode(.alwaysOriginal)
        
        let navi = MNNavigationController(rootViewController: vc)
        return navi
    }
}
