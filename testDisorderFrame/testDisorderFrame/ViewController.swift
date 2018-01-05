//
//  ViewController.swift
//  testDisorderFrame
//
//  Created by JiWuChao on 2018/1/6.
//  Copyright © 2018年 JiWuChao. All rights reserved.
//

import UIKit

//

/*
 1 找不到 framework
 //https://stackoverflow.com/questions/29500227/getting-error-no-such-module-using-xcode-but-the-framework-is-there
 原因就是 Framework Search Path 中的路径错了 可以参考 https://stackoverflow.com/questions/29500227/getting-error-no-such-module-using-xcode-but-the-framework-is-there 解决办法手动设置 这个路径是你向引用你的 framework 的项目拖自定义的 framework 时自动生成的 所以简单的解决方案就是 删除 framework 重新拖入 注意:拖的时候一定要确保 framework 和目标项目在同一个文件夹下,这样就不会出问题了
 2 找不到类
 //'ArrayDisorder' is unavailable: cannot find Swift declaration for this class
 https://stackoverflow.com/questions/29851550/myclass-is-unavailable-cannot-find-swift-declaration-for-this-class-release-b
 framework 的架构错误: 如果如你的 framework 需要在模拟器上跑 那么你的 framework 必须包含x86
 如果还需要在真机上跑 那么必须包含arm64 架构 可以用命令检查架构 lipo -info
 
 lipo -info  /Users/JiWuChao/MyGit/swiftE/testDisorderFrame/testDisorderFrame/SwiftFramework.framework/SwiftFramework
 Non-fat file: /Users/JiWuChao/MyGit/swiftE/testDisorderFrame/testDisorderFrame/SwiftFramework.framework/SwiftFramework
 
 查看架构
 3  Reason: image not found
 Message from debugger: Terminated due to signal 6
 
 动态库 embedded binaries没有 添加 your framework name.framework -> 添加
 如果是静态库 则不需要添加
 
 4 arc4random_uniform 和 arc4random（） 区别
 
 
 5 设置动态和静态库
 
 点击 framework 的 target build settings - linking -> Mach-o Type  -> Static Library
 或者 Dynamic Library
 
 */
import SwiftFramework

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let disOrder = ArrayDisorder()
        
        print(disOrder.disorder(orders: [1,2,3,4,5,6,7,8,9]))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

