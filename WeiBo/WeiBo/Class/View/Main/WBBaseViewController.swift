//
//  WBBaseViewController.swift
//  WeiBo
//
//  Created by JiWuChao on 2017/11/14.
//  Copyright © 2017年 JiWuChao. All rights reserved.
//

import UIKit


/// 注意:
// 1 extension 中不能有定义属性
// 2 extension 中不能重写父类的本类方法 重写父类的方法是子类的职责 扩展是对类的扩展
class WBBaseViewController: UIViewController {
    // 如果用户没有登录就不能创建 所以不能用懒加载
    var tableView :UITableView?
    // 刷新控件
    var refreshControl :UIRefreshControl?
    
    var visitordInfo :[String:String]?
    
    var isPullUp = false
    
    var userLogon = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        automaticallyAdjustsScrollViewInsets = false
        loadData()
    }
    
    
    @objc func loadData() {
        refreshControl?.endRefreshing()
    }
}

extension WBBaseViewController {
    
   @objc func setupUI()  {
        view.backgroundColor = UIColor.cz_random()
        setupNav()
    userLogon ? setupTableView() : setupVisitorView()
    loadData()
    }
    
    // 设置表格试图
    private func setupTableView () {
        tableView = UITableView(frame: view.bounds, style: .plain)
        view.insertSubview(tableView!, belowSubview: (navigationController?.navigationBar)!)
        // 设置数据源和代理
        tableView?.delegate = self
        tableView?.dataSource = self
        
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(loadData), for: .valueChanged)
        
//        refreshControl?.attributedTitle
        tableView?.addSubview(refreshControl!)
    }
    
    private func setupVisitorView() {
        let visitorView = WBVisitorView(frame: view.bounds)
        visitorView.visitordInfo = visitordInfo
        view.addSubview(visitorView)
        
    }
    
    
    private func setupNav() {
   navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor:UIColor.darkGray]
    }
    
   
    
}


// swift 实现协议的样式 更像是实现多继承

// MARK: - UITableViewDelegate, UITableViewDataSource
extension WBBaseViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    // 基类只准备方法 子类负责实现 子类的方法 不需要调用 super
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 只是保证没有语法错误
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
         // 判断 indexpath 是否是最后一行
        let row = indexPath.row
        let section = tableView.numberOfSections - 1
        
        if row < 0 || section < 0 {
            return
        }
        
        let count = tableView.numberOfRows(inSection: section)
        // 如果是最后一行 切没哟上拉刷新
        if row == count - 1 && !isPullUp {
            isPullUp = true
            loadData()
            print("上啦刷新")
        }
        
    }
}
