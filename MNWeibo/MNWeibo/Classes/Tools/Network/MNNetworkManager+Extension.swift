//
//  MNNetworkManager+Extension.swift
//  MNWeibo
//
//  Created by miniLV on 2020/3/15.
//  Copyright © 2020 miniLV. All rights reserved.
//

import Foundation

//For MNWeibo App request
extension MNNetworkManager{
    
    /// fetch home page datas
    /// - Parameters:
    ///   - list: home page list
    ///   - isSuccess: request success
    func fetchHomePageList(completion:@escaping (_ isSuccess: Bool,_ list:[[String:AnyObject]]?) -> ()) {
        let urlString = "https://api.weibo.com/2/statuses/home_timeline.json"
        let parms = ["access_token":"2.00xo2AICPKBYGDc9868e64f5KnkckD"]
        
        request(URLString: urlString, parameters: parms as [String : AnyObject]) { (isSuccess, json) in
            print("json == \(String(describing: json))")
            let jsonObject = json as?[String:Any]
            let result = jsonObject?["statuses"] as? [[String:AnyObject]]

            completion(isSuccess, result)
        }
    }
    
}
