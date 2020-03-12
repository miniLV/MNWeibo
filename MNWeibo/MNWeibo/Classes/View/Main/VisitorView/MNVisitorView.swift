//
//  MNVisitorView.swift
//  MNWeibo
//
//  Created by miniLV on 2020/3/12.
//  Copyright © 2020 miniLV. All rights reserved.
//

import UIKit

class MNVisitorView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: private
    private lazy var iconView = UIImageView(image: (UIImage (named: "visitordiscover_feed_image_smallicon")))
    private lazy var houseView = UIImageView(image:(UIImage (named: "visitordiscover_feed_image_house")))
    private lazy var tipLabel:UILabel = UILabel.cz_label(withText: "talk is cheep, show me the code",
                                                 fontSize: 16,
                                                 color: UIColor.darkGray)
    private lazy var registerButton:UIButton = UIButton.cz_textButton("注册",
                                                             fontSize: 16,
                                                             normalColor: UIColor.orange,
                                                             highlightedColor: UIColor.black,
                                                             backgroundImageName: "common_button_white_disable")

    private lazy var loginButton:UIButton = UIButton.cz_textButton("登录",
                                                             fontSize: 16,
                                                             normalColor: UIColor.orange,
                                                             highlightedColor: UIColor.black,
                                                             backgroundImageName: "common_button_white_disable")
}

extension MNVisitorView{
    
    func setupUI() {
        backgroundColor = UIColor.white
        
        addSubview(iconView)
        addSubview(houseView)
        addSubview(tipLabel)
        addSubview(registerButton)
        addSubview(loginButton)
        
        for item in subviews {
            item.translatesAutoresizingMaskIntoConstraints = false
        }
        
        //setup autolayou
        setupLayoutConstraint()
    }
    
    private func setupLayoutConstraint(){
        let margin:CGFloat = 20
        //iconView
        addConstraint(NSLayoutConstraint(item: iconView,
                                         attribute: .centerX,
                                         relatedBy: .equal,
                                         toItem: self,
                                         attribute: .centerX,
                                         multiplier: 1,
                                         constant: 0))
        addConstraint(NSLayoutConstraint(item: iconView,
                                         attribute: .centerY,
                                         relatedBy: .equal,
                                         toItem: self,
                                         attribute: .centerY,
                                         multiplier: 1,
                                         constant: -60))
        
        //houseView
        addConstraint(NSLayoutConstraint(item: houseView,
                                         attribute: .centerX,
                                         relatedBy: .equal,
                                         toItem: self,
                                         attribute: .centerX,
                                         multiplier: 1,
                                         constant: 0))
        addConstraint(NSLayoutConstraint(item: houseView,
                                         attribute: .centerY,
                                         relatedBy: .equal,
                                         toItem: self,
                                         attribute: .centerY,
                                         multiplier: 1,
                                         constant: -60))
        //tiplabel
        addConstraint(NSLayoutConstraint(item: tipLabel,
                                         attribute: .centerX,
                                         relatedBy: .equal,
                                         toItem: self,
                                         attribute:.centerX,
                                         multiplier: 1,
                                         constant: 0))
        addConstraint(NSLayoutConstraint(item: tipLabel,
                                         attribute: .top,
                                         relatedBy: .equal,
                                         toItem: iconView,
                                         attribute:.bottom,
                                         multiplier: 1,
                                         constant: margin))
        //register button
        addConstraint(NSLayoutConstraint(item: registerButton,
                                         attribute: .left,
                                         relatedBy: .equal,
                                         toItem: tipLabel,
                                         attribute:.left,
                                         multiplier: 1,
                                         constant: 0))
        addConstraint(NSLayoutConstraint(item: registerButton,
                                         attribute: .top,
                                         relatedBy: .equal,
                                         toItem: tipLabel,
                                         attribute:.bottom,
                                         multiplier: 1,
                                         constant: margin))
        addConstraint(NSLayoutConstraint(item: registerButton,
                                         attribute: .width,
                                         relatedBy: .equal,
                                         toItem: nil,
                                         attribute:.notAnAttribute,
                                         multiplier: 1,
                                         constant: 100))
        //login button
        addConstraint(NSLayoutConstraint(item: loginButton,
                                         attribute: .right,
                                         relatedBy: .equal,
                                         toItem: tipLabel,
                                         attribute:.right,
                                         multiplier: 1,
                                         constant: 0))
        addConstraint(NSLayoutConstraint(item: loginButton,
                                         attribute: .top,
                                         relatedBy: .equal,
                                         toItem: registerButton,
                                         attribute:.top,
                                         multiplier: 1,
                                         constant: 0))
        addConstraint(NSLayoutConstraint(item: loginButton,
                                         attribute: .width,
                                         relatedBy: .equal,
                                         toItem: registerButton,
                                         attribute:.width,
                                         multiplier: 1,
                                         constant: 0`))
    }
}
