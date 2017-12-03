//
//  ViewController.swift
//  构造函数 KVC
//
//  Created by JiWuChao on 2017/10/25.
//  Copyright © 2017年 JiWuChao. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let p  = Person(dict: ["name":"21" as AnyObject,"age":10 as AnyObject])
        print(p.name ?? "sa")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

