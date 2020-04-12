//
//  MNHomeNormalCell.swift
//  MNWeibo
//
//  Created by miniLV on 2020/3/24.
//  Copyright © 2020 miniLV. All rights reserved.
//

import UIKit

class MNHomeNormalCell: MNHomeBaseCell {

    override var viewModel: MNStatusViewModel?{
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
            contentPictureView.viewModel = viewModel
            
            sourceLabel.text = viewModel?.status.source
//            timeLabel.text = viewModel?.sourceStr
            
        }
    }
    var avatarImage = UIImageView()
    var nameLabel = UILabel()
    var levelIconView = UIImageView(image: UIImage(named: "common_icon_membership"))
    var timeLabel = UILabel()
    var sourceLabel = UILabel()
    var vipIconView = UIImageView(image: UIImage(named: "avatar_enterprise_vip"))
    var contentLabel = MNLabel()
    
    //toolButton
    var bottomView:MNStatusToolView = MNStatusToolView(parentView: nil)
    
    var contentPictureView = MNStatusPictureView(parentView: nil, topView: nil, bottomView: nil)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubviews()
        // 异步绘制
        self.layer.drawsAsynchronously = true
        //栅格化 - 绘制之后生产独立的图像, 停止滚动可以交互
        self.layer.shouldRasterize = true
        //指定分辨率
        self.layer.rasterizationScale = UIScreen.main.scale
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
        
        contentPictureView = MNStatusPictureView(parentView: self,
                                                 topView: contentLabel,
                                                 bottomView: bottomView)
        
    }
}


