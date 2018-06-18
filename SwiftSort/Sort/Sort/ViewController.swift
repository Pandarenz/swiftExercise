//
//  ViewController.swift
//  Sort
//
//  Created by JiWuChao on 2018/6/19.
//  Copyright © 2018年 JiWuChao. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let insert = InsertSort.init()
        let temp =   insert.insertSort(sortDatas: [2,3,6,4,2,0,10,2,3,6,4,2,0,10,2,3,6,4,2,0,10,2,3,6,4,2,0,10,2,3,6,4,2,0,10])
        print(temp)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

