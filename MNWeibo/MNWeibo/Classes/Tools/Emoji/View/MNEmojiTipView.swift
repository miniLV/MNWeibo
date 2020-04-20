//
//  MNEmojiTipView.swift
//  MNWeibo
//
//  Created by miniLV on 2020/4/20.
//  Copyright © 2020 miniLV. All rights reserved.
//

import UIKit
import pop

class MNEmojiTipView: UIImageView {

    var emojiModel: MNEmojiModel?{
        didSet{
            if emojiModel == preEmojiModel{
                return
            }
            preEmojiModel = emojiModel
            tipButton.setTitle(emojiModel?.emojiStr, for: .normal)
            tipButton.setImage(preEmojiModel?.image, for: .normal)
            
            // 弹力动画
            let anim = POPSpringAnimation(propertyNamed: kPOPLayerPositionY)
            anim?.fromValue = 30
            anim?.toValue = 0
            anim?.springSpeed = 20
            anim?.springBounciness = 20
            tipButton.pop_add(anim, forKey: nil)
        }
    }
    
    private var preEmojiModel: MNEmojiModel?
    
    private lazy var tipButton = UIButton()
    
    init() {
        let bundle = MNEmojiManager.shared.bundle
        let image = UIImage(named: "emoticon_keyboard_magnifier", in: bundle, compatibleWith: nil)
        super.init(image: image)
        
        // 设置锚点调整位置
        layer.anchorPoint = CGPoint(x: 0.5, y: 1.2)
        
        tipButton.frame = CGRect(x: 0, y: 0, width: 36, height: 36)
        tipButton.center.x = bounds.width * 0.5
        tipButton.layer.anchorPoint = CGPoint(x: 0.5, y: 0)
        tipButton.setTitle("😄", for: .normal)
        tipButton.titleLabel?.font = UIFont.systemFont(ofSize: 32)
        addSubview(tipButton)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
