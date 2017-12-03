//: [Previous](@previous)

import Foundation

// 在异步执行任务 获取结果 通过 block/闭包回调 
    //* 闭包的应用场景和 block 完全一致
func loadData() {
    // 将任务添加到队列 指定执行任务的函数
    //翻译: '队列'调度任务(block/ 闭包),以同步/异步 的方式执行
    
    DispatchQueue.global().async {
    print("耗时操作\(Thread.current)")
        // 主队列回调
        DispatchQueue.main.async {
            print("主线程更新 UI\(Thread.current)")
        }
    }
}

loadData()




