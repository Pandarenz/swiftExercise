//
//  ViewController.swift
//  testCrossroad
//
//  Created by JiWuChao on 2019/8/1.
//  Copyright © 2019 JiWuChao. All rights reserved.
//

import UIKit
import Crossroad

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func BtnAction(_ sender: Any) {
        RouterManager.manager.openTestVC()
        RouterManager.manager.open()
    }
}

