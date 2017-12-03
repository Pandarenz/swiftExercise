//
//  ViewController.swift
//  tableView
//
//  Created by JiWuChao on 2017/8/24.
//  Copyright © 2017年 JiWuChao. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI();
        let btn = UIButton(type: UIControlState(rawValue:0))
        
        
    }

    func setUI ()  {
        let tableView = UITableView(frame: view.bounds, style: .plain)
        view.addSubview(tableView)
tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellID")
        tableView.delegate = self;
        tableView.dataSource = self;
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath)
        //textLabel 是可选的
        cell.textLabel?.text = "\(indexPath.row)"
        return cell
    }
}

