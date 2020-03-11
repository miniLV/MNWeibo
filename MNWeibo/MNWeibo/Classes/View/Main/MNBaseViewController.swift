//
//  MNBaseViewController.swift
//  MNWeibo
//
//  Created by miniLV on 2020/3/10.
//  Copyright © 2020 miniLV. All rights reserved.
//

import UIKit

class MNBaseViewController: UIViewController{

    //custom navigation bar
    lazy var navigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: UIScreen.cz_screenWidth(), height: 64))
    
    lazy var naviItem = UINavigationItem()
    
    var tableView: UITableView?
    
    var refreshControl: UIRefreshControl?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadDatas()
    }
    
    override var title: String? {
        didSet{
            naviItem.title = title
        }
    }
    
    @objc func loadDatas() {
        
    }
    
}

//MARK: - setup ui
extension MNBaseViewController{
     @objc func setupUI() {
        view.backgroundColor = UIColor.cz_random()
        self.setupNavigationBar()
        self.setupTableView()

        //取消自动缩进
        automaticallyAdjustsScrollViewInsets = false
        
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(loadDatas), for: .valueChanged)
        tableView?.addSubview(refreshControl!)
    }
    
    private func setupTableView(){
        tableView = UITableView(frame: view.bounds, style: .plain)
        view.insertSubview(tableView!, belowSubview: navigationBar)
        
        tableView?.delegate = self
        tableView?.dataSource = self
        
        //手动设置内容缩进
        let toolHeight:CGFloat = 20
        let tabBarHeight:CGFloat = 0
        tableView?.contentInset = UIEdgeInsets(top: toolHeight, left: 0, bottom: tabBarHeight, right: 0)
    }
    
    private func setupNavigationBar(){
        view.addSubview(navigationBar)
        
        navigationBar.items = [naviItem]
        
        navigationBar.barTintColor = UIColor.cz_color(withHex: 0xF6F6F6)
        //set title color
        navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor : UIColor.darkGray
        ]
    }
}

//MARK: - UITableViewDelegate, UITableViewDataSource
extension MNBaseViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
