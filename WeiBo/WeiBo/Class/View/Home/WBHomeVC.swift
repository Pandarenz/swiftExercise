//
//  WBHomeVC.swift
//  WeiBo
//
//  Created by JiWuChao on 2017/11/14.
//  Copyright © 2017年 JiWuChao. All rights reserved.
//

import UIKit
import Foundation

class WBHomeVC: WBBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    view.backgroundColor = UIColor.cz_random()

    }
    let main  = DispatchQueue.main
    
    private var statusList = [String]()
    
     override func loadData() {
        super.loadData()
        main.asyncAfter(deadline: DispatchTime.now() + 2) {
            
            for i in 0..<15 {
                if self.isPullUp  {
                    self.statusList.append("上啦\(i)")
                } else {
                   self.statusList.insert(i.description, at: 0)
                }
            }
            self.refreshControl?.endRefreshing()
            self.tableView?.reloadData()
            self.isPullUp = false
        }
    }

  @objc private func  showFriends() {
    let vc : WBDemoViewController = WBDemoViewController()
    
    navigationController?.pushViewController(vc, animated: true)
    
    }
}
// MARK: - 表格数据源方法
extension WBHomeVC {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return statusList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath)
        cell.textLabel?.text = statusList[indexPath.row]
        return cell
        
    }
}

extension WBHomeVC {
 
    override func setupUI() {
        super.setupUI()
       
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "好友", font: 16, target: self, action: #selector (showFriends))
        tableView?.register(UITableViewCell.self, forCellReuseIdentifier: "cellID")
        
    }
}


