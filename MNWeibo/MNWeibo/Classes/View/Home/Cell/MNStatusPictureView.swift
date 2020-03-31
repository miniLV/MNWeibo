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
            
            var index = 0
            for url in urls{
                let iv:UIImageView = subviews[index] as! UIImageView
                
                //特殊处理4张图片的情况
                if index == 1 && urls.count == 4{
                    index += 1
                }
                
                iv.mn_setImage(urlString: url.thumbnail_pic, placeholderImage: nil)
                iv.isHidden = false
                index += 1
            }
        }
    }
    
    var viewModel: MNStatusViewModel?{
        didSet{
            urls = viewModel?.picUrls
            //包含原创&被转发
            calculateViewSize()
        }
    }
    
    private func calculateViewSize(){
        let size = viewModel?.pictureViewSize ?? CGSize()
        //handle width
        if viewModel?.picUrls?.count == 1{
            //单图：动态缩放
            let view = subviews[0]
            // 图片大小 = cell大小 - 间距
            let height = size.height - MNStatusPictureOutterMargin
            view.frame = CGRect(x: 0,
                                y: MNStatusPictureOutterMargin,
                                width: size.width,
                                height: height)
        }else{
            //多图，正常尺寸
            let view = subviews[0]
            view.frame = CGRect(x: 0,
                                y: MNStatusPictureOutterMargin,
                                width: MNPictureItemWidth,
                                height: MNPictureItemWidth)
        }
        
        //handle height
        self.snp.updateConstraints { (make) in
            make.height.equalTo(viewModel?.pictureViewSize.height ?? 0)
        }
    }
    

    init(parentView: UIView?, topView: UIView?, bottomView: UIView?) {
        super.init(frame: CGRect())
        self.backgroundColor = superview?.backgroundColor

        let margin = MNLayout.Layout(12)
        guard let parentView = parentView, let topView = topView else {
            return
        }
        
        parentView.addSubview(self)
        
        if bottomView == nil{
            self.snp.makeConstraints { (make) in
                      make.left.equalTo(margin)
                      make.right.equalTo(-margin)
                      make.top.equalTo(topView.snp.bottom)
                      make.bottom.lessThanOrEqualToSuperview()
                      make.height.equalTo(MNLayout.Layout(200))
                  }
        }else{
            self.snp.makeConstraints { (make) in
                      make.left.equalTo(margin)
                      make.right.equalTo(-margin)
                      make.top.equalTo(topView.snp.bottom)
                      make.bottom.lessThanOrEqualTo(bottomView!.snp.top).offset(-margin)
                      make.height.equalTo(MNLayout.Layout(200))
                  }
        }
        
//        self.snp.makeConstraints { (make) in
//            make.left.equalTo(margin)
//            make.right.equalTo(-margin)
//            make.top.equalTo(topView.snp.bottom)
//            make.bottom.lessThanOrEqualTo(bottomView.snp.top).offset(-margin)
//            make.height.equalTo(MNLayout.Layout(200))
//        }
        
        setupPictures()
    }
    
    func setupPictures()  {
        clipsToBounds = true
        let maxCount = 9
  
        for i in 0..<maxCount{
            
            let iv = UIImageView()
            iv.contentMode = .scaleAspectFill
            iv.clipsToBounds = true
            iv.image = UIImage(named: "timeline_icon_ip")
            let row = CGFloat(i / Int(MNPictureMaxPerLine))
            let column = CGFloat(i % Int(MNPictureMaxPerLine))
            let x = column * (MNPictureItemWidth + MNStatusPictureInnerMargin)
            let y = MNStatusPictureOutterMargin + row * (MNPictureItemWidth + MNStatusPictureInnerMargin)
            iv.frame = CGRect(x: x, y: y, width: MNPictureItemWidth, height: MNPictureItemWidth)
        
            addSubview(iv)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
