//
//  MNStatusToolView.swift
//  MNWeibo
//
//  Created by miniLV on 2020/3/28.
//  Copyright © 2020 miniLV. All rights reserved.
//

import UIKit

class MNStatusToolView: UIView {
    
    lazy var repostButton = UIButton()
    lazy var commentsButton = UIButton()
    lazy var likeButton = UIButton()
    
    var viewModel:MNStatusViewModel?{
        didSet{
            repostButton.setTitle(viewModel?.repostTitle, for: .normal)
            commentsButton.setTitle(viewModel?.commentTitle, for: .normal)
            likeButton.setTitle(viewModel?.likeTitle, for: .normal)
        }
    }
    
    init(parentView: UIView?) {
        super.init(frame: CGRect())
        
        if parentView == nil{
            return
        }
        
        parentView?.addSubview(self)
        self.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(MNLayout.Layout(35))
        }
        
        let bottomToolView = UIStackView()
        self.addSubview(bottomToolView)
        bottomToolView.translatesAutoresizingMaskIntoConstraints = false
        bottomToolView.alignment = .fill
        bottomToolView.distribution = .fillEqually
        bottomToolView.spacing = 0
        bottomToolView.axis = .horizontal
        NSLayoutConstraint.activate([
            bottomToolView.leftAnchor.constraint(equalTo: self.leftAnchor),
            bottomToolView.rightAnchor.constraint(equalTo: self.rightAnchor),
            bottomToolView.topAnchor.constraint(equalTo: self.topAnchor),
            bottomToolView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        
        repostButton.mn_toolButton(type: .repost)
        bottomToolView.addArrangedSubview(repostButton)
        
        commentsButton.mn_toolButton(type: .comments)
        bottomToolView.addArrangedSubview(commentsButton)
        
        likeButton.mn_toolButton(type: .like)
        bottomToolView.addArrangedSubview(likeButton)
        
        //line
        let line = UIView()
        line.backgroundColor = UIColor.init(rgb: 0xf2f2f2)
        addSubview(line)
        line.snp.makeConstraints { (make) in
            make.left.equalTo(MNDefaultMargin)
            make.right.equalTo(-MNDefaultMargin)
            make.top.equalToSuperview()
            make.height.equalTo(MNLayout.Layout(1))
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
