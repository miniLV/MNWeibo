//
//  SceneDelegate.swift
//  MNWeibo
//
//  Created by miniLV on 2020/3/9.
//  Copyright © 2020 miniLV. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let scene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: scene)
        window?.backgroundColor = UIColor.orange
        window?.rootViewController = MNMainTabBarController()
        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    //WBAuthorizeRequest 想要通过Weibo SDK 打开内置的webview
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        guard let url = URLContexts.first?.url else {
            print("url is nil, URLContexts = \(URLContexts)")
            return
        }
        
        WeiboSDK.handleOpen(url, delegate: self)
    }
    

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

extension SceneDelegate: WeiboSDKDelegate{
    func didReceiveWeiboRequest(_ request: WBBaseRequest!) {
        print("didReceiveWeiboRequest")
    }
    
    //登录成功的回调
    func didReceiveWeiboResponse(_ response: WBBaseResponse!) {
        print("didReceiveWeiboResponse")
        if response.isKind(of: WBAuthorizeResponse.self){
            
            guard let authResponse = response as? WBAuthorizeResponse else {
                print("authResponse is not WBAuthorizeResponse")
                return
            }
            let token = authResponse.accessToken
            let userID = authResponse.userID
            let expirationDate = authResponse.expirationDate
            
            MNNetworkManager.shared.userAccount.access_token = token
            MNNetworkManager.shared.userAccount.uid = userID
            MNNetworkManager.shared.userAccount.expiresDate = expirationDate
            MNNetworkManager.shared.userAccount.saveAccoutInfo()
            
            
            print("token = \(String(describing: token)), userID = \(String(describing: userID)),expirationDate = \(String(describing: expirationDate))")
            
            //post noti dismiss authView
            NotificationCenter.default.post(name: NSNotification.Name(MNUserLoginSuccessNotification), object: nil)
        }
    }
}
