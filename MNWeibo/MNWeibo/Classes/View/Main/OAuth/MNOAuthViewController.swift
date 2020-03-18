//
//  MNOAuthViewController.swift
//  MNWeibo
//
//  Created by miniLV on 2020/3/17.
//  Copyright © 2020 miniLV. All rights reserved.
//

import UIKit
import WebKit
import SVProgressHUD

// Webview load auth view
class MNOAuthViewController: UIViewController {

    private lazy var webView = WKWebView()
    
    override func loadView() {
        self.view = webView
        view.backgroundColor = UIColor.white
        
        webView.navigationDelegate = self
        webView.scrollView.isScrollEnabled = false
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

extension MNOAuthViewController: WKNavigationDelegate{

    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!){
        print("url =======> \(String(describing: webView.url?.absoluteString))")

    }
    
    func webView(_ webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!) {
        
        //"http://baidu.com/?code=7de67546405abcb1af3b4c2db166b551"
        if webView.url?.absoluteString.hasPrefix(MNredirectUri) == false{
            print("请求 url =======> \(String(describing: webView.url?.absoluteString))")
            return
        }
        
        //get url query ==> 查询字符串 （？后面的内容）
        if webView.url?.query?.hasPrefix("code=") == false{
            print("取消授权")
            closeWebView()
            return
        }
        
        print("授权授权码")
        let code = webView.url?.query?.substring(from: "code=".count)
        print("code = \(String(describing: code))")
        MNNetworkManager.shared.getAccessToken(code: code ?? "")
    }
}


