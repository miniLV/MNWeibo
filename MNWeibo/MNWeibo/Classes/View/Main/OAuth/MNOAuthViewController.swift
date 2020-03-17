//
//  MNOAuthViewController.swift
//  MNWeibo
//
//  Created by miniLV on 2020/3/17.
//  Copyright © 2020 miniLV. All rights reserved.
//

import UIKit
import WebKit

// Webview load auth view
class MNOAuthViewController: UIViewController {

    private lazy var webView = WKWebView()
    
    override func loadView() {
        self.view = webView
        view.backgroundColor = UIColor.white
        
        title = "登录小蠢驴微博"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "返回", target: self, action: #selector(closeWebView), isBackItem: true)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "自动填充", target: self, action: #selector(autoInput))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadUrl()
    }
    
    private func loadUrl(){
        let urlString = "https://api.weibo.com/oauth2/authorize?client_id=\(MNAppKey)&redirect_uri=\(MNredirectUri)"
        guard let url = URL(string: urlString) else{
            print("url = nil")
            return
        }
        let request = URLRequest(url: url)
        webView.load(request as URLRequest)
    }
    
    
    @objc func closeWebView(){
        dismiss(animated: true, completion: nil)
    }
    
    @objc func autoInput(){
        
        //动态注入JS
        let js =  "document.getElementById('userId').value = 'xxxx';" + "document.getElementById('passwd').value = 'test123';"

        webView.evaluateJavaScript(js, completionHandler: nil)
    }
}
