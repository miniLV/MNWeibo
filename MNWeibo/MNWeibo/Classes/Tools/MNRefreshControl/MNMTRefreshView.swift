//
//  MNMTRefreshView.swift
//  MNWeibo
//
//  Created by miniLV on 2020/4/4.
//  Copyright © 2020 miniLV. All rights reserved.
//

import UIKit

class MNMTRefreshView: MNRefreshView {

    var backgroudIconView = { () -> UIImageView in
        
        let buildImage1 = UIImage(named: "icon_building_loading_1")!
        let buildImage2 = UIImage(named: "icon_building_loading_2")!
        let iv = UIImageView()
        iv.image = UIImage.animatedImage(with: [buildImage1,buildImage2], duration: 0.7)
        return    iv
    }()
        
    var earthIconView = UIImageView(image: UIImage(named: "icon_earth"))
    var kangarooIconView = UIImageView(image: UIImage(named: "icon_small_kangaroo_loading_1"))
    
    private let earthIconWidth = 212.0
    private let backgroudIconHeight = 126.0
    
    override func setupUI(){
        self.frame = CGRect(x: 0, y: 0, width: earthIconWidth, height: backgroudIconHeight)
        clipsToBounds = true
        
        addSubview(backgroudIconView)
        let backgroudIconWidth = 197.5
        let backgroudIconX = (earthIconWidth - backgroudIconWidth) / 2
        backgroudIconView.frame = CGRect(x: backgroudIconX,
                                         y: 0,
                                         width: backgroudIconWidth,
                                         height: backgroudIconHeight)
        
        addSubview(earthIconView)
        let earthIconY = 100.0
        earthIconView.frame = CGRect(x: 0,
                                     y: earthIconY,
                                     width: earthIconWidth,
                                     height: earthIconWidth)
        
        addSubview(kangarooIconView)
        let kangarooIconWidth = 61.0
        let kangarooIconX = (earthIconWidth - kangarooIconWidth)/2.0
        let kangarooIconY = 30.0
        let kangarooIconHeight = 71.5
        kangarooIconView.frame = CGRect(x: kangarooIconX,
                                     y: kangarooIconY,
                                     width: kangarooIconWidth,
                                     height: kangarooIconHeight)
        setupMTAnimation()
    }
    
    private func setupMTAnimation(){
        let animate = CABasicAnimation(keyPath: "transform.rotation")
        animate.repeatCount = Float.greatestFiniteMagnitude
        animate.toValue = -2 * Double.pi
        animate.duration = 3.5
        animate.isRemovedOnCompletion = false
        earthIconView.layer.add(animate, forKey: nil)
        
    }
    
    override class func refreshView() -> MNRefreshView{
        return MNMTRefreshView.init()
    }
}
