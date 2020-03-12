//
//  MNVisitorView.swift
//  MNWeibo
//
//  Created by miniLV on 2020/3/12.
//  Copyright © 2020 miniLV. All rights reserved.
//

import UIKit

class MNVisitorView: UIView {

    /// set visitor view
    /// - Parameter dic: [imageName / message]
    /// Home Page ==> imageName = ""
    var visitorInfo:[String:String]?{
        didSet{
            guard let imageName = visitorInfo?["imageName"] ,
                let message = visitorInfo?["message"] else{
                    print("visitorInfo contain nil")
                    return
            }
            
            if imageName == "" {
                print("is home page")
                return
            }
            iconView.image = UIImage(named: imageName)
            tipLabel.text = message
            
            //not home page
            houseView.isHidden = true
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: private
    private lazy var iconView = UIImageView(image: (UIImage (named: "visitordiscover_feed_image_smallicon")))
    
    internal lazy var maskIconView = UIImageView(image: (UIImage (named: "visitordiscover_feed_mask_smallicon")))
    
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
        backgroundColor = UIColor.cz_color(withHex: 0xEDEDED)
        
        addSubview(iconView)
        addSubview(maskIconView)
        addSubview(houseView)
        addSubview(tipLabel)
        addSubview(registerButton)
        addSubview(loginButton)
        
        tipLabel.textAlignment = .center
        
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
        addConstraint(NSLayoutConstraint(item: tipLabel,
                                         attribute: .width,
                                         relatedBy: .equal,
                                         toItem: nil,
                                         attribute:.notAnAttribute,
                                         multiplier: 1,
                                         constant: 240))
        
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
                                         constant: 0))
        //maskView - VFL
        let viewDic = ["maskIconView":maskIconView,
                       "registerButton":registerButton]
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "H:|-0-[maskIconView]-0-|",
            options: [],
            metrics: nil,
            views: viewDic))
        
        //FIXME:25 ==> button height
        let metrics = ["spacing":25]
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "V:|-0-[maskIconView]-(spacing)-[registerButton]",
            options: [],
            metrics: metrics,
            views: viewDic))
    }
}
