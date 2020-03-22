//
//  MNTitleButton.swift
//  MNWeibo
//
//  Created by miniLV on 2020/3/22.
//  Copyright © 2020 miniLV. All rights reserved.
//

import UIKit

class MNTitleButton: UIButton {

    //title is nil ==> display "首页"
    //title isn't nil ==> display userName & arrow image
    init(title: String?, target: Any?, action: Selector) {
        super.init(frame: CGRect())

        if title == nil{
            setTitle("首页", for: .normal)
        }else{
            setTitle(title, for: .normal)
            setImage(UIImage(named: "navigationbar_arrow_down"), for: .normal)
            setImage(UIImage(named: "navigationbar_arrow_up"), for: .selected)
        }
        
        titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        setTitleColor(UIColor.darkGray, for: .normal)
        sizeToFit()
        
        addTarget(target, action: action, for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        print("layoutSubviews")
        
        guard let titleLabel = titleLabel, let imageView = imageView else {
            return
        }

        //FIXME: call layoutSubviews twice
        
        //设置文字在做，图片在右
        //1.将titlelabel 的 x, 向左移动 imageView的宽度
        if titleLabel.frame.origin.x > 0 {
            titleLabel.frame = titleLabel.frame.offsetBy(dx: -imageView.frame.width, dy: 0)
        }

        //2.将imageView 的 x, 向右移动 titleLabel的宽度
        if imageView.frame.origin.x == 0 {
            imageView.frame = imageView.frame.offsetBy(dx: titleLabel.frame.width, dy: 0)
        }
    }
}
