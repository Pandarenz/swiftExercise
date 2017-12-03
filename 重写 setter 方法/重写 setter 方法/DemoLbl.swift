//
//  DemoLbl.swift
//  重写 setter 方法
//
//  Created by JiWuChao on 2017/11/2.
//  Copyright © 2017年 JiWuChao. All rights reserved.
//

import UIKit

class DemoLbl: UILabel {

    var p :Person? {
        // 替代 OC 中的重写 setter 方法
        //区别 :再也不用考虑 _成员变量 = 值
        //oc 中如果是copy 属性应该_成员变量 = 值.copy
        didSet {
            //此时 name 属性已经有值 可以直接设置 UI 界面
            text = p?.name
        }
    }
}
