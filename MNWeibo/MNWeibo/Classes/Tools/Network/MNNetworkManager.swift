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
    
    static let shared = MNNetworkManager()
    
    //The token will expire ==> http error code = 403
    var accessTonken: String? = "2.00xo2AICPKBYGDc9868e64f5KnkckD"
    
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
                // FIXME: Token过期
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
        
        guard let token = accessTonken else{
            print("token is nil, need to login")
            // FIXME: 未登录
            completion(false, nil)
            return
        }
        
        var parameters = parameters
        if parameters == nil {
            parameters = [String:AnyObject]()
        }
        //at this time, parameters must be valuable
        parameters!["access_token"] = token as AnyObject
        request(URLString: URLString, parameters: parameters, completion: completion)
    }
}
