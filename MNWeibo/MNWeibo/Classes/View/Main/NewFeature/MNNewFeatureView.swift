//
//  MNNewFeatureView.swift
//  MNWeibo
//
//  Created by miniLV on 2020/3/22.
//  Copyright © 2020 miniLV. All rights reserved.
//

import UIKit

class MNNewFeatureView: UIView {

    private lazy var scrollView = UIScrollView()
    private lazy var enterHomeButton = UIButton()
    private lazy var pageControl = UIPageControl()
    private let pageCount = 4
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupSubviews()
        updateSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupSubviews(){
        scrollView.isPagingEnabled = true
        scrollView.bounces = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        addSubview(scrollView)
        scrollView.snp.makeConstraints { (make) in
            make.left.top.right.bottom.equalTo(0)
        }
        
        pageControl.currentPageIndicatorTintColor = UIColor.orange
        pageControl.pageIndicatorTintColor = UIColor.darkGray
        pageControl.numberOfPages = pageCount
        pageControl.isUserInteractionEnabled = false
        addSubview(pageControl)
        pageControl.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-MNLayout.Layout(80))
        }
        
        enterHomeButton.isHidden = true
        enterHomeButton.setBackgroundImage(UIImage(named: "new_feature_finish_button"), for: .normal)
        enterHomeButton.setBackgroundImage(UIImage(named: "new_feature_finish_button_highlighted"), for: .normal)
        enterHomeButton.addTarget(self, action: #selector(clickEnterButton), for: .touchUpInside)
        enterHomeButton.setTitle("进入微博", for: .normal)
        addSubview(enterHomeButton)
        enterHomeButton.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(pageControl.snp.top).offset(-MNLayout.Layout(40))
            make.width.equalTo(MNLayout.Layout(105))
            make.height.equalTo(MNLayout.Layout(36))
        }
    }
    
    private func updateSubviews(){
        for i in 0..<pageCount {
            let imageName = "new_feature_\(i + 1)"
            let imageView = UIImageView(image: UIImage(named: imageName))
            let x = UIScreen.mn_screenW * CGFloat(i)
            imageView.frame = CGRect(x: x, y: 0, width: UIScreen.mn_screenW , height: UIScreen.mn_screenH)
            scrollView.addSubview(imageView)
        }
        
        let contentSizeW = UIScreen.mn_screenW * CGFloat(pageCount + 1)
        scrollView.contentSize = CGSize(width: contentSizeW, height: UIScreen.mn_screenH)
        scrollView.delegate = self
    }
}

extension MNNewFeatureView : UIScrollViewDelegate{
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        //最后一个屏幕，试图消失
        let page = Int(scrollView.contentOffset.x / scrollView.bounds.width)
        
        if page == scrollView.subviews.count {
            //enter home screen
            removeFromSuperview()
        }
        
        //enter home button
        enterHomeButton.isHidden = (page != scrollView.subviews.count - 1)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //if scroll, hidden button
        enterHomeButton.isHidden = true
        
        let page = Int(scrollView.contentOffset.x / scrollView.bounds.width + 0.5)
        pageControl.currentPage = page
        pageControl.isHidden = (page == scrollView.subviews.count)
        
    }
    
    
    @objc func clickEnterButton(){
        removeFromSuperview()
    }
}
