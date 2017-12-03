//
//  Barcode.swift
//  枚举
//
//  Created by JiWuChao on 2017/10/28.
//  Copyright © 2017年 JiWuChao. All rights reserved.
//

import Foundation
/*
 定义一个名为Barcode的枚举类型，它的一个成员值是具有(Int，Int，Int，Int)类型关联值的upc，另一个成员值是具有String类型关联值的qrCode。
 */

enum Barcode {
    case upc(Int,Int,Int,Int)
    case qrCode(String)
}
