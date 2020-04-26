//
//  MNStatusViewModel.swift
//  MNWeibo
//
//  Created by miniLV on 2020/3/24.
//  Copyright © 2020 miniLV. All rights reserved.
//

import UIKit

/// 单条微博数据
let homeCellAvatarHeight = MNLayout.Layout(38)

class MNStatusViewModel: CustomStringConvertible {

    var status: MNStatusModel
    
    //会员等级
    var levelIcon: UIImage?
    
    var vipIcon: UIImage?
    
    //字符串 - “转发”
    var repostTitle: String?
    
    var commentTitle: String?
    
    var likeTitle: String?
    
    var pictureViewSize = CGSize()
    
    var rowHeight:CGFloat = 0
    
    /// 正文内容 - 属性文本
    var statusAttrText: NSAttributedString?{
        let originFontSize = UIFont.systemFont(ofSize: MNLayout.Layout(15))
        return MNEmojiManager.shared.getEmojiString(string: status.text ?? "", font: originFontSize)
    }

    /// 转发微博的属性文本
    var repostAttrText: NSAttributedString?{
        let str1 = "@" + (status.retweeted_status?.user?.screen_name ?? "")
        let str2 = ":" + (status.retweeted_status?.text ?? "")
        let resultStr = str1 + str2
        let repostFontSize = UIFont.systemFont(ofSize: MNLayout.Layout(14))
        return MNEmojiManager.shared.getEmojiString(string: resultStr, font: repostFontSize)
    }
    
    //原创&被转发微博
    var picUrls:[MNStatusPicture]?{
        //如果有被转发的微博 ==> 返回被转发的微博配图
        //如果没有被转发的微博 ==> 返回原创微博配图
        return status.retweeted_status?.pic_urls ?? status.pic_urls
    }
    
    init(model:MNStatusModel) {
        self.status = model
        
        getLevelIcon(model: model)
        getVipIcon(model: model)
        getToolCountString(model:model)
        getPictureViewSize(model: model)
        getRowHeigth()
    }
    
    private func getLevelIcon(model: MNStatusModel){
        //common_icon_membership_level1~6
        let maxLevel = 6
        guard let rank = model.user?.mbrank else{
            return
        }
        if (rank > 0) && (rank <= maxLevel) {
            let imageName = "common_icon_membership_level\(rank)"
            levelIcon = UIImage(named: imageName)
        }
    }
    
    private func getVipIcon(model: MNStatusModel){
        // 认证类型（-1:没有认证, 0:认证用户, 2,3,5:企业认证, 220:达人）
        switch model.user?.verified_type ?? -1{
        case 0:
            vipIcon = UIImage(named: "avatar_vip")
        case 2, 3, 5:
            vipIcon = UIImage(named: "avatar_enterprise_vip")
        case 220:
            vipIcon = UIImage(named: "avatar_grassroot")
        default:
            print("没有认证")
        }
    }
    
    private func getToolCountString(model: MNStatusModel){
        repostTitle = countSting(count: model.reposts_count, defaultStr: " 转发")
        commentTitle = countSting(count: model.comments_count, defaultStr: " 评论")
        likeTitle = countSting(count: model.attitudes_count, defaultStr: " 点赞")
    }
    
    private func countSting(count:Int, defaultStr: String) -> String{
        
        if count == 0{
            return defaultStr
        }
        if count < 10000{
            return count.description
        }
        
        return String(format: "%.02f万", Double(count) / 10000)
    }
    
    private func getPictureViewSize(model: MNStatusModel){
        //有转发的计算转发图片视图，有原创计算原创图片
        pictureViewSize = calPicturesSize(count: picUrls?.count ?? 0)
    }
    
    private func calPicturesSize(count: Int) -> CGSize{
        
        if count == 0{
            return CGSize()
        }
        
        //calcalate height
        let row = (count - 1) / Int(MNPictureMaxPerLine) + 1
        
        //顶部间距
        var height = MNStatusPictureOutterMargin
        //item总和的高度
        height += CGFloat(row) * MNPictureItemWidth
        //item之间的内边距
        height += CGFloat(row - 1) * MNStatusPictureInnerMargin
        
        return CGSize(width: MNPictureItemWidth, height: height)
    }
    
    ///网络缓存的单张图片大小
    func updateSingleImageSize(image:UIImage){
        var size = image.size
        
        //handle width image
        let maxImageWidth:CGFloat = MNLayout.Layout(250)
        if size.width > maxImageWidth{
            size.width = maxImageWidth
            size.height = size.width * image.size.height / image.size.width
        }
        
        //太窄图片处理
        let minImageWidth:CGFloat = MNLayout.Layout(40)
        //如果宽高比过大，可能图片会特别长，所以这里除以一个缩放倍数
        let zoomFactor:CGFloat = 4.0
        if size.width < minImageWidth{
            size.width = minImageWidth
            size.height = size.width * image.size.height / image.size.width / zoomFactor
        }
        
        //handle long image(超长图片的处理)
        let maxImageHeight:CGFloat = MNLayout.Layout(320)
        if size.height > maxImageHeight{
            size.height = maxImageWidth
            size.width = size.height * image.size.width / image.size.height
        }
        
        // 实际的cell，会有一个12的间距
        size.height += MNStatusPictureOutterMargin
        
        pictureViewSize = size
        
        getRowHeigth()
    }
    
    func getRowHeigth(){
        let margin: CGFloat = MNStatusPictureOutterMargin
        var height:CGFloat = 0
        let width = UIScreen.mn_screenW - 2 * margin
        let bottomViewHeight = MNLayout.Layout(35)
        //原创微博 = 顶部分割线(12) + margin(12) + 头像图片(34) + margin(12) + 正文内容(计算) + 配图高度(计算) + margin(12) + 底部视图(35)
        //转发微博 = 顶部分割线(12) + margin(12) + 头像图片(34) + margin(12) + 正文内容(计算) + margin(12) + margin(12) + 配图高度(计算) + margin(12) + 底部视图(35)
        
        //顶部视图
        height = margin * 2 + homeCellAvatarHeight + margin
        let textSize = CGSize(width:width, height: CGFloat.greatestFiniteMagnitude)

        //calcute content label size
        if let text = statusAttrText{
            height += text.boundingRect(with: textSize, options: [.usesLineFragmentOrigin], context: nil).height
        }
        
        //repost
        if status.retweeted_status != nil{
            height += (margin * 2)
            
            if let text = repostAttrText{
                height += text.boundingRect(with: textSize, options: [.usesLineFragmentOrigin], context: nil).height
            }
        }
        
        // pictureview
        height += pictureViewSize.height
        // bottom view
        height += margin
        height += bottomViewHeight
        
        rowHeight = height
    }
    
    var description: String{
        return status.description
    }
}
