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
    }
}


//MARK: - 表情符号处理
extension MNEmojiManager{
    
    
    /// 根据传入的字符串[abc]，查找对应的表情模型
    /// - Parameter string : 查询字符串
    func findEmoji(string: String) -> MNEmojiModel? {
        
       
        for pModel in packages{
            /**case1: 常规写法
            let result = pModel.emotions.filter { (model) -> Bool in
                return model.chs == string
            }
             */
            
            /**case2: 尾随闭包
            let result = pModel.emotions.filter() { (model) -> Bool in
                return model.chs == string
            }
            */
            
            /**case3: 闭包中执行语句只有一句，且是返回 ==> 省略 参数 & 返回值
             let result = pModel.emotions.filter {
                 return $0.chs == string
             }
             */
            
            //case4: case3的基础上，return 也可以省略
            let result = pModel.emotions.filter {
                $0.chs == string
            }
            if result.count > 0 {
                
                return result.first
            }
        }
        
        return nil
    }
}
