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
    
    let pageCells = 20
    
    lazy var bundle: Bundle = {
        let path = Bundle.main.path(forResource: "MNEmoji.bundle", ofType: nil)
        return Bundle(path:path ?? "") ?? Bundle()
    }()
    
    private init(){
        loadPackageDatas()
    }
    
    // 添加最近使用的表情
    func recentEmoji(model:MNEmojiModel){
        //1.表情使用次数+1
        model.times += 1
        
        //2.添加表情
        if !packages[0].emotions.contains(model){
            packages[0].emotions.append(model)
        }
        
        //3.排序(降序)
        packages[0].emotions.sort { $0.times > $1.times }
        
        //4.表情数组长度处理
        if packages[0].emotions.count > pageCells{
            let subRange = pageCells..<packages[0].emotions.count
            packages[0].emotions.removeSubrange(subRange)
        }
    }
}

private extension MNEmojiManager{
    
    func loadPackageDatas(){
        guard let plistPath = bundle.path(forResource: "emoticons.plist", ofType: nil),
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
            
            //传入的参数和model对比，过滤出一致字符串对应的模型.
            let result = pModel.emotions.filter { $0.chs == string }
            if result.count > 0 {
                return result.first
            }
        }
        return nil
    }
    
    
    /// 将字符串转换成属性文本
    /// - Parameter string: 原始字符串
    func getEmojiString(string: String, font: UIFont) -> NSAttributedString {
        let attrStr = NSMutableAttributedString(string: string)
        //1.正则过滤 [xxx] 的表情文字
        let pattern = "\\[.*?\\]"
        
        guard let regx = try? NSRegularExpression(pattern: pattern, options: []) else {
            return attrStr
        }
        
        //2. 字符串全量匹配
        let matchs = regx.matches(in: string, options: [], range: NSRange(location: 0, length: attrStr.length))
        
        //3. 所有匹配结果(倒序)
        /**图片替换 - 必须倒序遍历！(*类比算法的字符串替换*)
              今天[小蠢驴]来[打代码]
              
              r1 = {2,5}
              r2 = {9,5}
              
              - 正序查找,替换之后，原始字符串长度会变
              今天[小蠢驴的图片]来[打代码]
              
              ==> r2 就找不到 [打代码] 的范围了
              
              - 倒序查找
              今天[小蠢驴]来[打代码的图片]
              
              ==> r1 的{2,5} 对应的还是range还是正确的
        */
        for result in matchs.reversed(){
            let range = result.range(at: 0)
            let subStr = (attrStr.string as NSString).substring(with: range)

            //查找[xxx] 对应的 表情
            if let model = findEmoji(string: subStr){
                attrStr.replaceCharacters(in: range, with: model.imageText(font: font))
            }
        }
        
        //统一设置属性&颜色
        attrStr.addAttributes([NSAttributedString.Key.font : font,
                               NSAttributedString.Key.foregroundColor: UIColor.darkGray],
                              range: NSRange(location: 0, length: attrStr.length))
        return attrStr
    }
}
