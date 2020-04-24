//
//  MNPublishView.swift
//  MNWeibo
//
//  Created by miniLV on 2020/4/4.
//  Copyright © 2020 miniLV. All rights reserved.
//

import UIKit
import pop
class MNPublishView: UIView {

    //每页最多6个按钮
    let pageCount = 6
    
    private var scrollView = UIScrollView()
    ///关闭按钮
    private var closeBtn = UIButton()
    ///返回前一页按钮
    private var returnBtn = UIButton()
    
    private let btnAnimateDuration = 0.025
    
    private var completionBlock:((_ clsName: String?)->())?
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        backgroundColor = UIColor.clear
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let buttonInfos = [["imageName": "tabbar_compose_idea", "title": "文字", "clsName": "MNWriteController"],
                               ["imageName": "tabbar_compose_photo", "title": "照片/视频"],
                               ["imageName": "tabbar_compose_weibo", "title": "长微博"],
                               ["imageName": "tabbar_compose_lbs", "title": "签到"],
                               ["imageName": "tabbar_compose_review", "title": "点评"],
                               ["imageName": "tabbar_compose_more", "title": "更多", "actionName": "clickMoreButton"],
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
            make.height.equalTo(MN_bottomTabBarHeight)
        }
        
        closeBtn.setImage(UIImage(named: "tabbar_compose_background_icon_close"), for: .normal)
        bottomView.addSubview(closeBtn)
        closeBtn.addTarget(self, action: #selector(clickCloseBtn), for: .touchUpInside)
        closeBtn.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.width.height.equalTo(MNLayout.Layout(25))
        }
        
        returnBtn.setImage(UIImage(named: "tabbar_compose_background_icon_return"), for: .normal)
        returnBtn.isHidden = true
        bottomView.addSubview(returnBtn)
        returnBtn.addTarget(self, action: #selector(clickReturnBtn), for: .touchUpInside)
        returnBtn.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.width.height.equalTo(MNLayout.Layout(25))
        }
        
        addSubview(scrollView)
        scrollView.contentSize = CGSize(width: bounds.width * 2, height: 0)
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.bounces = false
        scrollView.isScrollEnabled = false
        scrollView.backgroundColor = UIColor.clear
        scrollView.clipsToBounds = false
        scrollView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.height.equalTo(MNLayout.Layout(224))
            make.bottom.equalTo(closeBtn.snp.top).offset(-MNLayout.Layout(56))
        }
        
        setupCompostButtons(parentView: scrollView)
    }
    
    func show(rootVC:UIViewController, completion: @escaping ((_ clsName: String?)->())) {
        completionBlock = completion
        
        rootVC.view.addSubview(self)
        
        showCurrentViewAnimate()
    }
    
    @objc func clickCloseBtn(){
        hideButtons()
    }
    
    @objc func clickReturnBtn(){
        scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        returnBtn.snp.updateConstraints { (make) in
            make.centerX.equalToSuperview()
        }
        closeBtn.snp.updateConstraints { (make) in
            make.centerX.equalToSuperview()
        }
        
        UIView.animate(withDuration: 0.2, animations: {
            self.layoutIfNeeded()
            self.returnBtn.alpha = 0
        }) { (_) in
            self.returnBtn.isHidden = true
            self.returnBtn.alpha = 1
        }
    }
    
    @objc func clickButton(selectedButton:MNCompostTypeButton ){
        
        let pageIndex = Int(scrollView.contentOffset.x / scrollView.bounds.width)
        let view = scrollView.subviews[pageIndex]
        
        for (index,btn) in view.subviews.enumerated(){
            //缩放动画
            let scaleAnim:POPBasicAnimation = POPBasicAnimation(propertyNamed: kPOPViewScaleXY)
            let scale = (selectedButton == btn) ? 2 : 0.2
            // x,y 在坐标系中用CGPoint显示，不能直接用基本数据类型，需要 NSValue 转换下
            scaleAnim.toValue = NSValue(cgPoint: CGPoint(x: scale, y: scale))
            scaleAnim.duration = 0.5
            btn.pop_add(scaleAnim, forKey: nil)
            
            //渐变动画
            let alphaAnim:POPBasicAnimation = POPBasicAnimation(propertyNamed: kPOPViewAlpha)
            alphaAnim.toValue = 0.2
            alphaAnim.duration = 0.5
            btn.pop_add(alphaAnim, forKey: nil)
            
            //监听动画完成
            if index == 0 {
                alphaAnim.completionBlock = {_,_ in
                    print("show vc")
                    self.completionBlock?(selectedButton.clsName)
                }
            }
        }
    }
    
    func presentNewVC(){
        
    }
    
    ///点击更多
    @objc func clickMoreButton(){
        scrollView.setContentOffset(CGPoint(x: scrollView.bounds.width, y: 0), animated: true)
        
        returnBtn.isHidden = false
        
        //三等分
        let margin = scrollView.bounds.width / 6
        returnBtn.snp.updateConstraints { (make) in
            make.centerX.equalToSuperview().offset(-MNLayout.Layout(margin))
        }
        closeBtn.snp.updateConstraints { (make) in
            make.centerX.equalToSuperview().offset(MNLayout.Layout(margin))
        }
        
        UIView.animate(withDuration: 0.2) {
           self.layoutIfNeeded()
        }
    }
}

private extension MNPublishView{
    
    func setupCompostButtons(parentView: UIView) {
        layoutIfNeeded()
        
        let rect = parentView.bounds
        let width = parentView.bounds.width
        let maxPage = buttonInfos.count / pageCount
        for i in 0...maxPage{
            
            let view = UIView(frame: rect.offsetBy(dx: width * CGFloat(i), dy: 0))
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
            if let actionName = dic["actionName"]{
                button.addTarget(self, action: Selector(actionName), for: .touchUpInside)
            }else{
                button.addTarget(self, action: #selector(clickButton(selectedButton:)), for: .touchUpInside)
            }
            let clsName = dic["clsName"]
            button.clsName = clsName
        }
        
        //布局
        let buttonWH = MNLayout.Layout(100)
        let linesNum:CGFloat = 3
        let margin = (UIScreen.mn_screenW - linesNum * buttonWH) / (linesNum + 1)
        
        for (index, btn) in parentView.subviews.enumerated(){
            let row = index / Int(linesNum)
            let column = index % Int(linesNum)
            let x = margin + CGFloat(column) * (buttonWH + margin)
            let y = CGFloat(row) * (buttonWH + margin)
            btn.frame = CGRect(x: x, y: y, width: buttonWH, height: buttonWH)
        }
    }
}

// MARK: - Animate
private extension MNPublishView{
    
    func showCurrentViewAnimate() {
        let anim:POPBasicAnimation = POPBasicAnimation(propertyNamed: kPOPViewAlpha)
        
        anim.fromValue = 0
        anim.toValue = 1
        anim.duration = 0.25
        pop_add(anim, forKey: nil)
        
        showButtonAnimate()
    }
    
    func showButtonAnimate() {
        let backgroundView = scrollView.subviews[0]
        
        for (index, btn) in backgroundView.subviews.enumerated(){
            
            let anim:POPSpringAnimation = POPSpringAnimation(propertyNamed: kPOPLayerPositionY)
            
            anim.fromValue = btn.center.y + 400
            anim.toValue = btn.center.y
            //弹力系数 - [0,20],数值越大弹性越大，default = 4
            anim.springBounciness = 8
            //弹力速度 - [0,20],数值越大弹速度越快，default = 12
            anim.springSpeed = 8
            
            anim.beginTime = CACurrentMediaTime() + CFTimeInterval(index) * btnAnimateDuration
            btn.pop_add(anim, forKey: nil)
        }
    }
    
    func hideButtons(){
        let offset = scrollView.contentOffset.x
        let page = Int(offset / scrollView.bounds.width)
        let view = scrollView.subviews[page]
        for (index,btn) in view.subviews.enumerated().reversed(){
            let anim:POPSpringAnimation = POPSpringAnimation(propertyNamed: kPOPLayerPositionY)
            anim.fromValue = btn.center.y
            anim.toValue = btn.center.y + 400
            //消失动画: 从最后一个按钮开始消失
            let hiddenIndexOrder = view.subviews.count - index
            anim.beginTime = CACurrentMediaTime() + CFTimeInterval(hiddenIndexOrder) * btnAnimateDuration
            btn.pop_add(anim, forKey: nil)
            
            hideCurrentView(index: index, btnAnim: anim)
        }
    }
    
    func hideCurrentView(index:Int, btnAnim:POPSpringAnimation){
        //消失的逆序逐渐消失的，当第一个按钮消失时，说明所有按钮都消失了 ==> 此时隐藏view
        if index > 0{
            return
        }
        
        btnAnim.completionBlock = {_,_ in
            let viewAnim:POPBasicAnimation = POPBasicAnimation(propertyNamed: kPOPViewAlpha)
            viewAnim.fromValue = 1
            viewAnim.toValue = 0
            viewAnim.duration = 0.25
            
            self.pop_add(viewAnim, forKey: nil)
            
            viewAnim.completionBlock = {_,_ in
                self.removeFromSuperview()
            }
        }
    }
}
