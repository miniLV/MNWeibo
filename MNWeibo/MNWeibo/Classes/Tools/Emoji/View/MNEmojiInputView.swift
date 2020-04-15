//
//  MNEmojiInputView.swift
//  MNWeibo
//
//  Created by miniLV on 2020/4/15.
//  Copyright © 2020 miniLV. All rights reserved.
//

import UIKit

class MNEmojiInputView: UIView {
    
    var keyboardHeight:CGFloat = 254.0
    
    init() {
        super.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: keyboardHeight))
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

private extension MNEmojiInputView{
    func setupUI() {
        let toolbar = MNEmojiToolbar()
        toolbar.backgroundColor = UIColor.lightGray
        addSubview(toolbar)
        toolbar.snp.makeConstraints { (make) in
            make.left.bottom.right.equalToSuperview()
            make.height.equalTo(kMNEmojiToolbarHeight)
        }
        
//        let collectionView = UICollectionView()
        let collectionView = UIView()
        addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.left.right.top.equalToSuperview()
            make.bottom.equalTo(toolbar.snp.top)
        }
    }
}
