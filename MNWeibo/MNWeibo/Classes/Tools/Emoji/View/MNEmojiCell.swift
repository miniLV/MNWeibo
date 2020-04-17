//
//  MNEmojiCell.swift
//  MNWeibo
//
//  Created by miniLV on 2020/4/15.
//  Copyright © 2020 miniLV. All rights reserved.
//

import UIKit

protocol MNEmojiCellDelegagte: NSObjectProtocol{
    /// 表情按钮点击
    /// model: 如果有值，选中的是表情，如果是nil，点击了删除按钮
    func emojiCellSelectedEmoji(cell:MNEmojiCell, model: MNEmojiModel?)
}

//和collectionView 一样大小的cell(放整页的表情)
class MNEmojiCell: UICollectionViewCell {
    
    weak var deleagage: MNEmojiCellDelegagte?
    
    ///当前page的表情模型数组(长度<= 20)
    var emojiModels: [MNEmojiModel]?{
        didSet{
            
            contentView.subviews.forEach{ $0.isHidden = true }
            //现实最后一个删除按钮
            contentView.subviews.last?.isHidden = false
            //set images
            for (index, model) in (emojiModels ?? []).enumerated() {
                guard let btn = contentView.subviews[index] as? UIButton else{
                    continue
                }
                //设置表情图片
                btn.setImage(model.image, for: .normal)
                //设置emoij字符串
                btn.setTitle(model.emojiStr, for: .normal)
                btn.isHidden = false
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: CGRect())
        setupUI()
        contentView.backgroundColor = UIColor.white
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func clickEmojiBtn(button:UIButton){
        print("i = \(button.tag)")
        let tag = button.tag
        
        //判断是否是删除按钮
        var model:MNEmojiModel?
        if tag < (emojiModels?.count ?? 0){
            model = emojiModels?[tag]
        }
        deleagage?.emojiCellSelectedEmoji(cell: self, model: model)
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
            btn.titleLabel?.font = UIFont.systemFont(ofSize: MNLayout.Layout(32))
            btn.frame = CGRect(x: x, y: y, width: width, height: height)
            btn.tag = i
            btn.addTarget(self, action: #selector(clickEmojiBtn(button:)), for: .touchUpInside)
            contentView.addSubview(btn)
        }
        
        //handle last delete button
        guard let deleteBtn = contentView.subviews.last as? UIButton else{
            return
        }
        let image = UIImage(named: "compose_emotion_delete_highlighted", in: MNEmojiManager.shared.bundle, compatibleWith: nil)
        deleteBtn.setImage(image, for: .normal)
    }
}
