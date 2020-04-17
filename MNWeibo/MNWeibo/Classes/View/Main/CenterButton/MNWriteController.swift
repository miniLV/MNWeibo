//
//  MNWriteController.swift
//  MNWeibo
//
//  Created by miniLV on 2020/4/8.
//  Copyright © 2020 miniLV. All rights reserved.
//

import UIKit
import SVProgressHUD

class MNWriteController: UIViewController {

    var textView = MNTextView()
    var toolBar:UIToolbar = UIToolbar()
    lazy var sendButton:UIButton = {
        let btn = UIButton()
        btn.frame = CGRect(x: 0, y: 0, width: MNLayout.Layout(45), height: MNLayout.Layout(35))
        btn.titleLabel?.font = UIFont.systemFont(ofSize: MNLayout.Layout(14))
        btn.setTitle("发布", for: .normal)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.setTitleColor(UIColor.lightGray, for: .disabled)
        
        btn.setBackgroundImage(UIImage(named: "common_button_orange"), for: .normal)
        btn.setBackgroundImage(UIImage(named: "common_button_orange_highlighted"), for: .highlighted)
        btn.setBackgroundImage(UIImage(named: "common_button_white_disable"), for: .disabled)
        btn.addTarget(self, action: #selector(clickSendButton), for: .touchUpInside)
        return btn
    }()
    
    var userNameLabel = UILabel()
    
    lazy var emojiView: MNEmojiInputView = MNEmojiInputView { [weak self](emojiModel) in
        self?.insertEmoji(model: emojiModel)
    }
    
    lazy var titleView:UIView = {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: 100, height: 35)
        
        let topLabel = UILabel()
        topLabel.text = "发微博"
        topLabel.font = UIFont.systemFont(ofSize: MNLayout.Layout(13))
        view.addSubview(topLabel)
        topLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(MNLayout.Layout(10))
        }
        
        userNameLabel.text = "miniLV"
        userNameLabel.font = UIFont.systemFont(ofSize: MNLayout.Layout(12))
        userNameLabel.textColor = UIColor.lightGray
        view.addSubview(userNameLabel)
        userNameLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(topLabel.snp.bottom).offset(2)
        }
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        //键盘监听
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardChange(noti:)), name:UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        textView.becomeFirstResponder()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        textView.resignFirstResponder()
    }
    
    
    @objc func keyboardChange(noti:NSNotification){
        guard let rect = (noti.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue ,
        let duration = (noti.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue else{
            return
        }

        
        //更新工具条底部约束(工具栏上移操作)
         let offset = view.bounds.height - rect.origin.y + 40
        print("offset = \(offset)")
        toolBar.snp.updateConstraints { (make) in
            make.bottom.equalTo(-offset)
        }
        
        UIView.animate(withDuration: duration) {
            self.view.layoutIfNeeded()
        }
    }

    
    @objc func dismissVC(){
        dismiss(animated: true, completion: nil)
    }
    
    //点击表情键盘
    @objc func tapEmojiKeyboard(){
        //系统键盘 => textView.inputView = nil，这里是系统键盘和自定义键盘的切换
        textView.inputView = textView.inputView == nil ? emojiView : nil
        textView.reloadInputViews()
    }
    
    ///往textView中插入表情符号，model = nil 表示执行的是 `删除`
    func insertEmoji(model: MNEmojiModel?) {
        guard let model = model else {
            //model = nil,删除文本
            textView.deleteBackward()
            return
        }
        
        //emoji
        if let emojiStr = model.emojiStr,
            let textRange = textView.selectedTextRange{
            textView.replace(textRange, withText: emojiStr)
        }
        
        //表情图片
        guard let textFont = textView.font else {
            return
        }
        
        let imageText = model.imageText(font: textFont)
        let attrStr = NSMutableAttributedString(attributedString: textView.attributedText)
        
        //1.图片插入 - 光标所在位置
        let startRange = textView.selectedRange
        attrStr.replaceCharacters(in: startRange, with: imageText)
        textView.attributedText = attrStr
        
        //2.恢复之前光标位置
        textView.selectedRange = NSRange(location: startRange.location + 1, length: 0)
    }
}

private extension MNWriteController{
    func setupUI() {
        view.backgroundColor = UIColor.white
        setNavigationBar()
        setupSubviews()
        setupToolBar()
    }
    
    func setupToolBar() {
        let images = [["imageName": "compose_toolbar_picture"],
                      ["imageName": "compose_mentionbutton_background"],
                      ["imageName": "compose_trendbutton_background"],
                      ["imageName": "compose_emoticonbutton_background", "actionName": "tapEmojiKeyboard"],
                      ["imageName": "compose_add_background"]]
        
        var items = [UIBarButtonItem]()
        for obj in images{
            guard let imageName = obj["imageName"] else {
                continue
            }
            
            let normalImage = UIImage(named: imageName)
            let hightLightImage = UIImage(named: imageName + "_highlight")
            let btn = UIButton()
            btn.setImage(normalImage, for: .normal)
            btn.setImage(hightLightImage, for: .highlighted)
            btn.sizeToFit()
            
            //add event
            if let actionName = obj["actionName"]{
                btn.addTarget(self, action: Selector(actionName), for: .touchUpInside)
            }
            
            items.append(UIBarButtonItem(customView: btn))
            //添加弹簧
            items.append(UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil))
            
            
        }
        //删除最后一个弹簧 - 消除间隙
        items.removeLast()
        toolBar.items = items
    }
    func setupSubviews(){
        view.addSubview(toolBar)
        toolBar.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(44)
        }
        
        textView.keyboardDismissMode = .onDrag
        textView.bounces = true
        textView.alwaysBounceVertical = true
        view.addSubview(textView)
        textView.font = UIFont.systemFont(ofSize: MNLayout.Layout(14))
        textView.delegate = self
        textView.snp.makeConstraints { (make) in
            make.top.equalTo(64)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(toolBar.snp.top)
        }
    }
    
    func setNavigationBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "关闭", target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: sendButton)
        navigationItem.titleView = titleView
        userNameLabel.text = "saklfjkldsaj"
    }
    
    @objc func clickSendButton(){
        guard let text = textView.text else {
            print("text is nil")
            return
        }
        MNNetworkManager.shared.createStatus(text: text) { (json, isSuccess) in
            print("如果有权限 ==> 发布微博成功~")
            let message = isSuccess ? "发布成功" : "没有权限"
            //FIXME: If SVProgressHUD fix crash bug. need add HUD.
            //SVProgressHUD .show(withStatus: message)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                self.dismissVC()
            }
        }
    }
}

extension MNWriteController:UITextViewDelegate{
    func textViewDidChange(_ textView: UITextView) {
        sendButton.isEnabled = textView.hasText
    }
}
