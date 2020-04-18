//
//  MNNetworkManager.swift
//  MNWeibo
//
//  Created by miniLV on 2020/3/15.
//  Copyright © 2020 miniLV. All rights reserved.
//

import UIKit
import AFNetworking

enum RequestMethod{
    case GET
    case POST
}

class MNNetworkManager: AFHTTPSessionManager {
    
    static let shared:MNNetworkManager = {
        let instance = MNNetworkManager()
        instance.responseSerializer.acceptableContentTypes?.insert("text/plain")
        return instance
    }()
    
    //user account info
    lazy var userAccount = MNUserAccount()
    
    var isLogin:Bool {
        return userAccount.access_token != nil
    }
    
    
    
    /// AFNetwork request
    /// - Parameters:
    ///   - method: GET/POST
    ///   - URLString: url string
    ///   - parameters: parameters - [key:value]
    ///   - completion: (isSuccess, json)
    func request(method:RequestMethod = .GET, URLString:String, parameters:[String:AnyObject]?, completion:@escaping (_ isSuccess:Bool, _ json:Any?)->()) {
        
        let success = { (task: URLSessionDataTask, json: Any?) -> () in
            completion(true, json)
        }
        let failure = { (task: URLSessionDataTask?, error:Error) -> () in
            print("Request error ==> \(error)")
            if (task?.response as? HTTPURLResponse)?.statusCode == 403{
                print("token 过期了兄弟")
                
                //notification post message
                NotificationCenter.default.post(name: Notification.Name(MNUserShouldLoginNotification) , object: "token403")
            }
            completion(false, nil)
        }
        
        if method == .GET{
            get(URLString, parameters: parameters, progress: nil, success: success, failure: failure)
        }else{
            post(URLString, parameters: parameters, progress: nil, success: success, failure: failure)
        }
    }
    
    func tokenRequest(method:RequestMethod = .GET, URLString:String, parameters:[String:AnyObject]?, completion:@escaping (_ isSuccess:Bool, _ json:Any?)->()){
        
        guard let token = userAccount.access_token else{
            print("token is nil, need to login")
            NotificationCenter.default.post(name: Notification.Name(MNUserShouldLoginNotification) , object: nil)
            completion(false, nil)
            return
        }
        
        var parameters = parameters
        if parameters == nil {
            parameters = [String:AnyObject]()
        }
        //at this time, parameters must be valuable
        parameters!["access_token"] = token as AnyObject
        request(method: method, URLString: URLString, parameters: parameters, completion: completion)
    }
}
