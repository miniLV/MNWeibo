//
//  UIButton+Tool.swift
//  MNWeibo
//
//  Created by miniLV on 2020/3/28.
//  Copyright © 2020 miniLV. All rights reserved.
//

import Foundation

enum toolButtonType{
    case repost
    case comments
    case like
}

extension UIButton{
    
    func mn_toolButton(type:toolButtonType){
        
        switch type {
        case .repost:
            self.setTitle(" 转发", for: .normal)
            self.setImage(UIImage(named: "timeline_icon_retweet"), for: .normal)
        case .comments:
            self.setTitle(" 评论", for: .normal)
            self.setImage(UIImage(named: "timeline_icon_comment"), for: .normal)
        case .like:
            self.setTitle(" 点赞", for: .normal)
            self.setImage(UIImage(named: "timeline_icon_unlike"), for: .normal)
            self.setImage(UIImage(named: "timeline_icon_like"), for: .selected)
        }
        self.setTitleColor(UIColor.darkGray, for: .normal)
        self.titleLabel?.font = UIFont.systemFont(ofSize: MNLayout.Layout(13))
    }
    
}
