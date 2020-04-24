//
//  String+MNPath.swift
//  MNWeibo
//
//  Created by miniLV on 2020/4/21.
//  Copyright © 2020 miniLV. All rights reserved.
//

import Foundation

extension String{
    
    func mn_appendDocumentDir() -> String?{
        
        guard let dir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first else {
            return nil
        }
        let path = "/userInfo.json"
        return dir + path
    }
}
