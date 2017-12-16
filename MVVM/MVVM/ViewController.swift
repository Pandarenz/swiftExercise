//
//  ViewController.swift
//  MVVM
//
//  Created by JiWuChao on 2017/12/16.
//  Copyright © 2017年 JiWuChao. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    var dataSource:[Photo] = [Photo]()
    var coverView = PhotoListView(frame: UIScreen.main.bounds)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(coverView)
        coverView.snp.makeConstraints { (make) in
            make.edges.equalTo(view)
        }
        
        let dataServer = DataServer()
        dataServer.fetchPopularPhoto {[weak self] (success, photos, error) in
            print(photos)
            self?.dataSource = photos
            self?.coverView.dataSource = photos
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

