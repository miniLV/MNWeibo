//
//  AppDelegate.swift
//  MNWeibo
//
//  Created by miniLV on 2020/3/9.
//  Copyright © 2020 miniLV. All rights reserved.
//

import UIKit
import UserNotifications
import AFNetworking
import SVProgressHUD

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        fetchAppInfo()
        
        setupAdditions()
        
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
        
    }
}

extension AppDelegate{
    
    private func setupAdditions(){
        
        //setup WeiboSDK
        WeiboSDK.enableDebugMode(true)
        WeiboSDK.registerApp(MNAppKey, universalLink: "https://myappapi.fun/")

        AFNetworkActivityIndicatorManager.shared().isEnabled = true
        
        //Authorization allowed(.alert, .sound, .badge)
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge, .carPlay]) { (success, error) in
            //print("授权" + (success ? "成功" : "失败"))
        }
    }
}

extension AppDelegate{
    
    private func fetchAppInfo(){
        
        //Simulate a network request
        DispatchQueue.global().async {
            
            guard let url = Bundle.main.url(forResource: "main.json", withExtension: nil) else{
                print("url is nil")
                return
            }
            
            let data = NSData(contentsOf: url)
            
            //write to disk
            let documentDir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
            let jsonPath = (documentDir as NSString).appendingPathComponent("main.json")
            
            //save to sanbox,next launch app will use it.
            data?.write(toFile: jsonPath, atomically: true)
        }
        
    }
}

