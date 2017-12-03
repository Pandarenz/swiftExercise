//
//  ViewController.swift
//  循环引用
//
//  Created by JiWuChao on 2017/9/6.
//  Copyright © 2017年 JiWuChao. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    /*
        循环引用:
        * block 中出现 self 要特别小心
        * '循环'引用 单方向对引用是不会产生循环引用 
        * - 只是对闭包 self 进行了 copy 闭包执行完成之后 会自动销毁,同时释放对 self 的引用
        * - 同时需要 self 对闭包的引用
     ***  解除循环引用 需要打断链条
     方法:
        * OC 的方式
     
     */
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 方法 1 OC 的方式
        
        weak var weakSelf = self;
       
        loadData { 
            print(weakSelf?.view! as Any)
        }
        /*
         为什么 用 var 修饰 weak?
            'weak' 可能会被在运行时修改 -> 指向的对象一旦被释放 会被置为nil
         weakSelf? 为什么后面是?
          解包有两种方式 
            * ? 可选解包 -- 如果 self 已经被释放 不会向对象发送 getter 的消息 更加安全
            * ! 强行解包 -- 如果 self 已经被释放 强行解包会导致崩溃
         */
        
        // 方法 2: swift [ 推荐使用]
        // [weak self] 表示{} 中所有的 self 都是弱引用 需要注意解包
        loadData { [weak self] in
            print(self?.view as Any)
        }
        
        // 方法3 : 知道就好
        
        // [unowned self] 表示 {}中所有的 self 都是 assign 的不会强引用 但是 如果对象释放指针地址不会变化 如果对象释放继续调用 就会出现野指针的问题
        // unowned 与oc 的 __unsafe __retained 等效
        loadData { [unowned self] in
            print(self.view)
        }
        
    }

    
    
    
    var complationCallBack: (()->())?
    
    func loadData (completion:@escaping ()->())->(){
        // 使用属性记录闭包 -> self 对闭包进行了引用
        complationCallBack = completion
        
        DispatchQueue.global().async {
            print("耗时操作")
            completion();
        }
        
    }

}

