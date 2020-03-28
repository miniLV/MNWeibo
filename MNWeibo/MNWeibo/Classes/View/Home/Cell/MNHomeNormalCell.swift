//
//  MNHomeNormalCell.swift
//  MNWeibo
//
//  Created by miniLV on 2020/3/24.
//  Copyright © 2020 miniLV. All rights reserved.
//

import UIKit

class MNHomeNormalCell: UITableViewCell {

    var viewModel: MNStatusViewModel?{
        didSet{
            contentLabel.text = viewModel?.status.text
            nameLabel.text = viewModel?.status.user?.screen_name
            //提前计算好
            levelIconView.image = viewModel?.levelIcon
            vipIconView.image = viewModel?.vipIcon
            
            avatarImage.mn_setImage(urlString: viewModel?.status.user?.profile_image_url,
                                    placeholderImage: UIImage(named: "avatar_default_big"),
                                    isAvatar: true)
            bottomView.viewModel = viewModel
        }
    }
    var avatarImage = UIImageView()
    var nameLabel = UILabel()
    var levelIconView = UIImageView(image: UIImage(named: "common_icon_membership"))
    var timeLabel = UILabel()
    var sourceLabel = UILabel()
    var vipIconView = UIImageView(image: UIImage(named: "avatar_enterprise_vip"))
    var contentLabel = UILabel()
    
    //toolButton
    var bottomView:MNStatusToolView = MNStatusToolView(parentView: nil)
    
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
            make.height.equalTo(MNLayout.Layout(8))
        }
        
        addSubview(avatarImage)
        avatarImage.snp.makeConstraints { (make) in
            make.left.equalTo(MNLayout.Layout(11))
            make.top.equalTo(MNLayout.Layout(12))
            make.size.equalTo(MNLayout.Layout(34))
        }
        
        nameLabel.textColor =  UIColor.cz_color(withHex: 0xfc3e00)
        nameLabel.font = UIFont.systemFont(ofSize: MNLayout.Layout(13))
        addSubview(nameLabel)
        nameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(avatarImage.snp_topMargin).offset(MNLayout.Layout(4))
            make.left.equalTo(avatarImage.snp_rightMargin).offset(MNLayout.Layout(11))
        }
        
        addSubview(levelIconView)
        levelIconView.snp.makeConstraints { (make) in
            make.centerY.equalTo(nameLabel)
            make.left.equalTo(nameLabel.snp_rightMargin).offset(MNLayout.Layout(10))
            make.size.equalTo(MNLayout.Layout(14))
        }
        
        timeLabel.textColor = UIColor.cz_color(withHex: 0xfc6c00)
        timeLabel.font = UIFont.systemFont(ofSize: MNLayout.Layout(10))
        addSubview(timeLabel)
        timeLabel.snp.makeConstraints { (make) in
            make.left.equalTo(nameLabel)
            make.bottom.equalTo(avatarImage.snp_bottomMargin)
        }
        
        sourceLabel.textColor = UIColor.cz_color(withHex: 0x828282)
        sourceLabel.font = UIFont.systemFont(ofSize: MNLayout.Layout(10))
        addSubview(sourceLabel)
        sourceLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(timeLabel)
            make.left.equalTo(timeLabel.snp_rightMargin).offset(MNLayout.Layout(8))
        }
        
        addSubview(vipIconView)
        vipIconView.snp.makeConstraints { (make) in
            make.size.equalTo(MNLayout.Layout(14))
            make.centerX.equalTo(avatarImage.snp_rightMargin).offset(MNLayout.Layout(5))
            make.centerY.equalTo(avatarImage.snp_bottomMargin).offset(MNLayout.Layout(5))
        }
        
        bottomView = MNStatusToolView(parentView: self)
        contentLabel.numberOfLines = 0
        contentLabel.textAlignment = .left
        contentLabel.font = UIFont.systemFont(ofSize: MNLayout.Layout(15))
        addSubview(contentLabel)
        contentLabel.snp.makeConstraints { (make) in
            make.left.equalTo(avatarImage)
            make.top.equalTo(avatarImage.snp_bottomMargin).offset(MNLayout.Layout(11))
            make.right.equalToSuperview().offset(-MNLayout.Layout(11))
            make.bottom.equalTo(bottomView.snp_topMargin).offset(-MNLayout.Layout(12))
        }
        
    }
    
 
}


