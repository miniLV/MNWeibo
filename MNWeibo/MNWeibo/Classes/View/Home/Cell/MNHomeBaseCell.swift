//
//  MNHomeBaseCell.swift
//  MNWeibo
//
//  Created by miniLV on 2020/3/29.
//  Copyright © 2020 miniLV. All rights reserved.
//

import UIKit

@objc protocol MNHomeCellDelegate {
    @objc optional func homeCellDidClickUrlString(cell: MNHomeBaseCell, urlStr: String)
}

class MNHomeBaseCell: UITableViewCell {

    var viewModel: MNStatusViewModel?{
        didSet{

        }
    }
    
    var avatarImage = UIImageView()
    var nameLabel = UILabel()
    var levelIconView = UIImageView(image: UIImage(named: "common_icon_membership"))
    var timeLabel = UILabel()
    var sourceLabel = UILabel()
    var vipIconView = UIImageView(image: UIImage(named: "avatar_enterprise_vip"))
    var contentLabel = MNLabel()
    var repostLabel = MNLabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentLabel.delegate = self
        repostLabel.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    weak var delegate:MNHomeCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension MNHomeBaseCell : MNLabelDelegate{
    
    func labelDidSelectedLinkText(label: MNLabel, text: String) {
        if !text.hasPrefix("http"){
            return
        }
        delegate?.homeCellDidClickUrlString?(cell: self, urlStr: text)
    }
}
