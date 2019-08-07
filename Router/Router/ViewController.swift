//
//  ViewController.swift
//  Router
//
//  Created by JiWuChao on 2019/8/1.
//  Copyright © 2019 JiWuChao. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let router:SJRouter = SJRouter()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        router.register(URL: "SJModule://home/find") { (dic, complate) in
            print(dic)
            complate?(true,nil)
        }

        router.openUrl(fromURL: "SJModule://home/find", parameters: ["userName":"zhangsan","age":12]) { (success, error) in
            print(success)
            print(error)
        }
        
    }


}

