//
//  ViewController.swift
//  构造函数
//
//  Created by JiWuChao on 2017/10/14.
//  Copyright © 2017年 JiWuChao. All rights reserved.
//

import UIKit

/*
    在 swift 中 默认同一个项目中(同一个命名空间)所有的数据都是共享的 可以直接访问 不需要 import 所有对象的属性 var 也可以直接访问到
 
 */
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
       
        
        // 实例化 person
        // () -> alloc / init
        // swift 中对应一个函数 init()构造函数
        // 作用:给成员变量分配空间初始化成员变量
        let p = Person()
        
        print(p.name) // 输出 :<ÊûÑÈÄ†ÂáΩÊï∞.Person:  0x600000008750>
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

