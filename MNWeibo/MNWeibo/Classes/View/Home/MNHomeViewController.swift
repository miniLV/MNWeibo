//
//  MNHomeViewController.swift
//  MNWeibo
//
//  Created by miniLV on 2020/3/10.
//  Copyright © 2020 miniLV. All rights reserved.
//

import UIKit

private let cellID = "cellID"

class MNHomeViewController: MNBaseViewController {

    private lazy var listViewModel = MNStatusListViewModel()

    override func loadDatas() {
        
        listViewModel.loadStatus(pullup: self.isPull) { (isSuccess, needRefresh)   in
            self.refreshControl?.endRefreshing()
            self.isPull = false
            if needRefresh{
                self.tableView?.reloadData()
            }
        }
    }

    @objc func showFridends() {
        let vc = DemoViewController.init()
        vc.title = "Demo"
        navigationController?.pushViewController(vc, animated: true)
    }
}


extension MNHomeViewController{
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listViewModel.statusList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! MNHomeNormalCell
        
        let cell = MNHomeNormalCell(style: .default, reuseIdentifier: cellID)
        
//        if cell == nil {
//            cell = MNHomeNormalCell(style: .default, reuseIdentifier: cellID)
//        }
        
        let viewModel = listViewModel.statusList[indexPath.row]
        cell.contentLabel.text = viewModel.status.text
        cell.nameLabel.text = viewModel.status.user?.screen_name
        return cell
    }
}

extension MNHomeViewController{

    override func setupTableView() {
        super.setupTableView()
        tableView?.rowHeight = UITableView.automaticDimension
        tableView?.estimatedRowHeight = 250
        tableView?.separatorStyle = .none
        naviItem.leftBarButtonItem = UIBarButtonItem(title: "好友", fontSize: 16, target: self, action: #selector(showFridends))
        
        tableView?.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
    }
}
