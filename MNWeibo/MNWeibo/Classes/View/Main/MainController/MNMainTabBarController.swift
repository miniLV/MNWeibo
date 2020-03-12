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
    
    //center click action
    //@objc: 可以用OC的消息机制调用
    @objc private func centerBtnClick() {
        print("123")
        
        let vc = UIViewController()
        let navi = UINavigationController(rootViewController: vc)
        vc.view.backgroundColor = UIColor.orange
        present(navi, animated: true, completion: nil)
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask{
        return .portrait
    }
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
        tabBarCenterButtion.addTarget(self, action: #selector(centerBtnClick), for: .touchUpInside)
        
    }
    
    private func setupChildrenControllers(){
        //load setting form bundle
        guard let path = Bundle.main.path(forResource: "main.json", ofType: nil),
            let data = NSData(contentsOfFile: path),
            let array = try? JSONSerialization.jsonObject(with: data as Data, options: []) as? [[String:AnyObject]]
            else {
                print("main.json don't exist.")
                return
        }
        
        var arrayM = [UIViewController]()
        for dic in array {
            arrayM.append(controller(dic: dic))
        }
        viewControllers = arrayM
        
    }
    
    private func controller(dic: [String: Any]) -> UIViewController{
       guard let clsName = dic["clsName"] as? String,
        let title = dic["title"] as? String,
        let imageName = dic["imageName"] as? String,
        let cls = NSClassFromString(Bundle.main.namespace + "." + clsName) as? MNBaseViewController.Type,
        let visitorDic = dic["visitorInfo"] as? [String: String]
        else{
            return UIViewController()
        }
        
        //create view controller ==> clsname -> class
        let vc = cls.init()
        vc.title = title

        //set visitor info
        vc.visitorInfo = visitorDic
        
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
