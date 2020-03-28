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
            repostButton.setTitle("\(String(describing: viewModel?.status.reposts_count))", for: .normal)
            commentsButton.setTitle("\(String(describing: viewModel?.status.comments_count))", for: .normal)
            likeButton.setTitle("\(String(describing: viewModel?.status.attitudes_count))", for: .normal)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupBottomToolView() -> UIView{
        
        let bottomView = UIView()
        addSubview(bottomView)
        bottomView.backgroundColor = UIColor.orange
        bottomView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(MNLayout.Layout(28))
        }
        
        let bottomToolView = UIStackView()
        bottomView.addSubview(bottomToolView)
        bottomToolView.translatesAutoresizingMaskIntoConstraints = false
        bottomToolView.alignment = .fill
        bottomToolView.distribution = .fillEqually
        bottomToolView.spacing = 0
        bottomToolView.axis = .horizontal
        NSLayoutConstraint.activate([
            bottomToolView.leftAnchor.constraint(equalTo: bottomView.leftAnchor),
            bottomToolView.rightAnchor.constraint(equalTo: bottomView.rightAnchor),
            bottomToolView.topAnchor.constraint(equalTo: bottomView.topAnchor),
            bottomToolView.bottomAnchor.constraint(equalTo: bottomView.bottomAnchor)
        ])
        
        repostButton.mn_toolButton(type: .repost)
        commentsButton.mn_toolButton(type: .comments)
        likeButton.mn_toolButton(type: .like)
        
        bottomToolView.addArrangedSubview(repostButton)
        bottomToolView.addArrangedSubview(commentsButton)
        bottomToolView.addArrangedSubview(likeButton)
        
        return bottomView
    }
}
