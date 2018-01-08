//
//  ViewController.swift
//  testArrayDisorderDemo
//
//  Created by JiWuChao on 2018/1/6.
//  Copyright © 2018年 JiWuChao. All rights reserved.
//

import UIKit

import ArrayDisorderSDK

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let disOrder = ArrayDisorder()
        
        print(disOrder.disorder(orders: [1,2,3,4,5,6,7,8,9]))
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

