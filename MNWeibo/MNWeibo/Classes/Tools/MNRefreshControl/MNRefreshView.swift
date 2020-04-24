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
    lazy var arrowImageView :UIImageView? = UIImageView(image: UIImage(named: "tableview_pull_refresh"))
    // 提示内容
    lazy var contentLabel: UILabel? = UILabel()
    // 指示器(菊花)
    lazy var activityIndicator: UIActivityIndicatorView? = UIActivityIndicatorView()
    // 父视图高度
    lazy var parentViewHeight:CGFloat = 0.0
    
    var refreshState:MNRefreshState = .normal{
        didSet{
            switch refreshState {
            case .normal:
                contentLabel?.text = "继续使劲拉..."
                arrowImageView?.isHidden = false
                activityIndicator?.stopAnimating()
                UIView.animate(withDuration: 0.2) {
                    self.arrowImageView?.transform = CGAffineTransform.identity
                }
            case .pulling:
                contentLabel?.text = "松手刷新..."
                UIView.animate(withDuration: 0.2) {
                    self.arrowImageView?.transform = CGAffineTransform(rotationAngle: CGFloat.pi + 0.0001)
                }
            case .refreshing:
                contentLabel?.text = "正在刷新..."
                arrowImageView?.isHidden = true
                activityIndicator?.startAnimating()
            }
        }
    }
    
    init() {
        super.init(frame: CGRect())
        self.frame = CGRect(x: 0, y: 0, width: 120, height: 40)
        self.backgroundColor = superview?.backgroundColor
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    class func refreshView() -> MNRefreshView{
        return MNRefreshView.init()
    }
    
    func setupUI(){
        let arrowWidth = 32
        if let arrowImageView = arrowImageView{
            arrowImageView.frame = CGRect(x: 0, y: 0, width: arrowWidth, height: arrowWidth)
            arrowImageView.center.y = self.center.y
            addSubview(arrowImageView)
        }
        
        if let contentLabel = contentLabel{
            contentLabel.text = "下拉开始刷新..."
            contentLabel.font = UIFont.systemFont(ofSize: 14)
            contentLabel.textColor = UIColor.lightGray
            contentLabel.frame = CGRect(x: arrowWidth, y: 0, width: 100, height: 30)
            contentLabel.center.y = self.center.y
            addSubview(contentLabel)
        }

        if let activityIndicator = activityIndicator{
            activityIndicator.hidesWhenStopped = true
            activityIndicator.frame = CGRect(x: 0, y: 0, width: arrowWidth, height: arrowWidth)
            activityIndicator.center.y = self.center.y
            activityIndicator.backgroundColor = UIColor.clear
            addSubview(activityIndicator)
        }
    }
}
