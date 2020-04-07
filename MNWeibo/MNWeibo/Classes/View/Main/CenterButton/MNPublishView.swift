//
//  MNPublishView.swift
//  MNWeibo
//
//  Created by miniLV on 2020/4/4.
//  Copyright © 2020 miniLV. All rights reserved.
//

import UIKit

class MNPublishView: UIView {

    //每页最多6个按钮
    let pageCount = 6
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        backgroundColor = UIColor.clear
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let buttonInfos = [["imageName": "tabbar_compose_idea", "title": "文字", "clsName": "WBComposeViewController"],
                               ["imageName": "tabbar_compose_photo", "title": "照片/视频"],
                               ["imageName": "tabbar_compose_weibo", "title": "长微博"],
                               ["imageName": "tabbar_compose_lbs", "title": "签到"],
                               ["imageName": "tabbar_compose_review", "title": "点评"],
                               ["imageName": "tabbar_compose_more", "title": "更多", "actionName": "clickMore"],
                               ["imageName": "tabbar_compose_friend", "title": "好友圈"],
                               ["imageName": "tabbar_compose_wbcamera", "title": "微博相机"],
                               ["imageName": "tabbar_compose_music", "title": "音乐"],
                               ["imageName": "tabbar_compose_shooting", "title": "拍摄"]]
    
    func setupUI()  {
        let blurEffect = UIBlurEffect(style: .extraLight)
        let effectView = UIVisualEffectView(effect: blurEffect)
        effectView.frame = self.frame
        addSubview(effectView)
        
        let sloganView = UIImageView.init(image: UIImage(named: "compose_slogan"))
        addSubview(sloganView)
        sloganView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(MNLayout.Layout(100))
            make.width.equalTo(MNLayout.Layout(154))
            make.height.equalTo(MNLayout.Layout(48))
        }
        
        let bottomView = UIView()
        bottomView.backgroundColor = UIColor.white
        addSubview(bottomView)
        bottomView.snp.makeConstraints { (make) in
            make.left.bottom.right.equalToSuperview()
            make.height.equalTo(44)
        }
        
        let closelBtn = UIButton()
        closelBtn.setImage(UIImage(named: "tabbar_compose_background_icon_close"), for: .normal)
        bottomView.addSubview(closelBtn)
        closelBtn.addTarget(self, action: #selector(clickCloseBtn), for: .touchUpInside)
        closelBtn.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.width.height.equalTo(MNLayout.Layout(25))
        }
        
        let scrollView = UIScrollView()
        addSubview(scrollView)
        scrollView.contentSize = CGSize(width: bounds.width * 2, height: 0)
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.bounces = false
//        scrollView.isScrollEnabled = false
        scrollView.backgroundColor = UIColor.orange
        scrollView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.height.equalTo(MNLayout.Layout(224))
            make.bottom.equalTo(closelBtn.snp.top).offset(-MNLayout.Layout(56))
        }
        
        setupCompostButtons(parentView: scrollView)
    }
    
    func show() {
        guard let mainVC = UIApplication.shared.keyWindow?.rootViewController else{
            return
        }
        
        mainVC.view.addSubview(self)
    }
    
    @objc func clickCloseBtn(){
        
    }
    
    @objc func clickButton(){
        print("clickButton")
    }
}

private extension MNPublishView{
    
    
    func setupCompostButtons(parentView: UIView) {
        layoutIfNeeded()
        
        let rect = parentView.bounds
        let width = parentView.bounds.width
        for i in 0...1{
            
            let view = UIView(frame: rect.offsetBy(dx: width * CGFloat(i), dy: 0))
            view.backgroundColor = UIColor.lightGray
            parentView.addSubview(view)
            createButtons(parentView: view, index: i * pageCount)
        }
    }
    
    func createButtons(parentView: UIView, index: Int)  {
        
        for i in index..<(index + pageCount){
            
            if i >= buttonInfos.count{
                break
            }
            let dic = buttonInfos[i]
            guard let imageName = dic["imageName"],
                let title = dic["title"] else {
                    continue
            }
            let button = MNCompostTypeButton(imageName: imageName, title: title)
            parentView.addSubview(button)
        }
        
        //布局
        let buttonWH = MNLayout.Layout(100)
        let linesNum:CGFloat = 3
        let margin = (MNScreen.screenW - linesNum * buttonWH) / (linesNum + 1)
        
        for (index, btn) in parentView.subviews.enumerated(){
            let row = index / Int(linesNum)
            let column = index % Int(linesNum)
            let x = margin + CGFloat(column) * (buttonWH + margin)
            let y = CGFloat(row) * (buttonWH + margin)
            btn.frame = CGRect(x: x, y: y, width: buttonWH, height: buttonWH)
        }
    }
}
