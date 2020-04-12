//
//  MNEmojiPackageModel.swift
//  MNWeibo
//
//  Created by miniLV on 2020/4/12.
//  Copyright © 2020 miniLV. All rights reserved.
//

import UIKit

class MNEmojiPackageModel: NSObject {
    /// 表情包分组
    @objc var groupName:String?
    
    /// 表情包目录 - 通过info.plist 创建表情模型数字
    @objc var directory:String?{
        didSet{
            // 设置目录的时候，读取 info.plist数据
            guard let directory = directory,
                let path = Bundle.main.path(forResource: "MNEmoji.bundle", ofType: nil),
                let bundle = Bundle(path:path),
                let infoPath = bundle.path(forResource: "info.plist", ofType: nil, inDirectory: directory),
                let array = NSArray(contentsOfFile: infoPath) as? [[String:String]],
                let models = NSArray.yy_modelArray(with: MNEmojiModel.self, json: array) as? [MNEmojiModel]
                else {
                    print("set directory failure.")
                    return
            }
            
            
            //设置表情目录
            for model in models{
                model.directory = directory
            }
            self.emotions += models
        }
    }
    
    /// 表情模型数组
    @objc lazy var emotions = [MNEmojiModel]()
    
    override var description: String{
        return yy_modelDescription()
    }
}
