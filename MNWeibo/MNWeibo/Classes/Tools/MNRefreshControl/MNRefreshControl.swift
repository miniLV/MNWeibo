//
//  MNRefreshControl.swift
//  MNWeibo
//
//  Created by miniLV on 2020/4/1.
//  Copyright © 2020 miniLV. All rights reserved.
//

import UIKit

/// 刷新控件状态变化的临界值(MT:126)
private let MNRefreshOffsetY:CGFloat = 60

/// 刷新状态
/// normal : 默认状态
/// 超过临界点
/// 正在刷新
enum MNRefreshState{
    case normal
    case pulling
    case refreshing
}

class MNRefreshControl: UIControl {

    let MNRefreshControlKey = "contentOffset"
    
    lazy var refreshView = MNRefreshView.refreshView()
    
    /// 刷新控件RefreshControl父视图
    private weak var scrollView: UIScrollView?
    
    init() {
        super.init(frame: CGRect())
        self.backgroundColor = superview?.backgroundColor
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
        
        guard let scrollView = scrollView else{
            print("scrollView is nil")
            return
        }
        let height = -(scrollView.contentInset.top + scrollView.contentOffset.y)
        if height < 0{
            //scroll to top
            return
        }
        
        self.frame = CGRect(x: 0,
                            y: -height,
                            width: scrollView.bounds.width,
                            height: height)
        
        if refreshView.refreshState != .refreshing{
            refreshView.parentViewHeight = height
        }
        
        //判断临界点
        if scrollView.isDragging{
            if height > MNRefreshOffsetY && (refreshView.refreshState == .normal){
                print("放手刷新")
                refreshView.refreshState = .pulling
            }else if height <= MNRefreshOffsetY && (refreshView.refreshState == .pulling){
                print("再使劲")
                refreshView.refreshState = .normal
            }
        }else{
            if refreshView.refreshState == .pulling{
                print("准备开始刷新")

                beginRefreshing()
                
                sendActions(for: .valueChanged)
            }
        }
    }
    
    /// 开始刷新
    func beginRefreshing() {
        guard let scrollView = scrollView else {
            print("scrollView is nil")
            return
        }
        
        if refreshView.refreshState == .refreshing{
            print("is refreshing.")
            return
        }
        refreshView.refreshState = .refreshing
        var inset = scrollView.contentInset
        inset.top += MNRefreshOffsetY
        scrollView.contentInset = inset
        
        refreshView.parentViewHeight = MNRefreshOffsetY
    }

    func endRefreshing() {
        if refreshView.refreshState != .refreshing{
            return
        }
        
        guard let scrollView = scrollView else {
            print("scrollView is nil")
            return
        }
        
        refreshView.refreshState = .normal
        var inset = scrollView.contentInset
        inset.top -= MNRefreshOffsetY
        scrollView.contentInset = inset
    }
}


extension MNRefreshControl{
    private func setupUI(){
        addSubview(refreshView)
        //clipsToBounds = true
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
