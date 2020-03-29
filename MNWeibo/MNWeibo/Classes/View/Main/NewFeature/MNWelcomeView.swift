//
//  MNWelcomeView.swift
//  MNWeibo
//
//  Created by miniLV on 2020/3/22.
//  Copyright © 2020 miniLV. All rights reserved.
//

import UIKit
import SnapKit
import SDWebImage

class MNWelcomeView: UIView {
    
    lazy var avatarImageView = UIImageView(image: UIImage(named: "avatar_default_big"))
    lazy var label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.orange
        setupSubviews()
        updateAvatar()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubviews(){
        
        let backgroundImageView = UIImageView(image: UIImage(named: "ad_background"))
        addSubview(backgroundImageView)
        backgroundImageView.snp.makeConstraints {
            $0.left.right.bottom.top.equalToSuperview()
        }
        
        let avatarImageViewWH = MNLayout.Layout(85)
        avatarImageView.layer.cornerRadius = avatarImageViewWH * 0.5
        avatarImageView.layer.masksToBounds = true
        backgroundImageView.addSubview(avatarImageView)
        avatarImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.size.equalTo(avatarImageViewWH)
            $0.bottom.equalTo(-MNLayout.Layout(160))
        }
        
        label.text = "欢迎归来"
        label.alpha = 0
        backgroundImageView.addSubview(label)
        label.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo((avatarImageView.snp.bottom)).offset(MNLayout.Layout(15))
        }
    }
    
    private func updateAvatar(){
        guard let urlString = MNNetworkManager.shared.userAccount.avatar_large,
        let url = URL(string: urlString) else {
            return
        }

        avatarImageView.sd_setImage(with: url, placeholderImage: UIImage(named: "avatar_default_big"))
    }
    
    //表示试图已经显示
    override func didMoveToWindow() {
        super.didMoveToWindow()
        // 按照当前约束 - 更新控件位置
        self.layoutIfNeeded()
        self.avatarImageView.snp.updateConstraints {
            $0.bottom.equalTo(-MNLayout.Layout(360))
        }
        
        UIView.animate(withDuration: 1.0, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0, options: [], animations: {
            
            //更新变化的约束 - avatarImageView上移
            self.layoutIfNeeded()
            
        }) { (_) in

            UIView.animate(withDuration: 1, animations: {
                self.label.alpha = 1
            }) { (_) in
                self.removeFromSuperview()
            }
        }
    }
}
