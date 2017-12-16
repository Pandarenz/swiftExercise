//
//  ViewController.swift
//  MVVM
//
//  Created by JiWuChao on 2017/12/16.
//  Copyright © 2017年 JiWuChao. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let dataServer = DataServer()
        dataServer.fetchPopularPhoto {[weak self] (success, photos, error) in
            print(photos)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

