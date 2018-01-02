//
//  ViewController.swift
//  CardDemo
//
//  Created by JiWuChao on 2017/12/19.
//  Copyright © 2017年 JiWuChao. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
 
    override func viewDidLoad() {
        super.viewDidLoad()
        let card = Card()
        
        view.addSubview(card)
        card.snp.makeConstraints { (make) in
            make.edges.equalTo(view)
        }
        let arr = ["1","2","3","4","5","6","7","8","9","10",]
        var iter = arr.makeIterator()
        while let name = iter.next() {
            print(name)
        }
        
 }
}
