//
//  MNStatusViewModel.swift
//  MNWeibo
//
//  Created by miniLV on 2020/3/24.
//  Copyright © 2020 miniLV. All rights reserved.
//

import UIKit

/// 单条微博数据
class MNStatusViewModel: CustomStringConvertible {

    var status: MNStatusModel
    
    //会员等级
    var levelIcon: UIImage?
    
    var vipIcon: UIImage?
    
    var repostStr: String?
    
    var commentStr: String?
    
    var likeStr: String?
    
    var pictureViewSize = CGSize()
    
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
        repostStr = countSting(count: model.reposts_count, defaultStr: " 转发")
        commentStr = countSting(count: model.comments_count, defaultStr: " 评论")
        likeStr = countSting(count: model.attitudes_count, defaultStr: " 点赞")
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
    
    var description: String{
        return status.description
    }
}
