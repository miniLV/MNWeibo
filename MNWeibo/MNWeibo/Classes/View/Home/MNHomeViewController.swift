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

    private lazy var list = [String]()

    override func loadDatas() {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            
            for i in 0..<20 {
                
                if self.isPull{
                    //上拉
                    self.list.append("上拉 ==> \(i)")
                }else{
                    //下拉
                    self.list.insert(i.description, at: 0)
                }
            }
            self.tableView?.reloadData()
            self.refreshControl?.endRefreshing()
            self.isPull = false
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
       return list.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: cellID)
        }
        cell.textLabel?.text = list[indexPath.row]
        return cell
    }
}

extension MNHomeViewController{

    override func setupTableView() {
        super.setupTableView()
        naviItem.leftBarButtonItem = UIBarButtonItem(title: "好友", fontSize: 16, target: self, action: #selector(showFridends))
        
        tableView?.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
    }
}
