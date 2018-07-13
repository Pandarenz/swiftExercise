//
//  ViewController.swift
//  LinkList
//
//  Created by JiWuChao on 2018/7/13.
//  Copyright © 2018年 JiWuChao. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let list = LinkList<String>()
        list.append("hello")
        print(list.first?.value)
        
    }

    

}

