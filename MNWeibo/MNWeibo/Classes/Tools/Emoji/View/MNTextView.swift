//
//  MNTextView.swift
//  MNWeibo
//
//  Created by miniLV on 2020/4/15.
//  Copyright © 2020 miniLV. All rights reserved.
//

import UIKit

class MNTextView: UITextView {
    
    lazy var placeholderLabel = UILabel()
    
    init() {
        super.init(frame: CGRect(), textContainer: nil)
        setupUI()
        registerNoti()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        placeholderLabel.font = font
        placeholderLabel.sizeToFit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func registerNoti() {
        NotificationCenter.default.addObserver(self, selector: #selector(textViewDidChange), name: UITextView.textDidChangeNotification, object: nil)
    }
    
    @objc func textViewDidChange(){
        placeholderLabel.isHidden = hasText
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

extension MNTextView{
    func setupUI(){
        placeholderLabel.font = font
        placeholderLabel.text = "miniLV rua~"
        placeholderLabel.textColor = UIColor.lightGray
        placeholderLabel.sizeToFit()
        placeholderLabel.frame.origin = CGPoint(x: 5, y: 8)
        addSubview(placeholderLabel)
    }
}

extension MNTextView{
    ///往textView中插入表情符号，model = nil 表示执行的是 `删除`
    func insertEmoji(model: MNEmojiModel?) {
        guard let model = model else {
            //model = nil,删除文本
            deleteBackward()
            return
        }
        
        //emoji
        if let emojiStr = model.emojiStr,
            let textRange = selectedTextRange{
            replace(textRange, withText: emojiStr)
        }
        
        //表情图片
        guard let textFont = font else {
            return
        }
        
        let imageText = model.imageText(font: textFont)
        let attrStr = NSMutableAttributedString(attributedString: attributedText)
        
        //1.图片插入 - 光标所在位置
        let startRange = selectedRange
        attrStr.replaceCharacters(in: startRange, with: imageText)
        attributedText = attrStr
        
        //2.恢复之前光标位置
        selectedRange = NSRange(location: startRange.location + 1, length: 0)
        
        //2.1刷新文本变化的callback(insert 图片的时候要触发) - ”发布“按钮处理
        delegate?.textViewDidChange?(self)
        //2.2占位文字处理
        textViewDidChange()
    }
    
    /// 返回 TextView 对应的纯文本字符串(图片-> 文字)
    var emojiText: String{
        
        guard let attrStr = attributedText else {
            return ""
        }
        
        var result = ""
        
        attrStr.enumerateAttributes(in: NSRange(location: 0, length: attrStr.length), options: []) { (dic, range, _) in

            let attachmentKey = NSAttributedString.Key("NSAttachment")
            if let attachment = dic[attachmentKey] as? MNEmojiAttachment{
                result += attachment.chs ?? ""
            } else {
                let subString = (attrStr.string as NSString).substring(with: range)
                result += subString
            }
        }
        return result
    }
    
}
