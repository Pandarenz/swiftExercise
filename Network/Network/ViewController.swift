//
//  ViewController.swift
//  Network
//
//  Created by JiWuChao on 2019/7/4.
//  Copyright © 2019 JiWuChao. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    lazy var listVM: LZListVM = {
        let vm = LZListVM()
        return vm
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func action(_ sender: Any) {
        listVM.getListData { (items, des) in
            print(items as Any)
            print(des as Any)
        }
    }
    
}

