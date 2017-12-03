//
//  ArithmeticExpression.swift
//  枚举
//
//  Created by JiWuChao on 2017/10/28.
//  Copyright © 2017年 JiWuChao. All rights reserved.
//

import Foundation
//indirect 递归
enum ArithmeticExpression {
    case number(Int)
    indirect case addition(ArithmeticExpression,ArithmeticExpression)
    indirect case multiplication(ArithmeticExpression,ArithmeticExpression)
}
