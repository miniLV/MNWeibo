//
//  MNEmojiToolbar.swift
//  MNWeibo
//
//  Created by miniLV on 2020/4/15.
//  Copyright © 2020 miniLV. All rights reserved.
//

import UIKit

let kMNEmojiToolbarHeight:CGFloat = 40
class MNEmojiToolbar: UIView {
    
    init() {
        super.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: kMNEmojiToolbarHeight))
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let btnCount = subviews.count
        let width = bounds.width / CGFloat(btnCount)
        
        for (index, btn) in subviews.enumerated(){
            let x = CGFloat(index) * width
            btn.frame = CGRect(x: x, y: 0, width: width, height: bounds.height)
        }
    }
}

private extension MNEmojiToolbar{
    func setupUI() {
        
        for package in MNEmojiManager.shared.packages{
            
            let btn = UIButton()
            btn.setTitle(package.groupName, for: .normal)
            btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
            btn.setTitleColor(.white, for: .normal)
            btn.setTitleColor(.darkGray, for: .highlighted)
            btn.setTitleColor(.darkGray, for: .selected)
            
            //set btn image
            let normalImageName = "compose_emotion_table_\(package.bgImageName ?? "")_normal"
            let selectedImageName = "compose_emotion_table_\(package.bgImageName ?? "")_selected"
            var normalImage = UIImage(named:normalImageName , in: MNEmojiManager.shared.bundle, compatibleWith: nil)
            var selectedImage = UIImage(named:selectedImageName , in: MNEmojiManager.shared.bundle, compatibleWith: nil)
            
            //图片拉伸处理 ==> 以中心点拉伸图片
            let size = selectedImage?.size ?? CGSize()
            let inset = UIEdgeInsets(top: size.height * 0.5,
                                     left: size.width * 0.5,
                                     bottom: size.height * 0.5,
                                     right: size.width * 0.5)
            normalImage = normalImage?.resizableImage(withCapInsets: inset)
            selectedImage = selectedImage?.resizableImage(withCapInsets: inset)
            
            btn.setBackgroundImage(normalImage, for: .normal)
            btn.setBackgroundImage(selectedImage, for: .selected)
            btn.setBackgroundImage(selectedImage, for: .highlighted)
            
            addSubview(btn)
        }
    }
}
