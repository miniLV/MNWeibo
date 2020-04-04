//
//  MNPublishView.swift
//  MNWeibo
//
//  Created by miniLV on 2020/4/4.
//  Copyright © 2020 miniLV. All rights reserved.
//

import UIKit

class MNPublishView: UIView {

    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        backgroundColor = UIColor.clear
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI()  {
        let blurEffect = UIBlurEffect(style: .extraLight)
        let effectView = UIVisualEffectView(effect: blurEffect)
        effectView.frame = self.frame
        addSubview(effectView)
    }
    
    func show() {
        guard let mainVC = UIApplication.shared.keyWindow?.rootViewController else{
            return
        }
        
        mainVC.view.addSubview(self)
    }
}
