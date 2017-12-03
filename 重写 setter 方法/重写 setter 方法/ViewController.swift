//
//  ViewController.swift
//  重写 setter 方法
//
//  Created by JiWuChao on 2017/11/2.
//  Copyright © 2017年 JiWuChao. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let p = Person()
        p.name = "消化"
        let lbl = DemoLbl(frame: CGRect(x: 10, y: 10, width: 100, height: 30))
        view.addSubview(lbl)
        
        lbl.p = p
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

