//
//  MNEmojiLayout.swift
//  MNWeibo
//
//  Created by miniLV on 2020/4/15.
//  Copyright © 2020 miniLV. All rights reserved.
//

import UIKit

///表情键盘布局
class MNEmojiLayout: UICollectionViewFlowLayout {
    override func prepare() {
        super.prepare()
        
        guard let collectionView = collectionView else {
            return
        }
        collectionView.layoutIfNeeded()
        itemSize = collectionView.bounds.size
        
        //滚动方向
        scrollDirection = .horizontal
    }
}
