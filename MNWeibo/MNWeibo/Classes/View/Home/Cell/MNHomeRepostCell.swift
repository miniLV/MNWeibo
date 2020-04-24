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
            repostLabel.attributedText = viewModel?.repostAttrText
        }
    }    

    override func setupSubviews(){
        super.setupSubviews()
        
        let repostButton = UIButton()
        repostButton.backgroundColor = UIColor.init(rgb: 0xf7f7f7)
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
            make.right.equalToSuperview().offset(-MNLayout.Layout(MNStatusPictureOutterMargin))
        }
        
        contentPictureView = MNStatusPictureView(parentView: repostButton,
                                                 topView: repostLabel,
                                                 bottomView: nil)
        
    }
}
