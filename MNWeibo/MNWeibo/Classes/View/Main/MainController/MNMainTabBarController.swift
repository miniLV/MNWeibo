//
//  MNMainTabBarController.swift
//  MNWeibo
//
//  Created by miniLV on 2020/3/10.
//  Copyright © 2020 miniLV. All rights reserved.
//

import UIKit

class MNMainTabBarController: UITabBarController {

    //timer: 定时检查未读消息
    private var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        setupChildrenControllers()
        setupCenterButton()
        setupTimer()
        //新特性
        setupNewFeatureViews()
        UITabBar.appearance().tintColor = UIColor.orange
        delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(userLogin(noti:)), name: NSNotification.Name(MNUserShouldLoginNotification), object: nil)
    }
    
    @objc func userLogin(noti: Notification) {
        
        var when = DispatchTime.now()
        
        if noti.object != nil{
            //FIXME: Need toast
            print("用户登录超时，请重新登陆")
            when = DispatchTime.now() + 2
        }
        
        DispatchQueue.main.asyncAfter(deadline: when){
            self.showAuthorizeView()
        }
    }
    
    func showAuthorizeView(){
        let request:WBAuthorizeRequest = WBAuthorizeRequest.request() as! WBAuthorizeRequest
        request.redirectURI = MNredirectUri
        request.scope = "all"
        request.shouldShowWebViewForAuthIfCannotSSO = true
        request.shouldOpenWeiboAppInstallPageIfNotInstalled = true

        WeiboSDK.send(request) { (result) in
            print("authorize result = \(result)")
        }
    }
    
    deinit {
        timer?.invalidate()
        
        NotificationCenter.default.removeObserver(self)
    }
    
    private lazy var tabBarCenterButtion:UIButton =
        //tabbar_compose_button_highlighted
        UIButton.mn_imageButton(normalImageName: "tabbar_compose_icon_add",
                                backgroundImageName: "tabbar_compose_button")
    
    //center click action
    //@objc: 可以用OC的消息机制调用
    @objc private func centerBtnClick() {
        
        // FIXME: 发布微博
        let view = MNPublishView()
        view.show(rootVC: self) { [weak view] (clsName) in
            guard let clsName = clsName,
                let cls = NSClassFromString(Bundle.main.namespace + "." + clsName) as? UIViewController.Type
                else{
                    view?.removeFromSuperview()
                    return
            }

            let vc = cls.init()
            //让vc在ViewDidLoad之前刷新 - 解决动画&约束混在一起的问题
            let navi = UINavigationController(rootViewController: vc)
            navi.view.layoutIfNeeded()
            self.present(navi, animated: true) {
                view?.removeFromSuperview()
            }
        }
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask{
        return .portrait
    }
}

// MARK: - Timer
extension MNMainTabBarController{

    private func setupTimer(){
        
        timer = Timer.scheduledTimer(timeInterval: 20, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer(){
        if !MNNetworkManager.shared.isLogin{
            return
        }
        
        // request unreadCount data
        MNNetworkManager.shared.unreadCount { (count) in
            
            //设置首页的badge
            self.tabBar.items?[0].badgeValue = count > 0 ? "\(count)" : nil
            //set app badgeValue
            UIApplication.shared.applicationIconBadgeNumber = count
        }
    }
}

extension MNMainTabBarController{
    
    private func setupCenterButton(){
        tabBar.addSubview(tabBarCenterButtion)
        
        let count = CGFloat(viewControllers?.count ?? 0)
        let width = tabBar.bounds.width / count
        let leftItemCount:CGFloat = 2
        tabBarCenterButtion.frame = tabBar.bounds.insetBy(dx: leftItemCount * width, dy: 0)
        tabBarCenterButtion.addTarget(self, action: #selector(centerBtnClick), for: .touchUpInside)
        
    }
    
    private func setupChildrenControllers(){
        
        //load info from Sandbox
        let documentDir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let jsonPath = (documentDir as NSString).appendingPathComponent("main.json")
        var data = NSData(contentsOfFile: jsonPath)
   
        if data == nil {
            //load setting form bundle
            let path = Bundle.main.path(forResource: "main.json", ofType: nil)
            data = NSData(contentsOfFile: path!)
        }
        
        //json to dictionary
        guard let array = try? JSONSerialization.jsonObject(with: data! as Data, options: []) as? [[String:AnyObject]]
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
            NSAttributedString.Key.backgroundColor : UIColor.orange,
            NSAttributedString.Key.font : UIFont.systemFont(ofSize: 13)
        ]
        vc.tabBarItem.setTitleTextAttributes(attributes, for: .normal)
        
        let attributes2 = [
            NSAttributedString.Key.foregroundColor : UIColor.orange,
            NSAttributedString.Key.backgroundColor : UIColor.orange,
            NSAttributedString.Key.font : UIFont.systemFont(ofSize: 13)
        ]
        vc.tabBarItem.setTitleTextAttributes(attributes2, for: .selected)

        let navi = MNNavigationController(rootViewController: vc)
        return navi
    }
}

extension MNMainTabBarController : UITabBarControllerDelegate{
  
    
    /// will selected Tabbar Item
    /// - Parameters:
    ///   - tabBarController: tabBarController
    ///   - viewController: will switch to VC
    ///   - return: Whether to switch
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        
        print("will switch to \(viewController)")

        //当前控制器index
        let index = children.firstIndex(of: viewController)
        
        //在首页，又点击了”首页“tabbar, ==> 滚动到顶部
        if selectedIndex == 0 && index == 0{
            let navi = children[0] as! UINavigationController
            let vc = navi.children[0] as! MNBaseViewController
            
            //scroll to top
            vc.tableView?.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
            
            //FIXME: dispatch work around.(必须滚动完,再刷新)
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                 vc.loadDatas()
            }
            
            //clear badgeNumber
            vc.tabBarItem.badgeValue = nil
            UIApplication.shared.applicationIconBadgeNumber = 0
        }
        
        return !viewController.isMember(of: UIViewController.self)
    }
}

extension MNMainTabBarController{
    
    private func setupNewFeatureViews(){
       
        if !MNNetworkManager.shared.isLogin{
            return
        }
        
        let tempView = isNewVersion ? MNNewFeatureView() : MNWelcomeView()
        tempView.frame = view.bounds
        view.addSubview(tempView)
    }
    
    private var isNewVersion: Bool{
        
        let saveVersionKey = "version"
        let defaults = UserDefaults.standard
        let currentVersion:String = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
        let saveVersion:String = defaults.value(forKey: saveVersionKey) as? String ?? ""
        
        //save version
        defaults.set(currentVersion, forKey: saveVersionKey)
        
        //版本号是递增的，只要不等，就是新版本
        return currentVersion != saveVersion
    }
}
