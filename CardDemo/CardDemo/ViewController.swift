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
    }

}

