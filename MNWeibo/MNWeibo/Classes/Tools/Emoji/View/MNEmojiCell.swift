//
//  MNEmojiCell.swift
//  MNWeibo
//
//  Created by miniLV on 2020/4/15.
//  Copyright © 2020 miniLV. All rights reserved.
//

import UIKit

//和collectionView 一样大小的cell(放整页的表情)
class MNEmojiCell: UICollectionViewCell {
    
    var titleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: CGRect())
        setupUI()
//        addSubview(titleLabel)
//        titleLabel.textColor = UIColor.blue
//        titleLabel.center = self.center
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


private extension MNEmojiCell{
    func setupUI() {
        //一列最多7个
        let columnsNum = 7
        //最多3行
        let rowsNum = 3
        
        let tempWidth:CGFloat = 320
        let tempHeight:CGFloat = 214
        let leftMargin:CGFloat = 8
        let bottomMargin:CGFloat = 16
        let width = (tempWidth - 2 * leftMargin) / CGFloat(columnsNum)
        let height = (tempHeight - bottomMargin) / CGFloat(rowsNum)
        
        for i in 0...MNEmojiManager.shared.pageCells {
            let row = i / columnsNum
            let column = i % columnsNum
            let x = leftMargin + CGFloat(column) * width
            let y = CGFloat(row) * height
            let btn = UIButton()
            btn.frame = CGRect(x: x, y: y, width: width, height: height)
            btn.backgroundColor = UIColor.cz_random()
            addSubview(btn)
        }
    }
}
