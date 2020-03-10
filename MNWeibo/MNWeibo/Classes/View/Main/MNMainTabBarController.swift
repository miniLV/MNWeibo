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
        setupCenterButton()
    }
    
    private lazy var tabBarCenterButtion:UIButton = UIButton.cz_imageButton("tabbar_compose_icon_add",
                                                                   backgroundImageName: "tabbar_compose_button")
}

extension MNMainTabBarController{
    
    private func setupCenterButton(){
        tabBar.addSubview(tabBarCenterButtion)
        
        let count = CGFloat(viewControllers?.count ?? 0)
        /**
         center button的内缩进宽度减小(centerbutton宽度增大)，避免用户不小心点到容错点
         */
        let width = tabBar.bounds.width / count - 1
        let leftItemCount:CGFloat = 2
        tabBarCenterButtion.frame = tabBar.bounds.insetBy(dx: leftItemCount * width, dy: 0)
        print("frame = \(tabBarCenterButtion.frame)")
        
    }
    
    private func setupChildrenControllers(){
        let array = [
            ["clsName":"MNHomeViewController","title":"首页", "imageName":"home"],
            ["clsName":"MNMessageViewController","title":"消息", "imageName":"message_center"],
            ["clsName":"UIViewController"],
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

        //set icon image
        let normalImage = "tabbar_" + imageName
        let selectedImage = "tabbar_" + imageName + "_selected"
        vc.tabBarItem.image = UIImage(named: normalImage)
        vc.tabBarItem.selectedImage = UIImage(named: selectedImage)?.withRenderingMode(.alwaysOriginal)
        
        //swift5: set UIBarItem title color
        let attributes = [
            NSAttributedString.Key.foregroundColor : UIColor.orange,
            NSAttributedString.Key.font : UIFont.systemFont(ofSize: 13)
        ]
        vc.tabBarItem.setTitleTextAttributes(attributes, for: .normal)

        let navi = MNNavigationController(rootViewController: vc)
        return navi
    }
}
