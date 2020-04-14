//
//  MNHomeRepostCell.swift
//  MNWeibo
//
//  Created by miniLV on 2020/3/29.
//  Copyright © 2020 miniLV. All rights reserved.
//

import UIKit

class MNHomeRepostCell: MNHomeBaseCell {

    override var viewModel: MNStatusViewModel?{
        didSet{
            contentLabel.attributedText = viewModel?.statusAttrText
            repostLabel.attributedText = viewModel?.repostAttrText
            
            nameLabel.text = viewModel?.status.user?.screen_name
            levelIconView.image = viewModel?.levelIcon
            vipIconView.image = viewModel?.vipIcon
            
            avatarImage.mn_setImage(urlString: viewModel?.status.user?.profile_image_url,
                                    placeholderImage: UIImage(named: "avatar_default_big"),
                                    isAvatar: true)
            bottomView.viewModel = viewModel
            contentPictureView.viewModel = viewModel
        }
    }    

    override func setupSubviews(){
        super.setupSubviews()
        
        let repostButton = UIButton()
        repostButton.backgroundColor = UIColor.cz_color(withHex: 0xe3e3e3)
        addSubview(repostButton)
        repostButton.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(contentLabel.snp.bottom).offset(MNDefaultMargin)
            make.bottom.equalTo(bottomView.snp.top)
        }
                
        repostLabel.numberOfLines = 0
        repostLabel.textAlignment = .left
        repostLabel.font = UIFont.systemFont(ofSize: MNLayout.Layout(14))
        repostLabel.textColor = UIColor.darkGray
        repostLabel.text = "repostLabel"
        repostButton.addSubview(repostLabel)
        repostLabel.snp.makeConstraints { (make) in
            make.left.equalTo(MNDefaultMargin)
            make.top.equalToSuperview().offset(MNDefaultMargin)
            make.right.equalToSuperview().offset(-MNLayout.Layout(12))
        }
        
        contentPictureView = MNStatusPictureView(parentView: repostButton,
                                                 topView: repostLabel,
                                                 bottomView: nil)
        
    }
}
