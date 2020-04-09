//
//  MNMTRefreshView.swift
//  MNWeibo
//
//  Created by miniLV on 2020/4/4.
//  Copyright © 2020 miniLV. All rights reserved.
//

import UIKit

class MNMTRefreshView: MNRefreshView {

    override var parentViewHeight:CGFloat{
        didSet{
            // 缩放比例计算
            if parentViewHeight < earthIconDisplayHeight{
                return
            }
            
            var scale:CGFloat = 0
            if parentViewHeight > backgroudIconHeight{
                scale = 1
            }else{
                let diffCurrentHeight = backgroudIconHeight - parentViewHeight
                let diffMaxHeight = backgroudIconHeight - earthIconDisplayHeight
                scale = 1 - (diffCurrentHeight / diffMaxHeight)
            }
            scale = min(scale, 0.8)
            kangarooIconView.transform = CGAffineTransform(scaleX: scale, y: scale)
        }
    }
    
    var backgroudIconView = { () -> UIImageView in
        
        let buildImage1 = UIImage(named: "icon_building_loading_1")!
        let buildImage2 = UIImage(named: "icon_building_loading_2")!
        let iv = UIImageView()
        iv.image = UIImage.animatedImage(with: [buildImage1,buildImage2], duration: 0.7)
        return    iv
    }()
        
    var earthIconView = UIImageView(image: UIImage(named: "icon_earth"))
    var kangarooIconView = { () -> UIImageView in
        
        let kangarooImage1 = UIImage(named: "icon_small_kangaroo_loading_1")!
        let kangarooImage2 = UIImage(named: "icon_small_kangaroo_loading_2")!
        let iv = UIImageView()
        iv.image = UIImage.animatedImage(with: [kangarooImage1,kangarooImage2], duration: 0.5)
        return  iv
    }()
    
    private let earthIconWidth:CGFloat = 212.0
    private let backgroudIconHeight:CGFloat = 126.0
    private let earthIconDisplayHeight:CGFloat = 25
    
    override func setupUI(){
        self.frame = CGRect(x: 0, y: 0, width: earthIconWidth, height: backgroudIconHeight)
        clipsToBounds = true
        
        addSubview(backgroudIconView)
        let backgroudIconWidth:CGFloat = 197.5
        let backgroudIconX = (earthIconWidth - backgroudIconWidth) / 2
        backgroudIconView.frame = CGRect(x: backgroudIconX,
                                         y: 0,
                                         width: backgroudIconWidth,
                                         height: backgroudIconHeight)
        
        addSubview(earthIconView)
        let earthIconY:CGFloat = 100.0
        earthIconView.frame = CGRect(x: 0,
                                     y: earthIconY,
                                     width: earthIconWidth,
                                     height: earthIconWidth)
        
        addSubview(kangarooIconView)
        let kangarooIconWidth:CGFloat = 61.0
        let kangarooIconX:CGFloat = (earthIconWidth - kangarooIconWidth)/2.0
        let kangarooIconY:CGFloat = 30.0
        let kangarooIconHeight:CGFloat = 71.5
        kangarooIconView.frame = CGRect(x: kangarooIconX,
                                     y: kangarooIconY,
                                     width: kangarooIconWidth,
                                     height: kangarooIconHeight)
        setupMTAnimation()
    }
    
    private func setupMTAnimation(){
        //earth spin
        let animate = CABasicAnimation(keyPath: "transform.rotation")
        animate.repeatCount = Float.greatestFiniteMagnitude
        animate.toValue = -2 * Double.pi
        animate.duration = 3.5
        animate.isRemovedOnCompletion = false
        earthIconView.layer.add(animate, forKey: nil)
        
        //袋鼠
        kangarooIconView.layer.anchorPoint = CGPoint(x: 0.5, y: 1)
        let x = self.bounds.width * 0.5
        let y = self.bounds.height - earthIconDisplayHeight
        kangarooIconView.center = CGPoint(x: x, y: y)
        kangarooIconView.transform = CGAffineTransform(scaleX: 0.2, y: 0.2)
    }
    
    override class func refreshView() -> MNRefreshView{
        return MNMTRefreshView.init()
    }
}
