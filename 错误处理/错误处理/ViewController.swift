//
//  ViewController.swift
//  错误处理
//
//  Created by JiWuChao on 2017/12/4.
//  Copyright © 2017年 JiWuChao. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let jsonString = "{\"name\":\"zhangsan\"}"
        let data = jsonString.data(using: .utf8)
        // 方法1 推荐使用 try? (弱 try)如果解析成功就有值 反之为 nil
        let json1 = try? JSONSerialization.jsonObject(with: data!, options: [])
        print(json1)
        //方法2 try (强 try)不推荐使用 如果解析成功就有值 反之就崩溃 有风险
        let json2 = try! JSONSerialization.jsonObject(with: data!, options: [])
        print(json2)
        // 方法3 处理异常 do -catch 能够接收到错误并且能输出错误
        //但是: 语法结构复杂 而且 {}提示不友好
        // OC 中有 try - catch 有人用吗 为什么?
        // 因为用 ARC 开发编译器自动添加 retain/relese/autoreloese 如果用 try-catch 一旦不平衡 就会出现内存泄露
        do {
            let json3 = try JSONSerialization.jsonObject(with: data!, options: [])
            print(json3)
        } catch  {
            print(error)
        }
        
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

