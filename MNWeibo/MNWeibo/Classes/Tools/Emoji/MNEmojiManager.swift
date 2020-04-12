//
//  MNEmojiManager.swift
//  MNWeibo
//
//  Created by miniLV on 2020/4/12.
//  Copyright © 2020 miniLV. All rights reserved.
//

import Foundation

class MNEmojiManager {
    static let shared = MNEmojiManager()
    
    lazy var packages = [MNEmojiPackageModel]()
    
    private init(){
        loadPackageDatas()
    }
}

private extension MNEmojiManager{
    
    func loadPackageDatas(){
        guard let path = Bundle.main.path(forResource: "MNEmoji.bundle", ofType: nil),
            let bundle = Bundle(path:path),
            let plistPath = bundle.path(forResource: "emoticons.plist", ofType: nil),
            let array = NSArray(contentsOfFile: plistPath) as? [[String:String]],
            let models = NSArray.yy_modelArray(with: MNEmojiPackageModel.self, json: array) as? [MNEmojiPackageModel]
            else{
                print("loadPackageDatas failure.")
                return
        }
        packages += models
//        print(packages)
    }
}
