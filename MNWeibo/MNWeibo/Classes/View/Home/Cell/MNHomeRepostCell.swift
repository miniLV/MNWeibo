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
    //转发内容
    var repostButton = UIButton()
    
    //toolButton
    var bottomView:MNStatusToolView = MNStatusToolView(parentView: nil)
    
    var contentPictureView = MNStatusPictureView(parentView: nil, topView: nil, bottomView: nil)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func setupSubviews(){
        let topLineView = UIView()
        topLineView.backgroundColor = UIColor.cz_color(withHex: 0xf2f2f2)
        addSubview(topLineView)
        topLineView.snp.makeConstraints { (make) in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(MNLayout.Layout(12))
        }
        
        addSubview(avatarImage)
        avatarImage.snp.makeConstraints { (make) in
            make.left.equalTo(MNLayout.Layout(12))
            make.top.equalTo(topLineView.snp.bottom).offset(MNLayout.Layout(12))
            make.size.equalTo(MNLayout.Layout(34))
        }
        
        nameLabel.textColor =  UIColor.cz_color(withHex: 0xfc3e00)
        nameLabel.font = UIFont.systemFont(ofSize: MNLayout.Layout(15))
        addSubview(nameLabel)
        nameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(avatarImage.snp.top).offset(MNLayout.Layout(4))
            make.left.equalTo(avatarImage.snp.right).offset(MNLayout.Layout(12))
        }
        
        addSubview(levelIconView)
        levelIconView.snp.makeConstraints { (make) in
            make.centerY.equalTo(nameLabel)
            make.left.equalTo(nameLabel.snp.right).offset(MNLayout.Layout(3))
            make.size.equalTo(MNLayout.Layout(14))
        }
        
        timeLabel.textColor = UIColor.cz_color(withHex: 0xfc6c00)
        timeLabel.font = UIFont.systemFont(ofSize: MNLayout.Layout(10))
        addSubview(timeLabel)
        timeLabel.snp.makeConstraints { (make) in
            make.left.equalTo(nameLabel)
            make.bottom.equalTo(avatarImage.snp.bottom)
        }
        
        sourceLabel.textColor = UIColor.cz_color(withHex: 0x828282)
        sourceLabel.font = UIFont.systemFont(ofSize: MNLayout.Layout(10))
        addSubview(sourceLabel)
        sourceLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(timeLabel)
            make.left.equalTo(timeLabel.snp.right).offset(MNLayout.Layout(8))
        }
        
        addSubview(vipIconView)
        vipIconView.snp.makeConstraints { (make) in
            make.size.equalTo(MNLayout.Layout(14))
            make.centerX.equalTo(avatarImage.snp.right).offset(-MNLayout.Layout(4))
            make.centerY.equalTo(avatarImage.snp.bottom).offset(-MNLayout.Layout(4))
        }
        
        bottomView = MNStatusToolView(parentView: self)
        

        contentLabel.numberOfLines = 0
        contentLabel.textAlignment = .left
        contentLabel.font = UIFont.systemFont(ofSize: MNLayout.Layout(15))
        contentLabel.textColor = UIColor.darkGray
        addSubview(contentLabel)
        contentLabel.snp.makeConstraints { (make) in
            make.left.equalTo(avatarImage)
            make.top.equalTo(avatarImage.snp.bottom).offset(MNLayout.Layout(12))
            make.right.equalToSuperview().offset(-MNLayout.Layout(12))
        }
        

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
