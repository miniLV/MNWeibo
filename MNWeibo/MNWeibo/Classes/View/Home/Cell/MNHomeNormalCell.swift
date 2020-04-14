//
//  MNHomeNormalCell.swift
//  MNWeibo
//
//  Created by miniLV on 2020/3/24.
//  Copyright © 2020 miniLV. All rights reserved.
//

import UIKit

class MNHomeNormalCell: MNHomeBaseCell {
    override func setupSubviews() {
        super.setupSubviews()
        contentPictureView = MNStatusPictureView(parentView: self,
                                                 topView: contentLabel,
                                                 bottomView: bottomView)
    }
}


