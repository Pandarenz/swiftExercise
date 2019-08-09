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
        
//        let string = "httP://longzhu.com/中文/part?年龄=12&&name=ZHAN咱三:SHHS#help"
//        print(string)
//        var set = CharacterSet()
//        set.formUnion(.urlHostAllowed)//URL 中Host子模块中允许的字符集.
//        set.formUnion(.urlPathAllowed)// URL 中domain后面的路径子模块中允许的字符集.
//        set.formUnion(.urlQueryAllowed)// URL中请求信息子模块中允许的字符集.
//        set.formUnion(.urlFragmentAllowed)// 片段URL子模块中允许的字符集.
//        string.addingPercentEncoding(withAllowedCharacters: set).flatMap { URL(string: $0)
//            print(URL(string: $0))
//        }
//        print(string)
        
    }


    @IBAction func BtnAction(_ sender: Any) {
        RouterManager.manager.openTestVC()
        RouterManager.manager.open()
//
        
//        NavigatorRouter.default.open()
    }
}

