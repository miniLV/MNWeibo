//
//  AppDelegate.swift
//  MNWeibo
//
//  Created by miniLV on 2020/3/9.
//  Copyright © 2020 miniLV. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        fetchAppInfo()
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
        
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

