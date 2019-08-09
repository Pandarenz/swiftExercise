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
        
        router.openUrl(fromURL: "SJModule: // home/find/?roomid=测试&userid=时", parameters: ["userName":"姬武超","age":12]) { (success, error) in
            print(success)
            print(error)
            
        }
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 5) {
//            router.removeUrl(url: "// home/find/?roomid=测试&userid=时")
            
            
            switch router.removeURL(url: "JModule: // home/find/?roomid=测试&userid=时") {
            case .Failure(let error):
                print(error.localizedDescription)
            case .Success(let key):
                print(key)
            }
            if router.isCanOpen(url: "// home/find/?roomid=测试&userid=时") {
                print("能打开")
            } else {
                print("不能打开")
            }
        }
        
    }


}

