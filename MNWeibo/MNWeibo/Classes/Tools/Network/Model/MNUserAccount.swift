//
//  MNUserAccount.swift
//  MNWeibo
//
//  Created by miniLV on 2020/3/18.
//  Copyright © 2020 miniLV. All rights reserved.
//

import UIKit
import YYModel

class MNUserAccount: NSObject {

    //访问令牌
    @objc var access_token: String? //= "2.00xo2AICPKBYGDa1010f10b80BrjTU"
    //用户id
    @objc var uid:String?
    //过期日期戳
    @objc var expires_in: TimeInterval = 0.0{
        didSet{
            expiresDate = Date(timeIntervalSinceNow: expires_in)
        }
    }
    //过期日期
    @objc var expiresDate : Date?
    
    override var description: String{
        return yy_modelDescription()
    }
    
    /** Data Save
     1. UserDefault
     2. sandbox - 归档/json/plist
     3. 数据库
     4. keyChain(SSKeyChain)
     */
    func saveAccoutInfo(){
        
        //Model -> Dict
        var dic = self.yy_modelToJSONObject() as? [String: AnyObject] ?? [:]
        dic.removeValue(forKey: "expires_in")
        
        //序列化
        guard let data = try? JSONSerialization.data(withJSONObject: dic, options: []),
        let filePath = ("userAccount.json" as NSString).cz_appendDocumentDir()
            else{
            return
        }
        
        //write to disk
        (data as NSData).write(toFile: filePath, atomically: true)
    }
}
