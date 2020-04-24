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
    
    /// 表情按钮长按的提示视图
    var tipView = MNEmojiTipView()
    
    override init(frame: CGRect) {
        super.init(frame: CGRect())
        setupUI()
        contentView.backgroundColor = UIColor.white
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 视图remove的时候，willMove函数一样会触发
    override func willMove(toWindow newWindow: UIWindow?) {
        super.willMove(toWindow: newWindow)
        
        guard let window = newWindow else {
            return
        }
        tipView.isHidden = true
        window.addSubview(tipView)
    }
    
    @objc private func clickEmojiBtn(button:UIButton){
        let tag = button.tag
        //判断是否是删除按钮
        var model:MNEmojiModel?
        if tag < (emojiModels?.count ?? 0){
            model = emojiModels?[tag]
        }
        deleagage?.emojiCellSelectedEmoji(cell: self, model: model)
    }
    
    @objc private func longGesture(gesture: UILongPressGestureRecognizer){
        
        let location = gesture.location(in: self)
        guard let button = getButtonFromLocation(location: location) else{
            tipView.isHidden = true
            return
        }
        
        //手势处理
        switch gesture.state {
        case .began, .changed:
            tipView.isHidden = false
            
            //坐标系转换()
            let center = self.convert(button.center, to: window)
            tipView.center = center
            
            guard let models = emojiModels else {
                return
            }
            if button.tag < models.count{
                tipView.emojiModel = models[button.tag]
            }
        case .cancelled, .failed:
            tipView.isHidden = true
        case .ended:
            tipView.isHidden = true
            clickEmojiBtn(button: button)
        default:
            break
        }
    }
    
    private func getButtonFromLocation(location: CGPoint) -> UIButton?{
        
        for btn in contentView.subviews{
            if !btn.isMember(of: UIButton.self){
                continue
            }
            
            let q1 = !btn.isHidden
            let q2 = btn.frame.contains(location)
            //最后一个按钮 ==> 删除按钮
            let q3 = btn != contentView.subviews.last
            if q1 && q2 && q3 {
                return (btn as? UIButton)
            }
        }
        return nil
    }
}


private extension MNEmojiCell{
    func setupUI() {
        //一列最多7个
        let columnsNum = 7
        //最多3行
        let rowsNum = 3
        
        let tempWidth:CGFloat = UIScreen.mn_screenW
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
        
        //长按手势
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(longGesture))
        addGestureRecognizer(longPress)
        
        //handle last delete button
        guard let deleteBtn = contentView.subviews.last as? UIButton else{
            return
        }
        let image = UIImage(named: "compose_emotion_delete_highlighted", in: MNEmojiManager.shared.bundle, compatibleWith: nil)
        deleteBtn.setImage(image, for: .normal)
    }
}
