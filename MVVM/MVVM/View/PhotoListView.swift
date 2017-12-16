//
//  PhotoListView.swift
//  MVVM
//
//  Created by JiWuChao on 2017/12/17.
//  Copyright © 2017年 JiWuChao. All rights reserved.
//

import Foundation

import UIKit

class PhotoListView: UIView {

   lazy var tableView :UITableView =  {
       return UITableView(frame: UIScreen.main.bounds, style: .plain)
    }()
    
    var dataSource:[Photo] = [Photo]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupU()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupU() {
        tableView.register(PhotoListCell.self, forCellReuseIdentifier: "CellID")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 150
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.separatorInset = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
        self.addSubview(tableView)
    }
}


extension PhotoListView {
    
}


extension PhotoListView:UITableViewDelegate,UITableViewDataSource {
    //UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CellID", for: indexPath) as? PhotoListCell else {
            fatalError("Cell not exists in storyboard")
        }
        cell.updateCellWithModel(cellModel: dataSource[indexPath.row])
        return cell
    }
    //UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.width
    }
    
    
}





