//
//  MNWriteController.swift
//  MNWeibo
//
//  Created by miniLV on 2020/4/8.
//  Copyright © 2020 miniLV. All rights reserved.
//

import UIKit

class MNWriteController: UIViewController {

    var textView:UITextView = UITextView()
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
        
//        let userNameLabel = UILabel()
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
    }
    

    
    @objc func dismissVC(){
        dismiss(animated: true, completion: nil)
    }
}

private extension MNWriteController{
    func setupUI() {
        setNavigationBar()
        setupSubviews()
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
        textView.snp.makeConstraints { (make) in
            make.left.top.right.equalToSuperview()
            make.bottom.equalTo(toolBar.snp.top)
        }
        textView.text = "dakflkdjsalkfjlkdsjlafj ldakflkdjsalkfjlkdsjlafj ldakflkdjsalkfjlkdsjlafj ldakflkdjsalkfjlkdsjlafj ldakflkdjsalkfjlkdsjlafj ldakflkdjsalkfjlkdsjlafj ldakflkdjsalkfjlkdsjlafj ldakflkdjsalkfjlkdsjlafj ldakflkdjsalkfjlkdsjlafj ldakflkdjsalkfjlkdsjlafj ldakflkdjsalkfjlkdsjlafj ldakflkdjsalkfjlkdsjlafj ldakflkdjsalkfjlkdsjlafj ldakflkdjsalkfjlkdsjlafj ldakflkdjsalkfjlkdsjlafj ldakflkdjsalkfjlkdsjlafj l"
    }
    
    func setNavigationBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "关闭", target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: sendButton)
        navigationItem.titleView = titleView
//        titleView.userla
        userNameLabel.text = "saklfjkldsaj"
    }
    
    @objc func clickSendButton(){
        
    }
}
