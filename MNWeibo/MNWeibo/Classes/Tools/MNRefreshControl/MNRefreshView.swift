//
//  MNRefreshView.swift
//  MNWeibo
//
//  Created by miniLV on 2020/4/1.
//  Copyright © 2020 miniLV. All rights reserved.
//

import UIKit

class MNRefreshView: UIView {

    // 箭头指示器
    lazy var arrowImageView :UIImageView = UIImageView(image: UIImage(named: "tableview_pull_refresh"))
    // 提示内容
    lazy var contentLabel: UILabel = UILabel()
    // 指示器(菊花)
    lazy var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    init() {
        super.init(frame: CGRect())
        self.frame = CGRect(x: 0, y: 0, width: 200, height: 40)
        self.backgroundColor = UIColor.white
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    class func refreshView() -> MNRefreshView{
        return MNRefreshView.init()
    }
    
    private func setupUI(){
        
        contentLabel.text = "下拉开始刷新..."
        contentLabel.font = UIFont.systemFont(ofSize: 14)
        contentLabel.textColor = UIColor.lightGray
        activityIndicator.hidesWhenStopped = true
        
        let arrowWidth = 32
        arrowImageView.frame = CGRect(x: 0, y: 0, width: arrowWidth, height: arrowWidth)
        arrowImageView.center.y = self.center.y
        addSubview(arrowImageView)
        
        activityIndicator.frame = CGRect(x: 0, y: 0, width: arrowWidth, height: arrowWidth)
        activityIndicator.center.y = self.center.y
        activityIndicator.backgroundColor = UIColor.blue
        addSubview(activityIndicator)
        
        contentLabel.frame = CGRect(x: arrowWidth, y: 0, width: 100, height: 30)
        contentLabel.center.y = self.center.y
        addSubview(contentLabel)
    }
    

}
