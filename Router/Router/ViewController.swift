//
//  ViewController.swift
//  Router
//
//  Created by JiWuChao on 2019/8/1.
//  Copyright © 2019 JiWuChao. All rights reserved.
//

import UIKit
let router:LZURLRouter = LZURLRouter()
class ViewController: UIViewController {
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        router.openUrl(fromURL: "SJModule: // home/find?roomid=测试&userid=时", parameters: ["userName":"姬武超","age":12]) { (success, error) in
            print(success)
            print(error)
        }
        
    }


}

