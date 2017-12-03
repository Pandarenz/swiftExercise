//
//  ViewController.swift
//  setter
//
//  Created by JiWuChao on 2017/11/2.
//  Copyright © 2017年 JiWuChao. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let p = Person()
        p.name = "lao ji "
        print(p.name ?? "hahh")
        print(p.title)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

