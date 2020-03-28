//
//  MNStatusPictureView.swift
//  MNWeibo
//
//  Created by miniLV on 2020/3/28.
//  Copyright © 2020 miniLV. All rights reserved.
//

import UIKit

class MNStatusPictureView: UIView {
    
    var urls: [MNStatusPicture]?{
        didSet{
            //hidden imageView
            subviews.forEach { $0.isHidden = true}

            guard let urls = urls else {
                print("MNStatusPictureView - urls is empty.")
                return
            }
            for (index, url) in urls.enumerated(){
                let iv:UIImageView = subviews[index] as! UIImageView
//                iv.mn_setImage(urlString: url.thumbnail_pic, placeholderImage: nil)
                iv.mn_setImage(urlString: viewModel?.status.user?.profile_image_url,
                                                   placeholderImage: UIImage(named: "avatar_default_big"),
                                                   isAvatar: true)
                iv.isHidden = false
            }
        }
    }
    
    var viewModel: MNStatusViewModel?{
        didSet{
            urls = viewModel?.status.pic_urls
            print("set urls = \(String(describing: urls))")
            self.snp.updateConstraints { (make) in
                make.height.equalTo(viewModel?.pictureViewSize.height ?? 0)
            }
        }
    }

    init(parentView: UIView?, topView: UIView?, bottomView: UIView?) {
        super.init(frame: CGRect())
        let margin = MNLayout.Layout(12)
        self.backgroundColor = UIColor.orange
        guard let parentView = parentView, let topView = topView, let bottomView = bottomView else {
            return
        }
        
        parentView.addSubview(self)
        
        self.snp.makeConstraints { (make) in
            make.left.equalTo(margin)
            make.right.equalTo(-margin)
            make.top.equalTo(topView.snp_bottomMargin).offset(margin)
            make.bottom.lessThanOrEqualTo(bottomView.snp_topMargin).offset(-margin)
            make.height.equalTo(MNLayout.Layout(200))
        }
        
        setupPictures()
    }
    
    func setupPictures()  {
        clipsToBounds = true
        let maxCount = 9
  
        for i in 0..<maxCount{
            
            let iv = UIImageView()
//            iv.backgroundColor = UIColor.red
            iv.image = UIImage(named: "timeline_icon_ip")
            let row = CGFloat(i / Int(MNPictureMaxPerLine))
            let column = CGFloat(i % Int(MNPictureMaxPerLine))
            let x = column * (MNPictureItemWidth + MNStatusPictureInnerMargin)
            let y = row * (MNPictureItemWidth + MNStatusPictureInnerMargin)
            iv.frame = CGRect(x: x, y: y, width: MNPictureItemWidth, height: MNPictureItemWidth)
            
            addSubview(iv)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
