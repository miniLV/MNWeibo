//
//  MNWebViewController.swift
//  MNWeibo
//
//  Created by miniLV on 2020/4/12.
//  Copyright © 2020 miniLV. All rights reserved.
//

import UIKit
import WebKit

class MNWebViewController: MNBaseViewController {

    private lazy var webView = WKWebView(frame: UIScreen.main.bounds)
    
    var urlString:String?{
        didSet{
            guard let urlString = urlString,
            let url = URL(string: urlString) else {
                return
            }
            webView.load(URLRequest(url: url))
        }
    }
    
    override func setupTableView() {
        self.title = "网页"
        webView.scrollView.automaticallyAdjustsScrollIndicatorInsets = false
        view.insertSubview(webView, belowSubview: navigationBar)
        webView.scrollView.contentInset.top = MN_naviBarHeight
        webView.backgroundColor = UIColor.white
        webView.scrollView.showsHorizontalScrollIndicator = false
        webView.scrollView.showsVerticalScrollIndicator = false
    }
}
