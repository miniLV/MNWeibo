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
    lazy var navigationBar = MNNavigationBar(frame: CGRect(x: 0, y: 0, width: UIScreen.mn_screenW, height: MN_naviBarHeight))
    
    lazy var naviItem = UINavigationItem()
    
    var tableView: UITableView?
    
    var refreshControl: MNRefreshControl?
    
    var isPull: Bool = false
    
    var visitorInfo: [String : String]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        MNNetworkManager.shared.isLogin ? loadDatas() : ()
        
        registNotification()
        
        refreshControl?.beginRefreshing()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override var title: String? {
        didSet{
            naviItem.title = title
        }
    }
    
    @objc func loadDatas() {
        refreshControl?.endRefreshing()
    }
    
    func registNotification() {
        //login success
        NotificationCenter.default.addObserver(
            forName: NSNotification.Name(MNUserLoginSuccessNotification),
            object: nil,
            queue:OperationQueue.main){ [weak self]_ in
                guard let weakSelf = self else{
                    return
                }
                
                //clear navigationBar
                weakSelf.naviItem.leftBarButtonItem = nil
                weakSelf.naviItem.rightBarButtonItem = nil
                
                //reload view
                weakSelf.setupUI()
                weakSelf.loadDatas()
        }
    }
}

//MARK: - setup ui
extension MNBaseViewController:LoginDelegate{
    
    private func setupUI() {
        view.backgroundColor = UIColor.white
        setupNavigationBar()
        
        MNNetworkManager.shared.isLogin ? setupLoginSuccessUI() : setupVisitorView()
        
        //取消自动缩进
        tableView?.contentInsetAdjustmentBehavior = .never
        
        refreshControl = MNRefreshControl()
        refreshControl?.addTarget(self, action: #selector(loadDatas), for: .valueChanged)
        tableView?.addSubview(refreshControl!)
    }
    
    //user login success, override this func to setup UI.
    func setupLoginSuccessUI(){
        setupTableView()
        setupNaviTitle()
    }
    
    @objc func setupTableView(){
        tableView = UITableView(frame: view.bounds, style: .plain)
        view.insertSubview(tableView!, belowSubview: navigationBar)
        
        tableView?.delegate = self
        tableView?.dataSource = self
        
        //手动设置内容缩进
        let toolHeight:CGFloat = MN_naviBarHeight
        let tabBarHeight:CGFloat = MN_bottomTabBarHeight
        tableView?.contentInset = UIEdgeInsets(top: toolHeight, left: 0, bottom: tabBarHeight, right: 0)
        tableView?.scrollIndicatorInsets = tableView!.contentInset
    }
    
    @objc func setupNaviTitle(){}
    
    @objc func clickTitleButton(button: UIButton){
        button.isSelected = !button.isSelected
    }
    
    private func setupVisitorView(){
        let visitorView = MNVisitorView(frame: view.bounds)
        visitorView.visitorInfo = visitorInfo
        visitorView.delegate = self
        view.insertSubview(visitorView, belowSubview: navigationBar)
        
        //set navi item
        naviItem.leftBarButtonItem = UIBarButtonItem(title: "注册", style: .plain, target: self, action: #selector(clickRegister))
        naviItem.rightBarButtonItem = UIBarButtonItem(title: "登录", style: .plain, target: self, action: #selector(clickLogin))
    }
    
    private func setupNavigationBar(){
        view.addSubview(navigationBar)
        
        navigationBar.items = [naviItem]
        //navigationBar background color
        navigationBar.barTintColor = UIColor.init(rgb: 0xF6F6F6)
        //set title color
        navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor : UIColor.darkGray
        ]
        //set system item title color
        navigationBar.backgroundColor = UIColor.init(rgb: 0xF6F6F6)
    }
    
    //Mark: touch event
    @objc func clickLogin() {
        print("clickLogin")
        NotificationCenter.default.post(name: NSNotification.Name(MNUserShouldLoginNotification), object: nil)
    }
    
    @objc func clickRegister() {
        print("clickRegister")
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
    
    //在显示最后一行的时候，自动上拉刷新
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        //index contain(section & row)
        let row = indexPath.row
        
        let section = tableView.numberOfSections - 1
        
        if row < 0 || section < 0{
            print("row or section == 0")
            return
        }
        
        let count = tableView.numberOfRows(inSection: section)
        
        //如果是最后一行，同时没有开始上拉刷新
        if row == (count - 1) && !isPull{
            print("上拉刷新")
            isPull = true
            
            //load more data
            loadDatas()
        }
    }
}

