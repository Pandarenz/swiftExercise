//
//  ViewController.swift
//  Router
//
//  Created by JiWuChao on 2019/8/1.
//  Copyright © 2019 JiWuChao. All rights reserved.
//

import UIKit
let router:SJRouter = SJRouter()
class ViewController: UIViewController {
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
       
        router.openUrl(fromURL: "SJModule://home/find", parameters: ["userName":"zhangsan","age":12]) { (success, error) in
            print(success)
            print(error)
        }
        
    }


}

