//
//  MNRefreshControl.swift
//  MNWeibo
//
//  Created by miniLV on 2020/4/1.
//  Copyright © 2020 miniLV. All rights reserved.
//

import UIKit

class MNRefreshControl: UIControl {

    let MNRefreshControlKey = "contentOffset"
    
    lazy var refreshView = MNRefreshView.refreshView()
    
    /// 刷新控件RefreshControl父视图
    private weak var scrollView: UIScrollView?
    
    init() {
        super.init(frame: CGRect())
        self.backgroundColor = UIColor.orange
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        guard let supreView = newSuperview as? UIScrollView else {
            print("newSuperview is nil")
            return
        }
        
        // KVO - 监听父视图滚动 contentOffset
        scrollView = supreView
        scrollView?.addObserver(self, forKeyPath: MNRefreshControlKey, options: [], context: nil)
        
    }
    
    override func removeFromSuperview() {
        //remove kvo observer
        superview?.removeObserver(self, forKeyPath: MNRefreshControlKey)
        super.removeFromSuperview()
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        print("contentOffset = \(scrollView?.contentOffset)")
        
        guard let scrollView = scrollView else{
            print("scrollView is nil")
            return
        }
        let height = abs(scrollView.contentInset.top + scrollView.contentOffset.y)
        print("height = \(height)")
        self.frame = CGRect(x: 0, y: -height, width: scrollView.bounds.width, height: height)
    }
    
    /// 开始刷新
    func beginRefreshing() {
        
    }

    func endRefreshing() {
        
    }
}


extension MNRefreshControl{
    private func setupUI(){
        addSubview(refreshView)
        clipsToBounds = true
        refreshView.translatesAutoresizingMaskIntoConstraints = false
        addConstraint(NSLayoutConstraint(item: refreshView,
                                         attribute: .centerX,
                                         relatedBy: .equal,
                                         toItem: self,
                                         attribute: .centerX,
                                         multiplier: 1,
                                         constant: 0))
        addConstraint(NSLayoutConstraint(item: refreshView,
                                         attribute: .bottom,
                                         relatedBy: .equal,
                                         toItem: self,
                                         attribute: .bottom,
                                         multiplier: 1,
                                         constant: 0))
        addConstraint(NSLayoutConstraint(item: refreshView,
                                         attribute: .width,
                                         relatedBy: .equal,
                                         toItem: nil,
                                         attribute: .notAnAttribute,
                                         multiplier: 1,
                                         constant: refreshView.bounds.width))
        addConstraint(NSLayoutConstraint(item: refreshView,
                                         attribute: .height,
                                         relatedBy: .equal,
                                         toItem: nil,
                                         attribute: .notAnAttribute,
                                         multiplier: 1,
                                         constant: refreshView.bounds.height))
        
    }
}
