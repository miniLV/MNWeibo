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
    
    /// AFNetwork request
    /// - Parameters:
    ///   - method: GET/POST
    ///   - URLString: url string
    ///   - parameters: parameters - [key:value]
    ///   - completion: (isSuccess, json)
    func request(method:RequestMethod = .GET, URLString:String, parameters:[String:AnyObject], completion:@escaping (_ isSuccess:Bool, _ json:Any?)->()) {
        
        let success = { (task: URLSessionDataTask, json: Any?) -> () in
            completion(true, json)
        }
        let failure = { (task: URLSessionDataTask?, error:Error) -> () in
            print("Request error ==> \(error)")
            completion(false, nil)
        }
        
        if method == .GET{
            get(URLString, parameters: parameters, progress: nil, success: success, failure: failure)
        }else{
            post(URLString, parameters: parameters, progress: nil, success: success, failure: failure)
        }
    }
}
