//
//  MNWelcomeView.swift
//  MNWeibo
//
//  Created by miniLV on 2020/3/22.
//  Copyright © 2020 miniLV. All rights reserved.
//

import UIKit
import SnapKit



class MNWelcomeView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.orange
        
        setupSubviews()
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
        
        let avatarImageView = UIImageView(image: UIImage(named: "avatar_default_big"))
        backgroundImageView.addSubview(avatarImageView)
        avatarImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.size.equalTo(MNLayout.Layout(85))
            $0.bottom.equalTo(-MNLayout.Layout(160))
        }
        
        let label = UILabel()
        label.text = "欢迎归来"
        backgroundImageView.addSubview(label)
        label.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo((avatarImageView.snp_bottomMargin)).offset(MNLayout.Layout(15))
        }
        
    }
}
