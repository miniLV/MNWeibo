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
    
    init(model:MNStatusModel) {
        self.status = model
        
        getLevelIcon(model: model)
        getVipIcon(model: model)
        getToolCountString(model:model)
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
    
    var description: String{
        return status.description
    }
}
