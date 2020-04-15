//
//  MNTextView.swift
//  MNWeibo
//
//  Created by miniLV on 2020/4/15.
//  Copyright © 2020 miniLV. All rights reserved.
//

import UIKit

class MNTextView: UITextView {
    
    lazy var placeholderLabel = UILabel()
    
    init() {
        super.init(frame: CGRect(), textContainer: nil)
        setupUI()
        registerNoti()
    }
    
    override var font: UIFont?{
        didSet{
            placeholderLabel.font = self.font
            placeholderLabel.sizeToFit()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func registerNoti() {
        NotificationCenter.default.addObserver(self, selector: #selector(textViewDidChange), name: UITextView.textDidChangeNotification, object: nil)
    }
    
    @objc func textViewDidChange(noti:Notification){
        placeholderLabel.isHidden = self.hasText
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

extension MNTextView{
    func setupUI(){
        placeholderLabel.font = self.font
        placeholderLabel.text = "miniLV rua~"
        placeholderLabel.textColor = UIColor.lightGray
        placeholderLabel.sizeToFit()
        placeholderLabel.frame.origin = CGPoint(x: 5, y: 8)
        addSubview(placeholderLabel)
    }
}
