//
//  LinkListNode.swift
//  LinkList
//
//  Created by JiWuChao on 2018/7/13.
//  Copyright © 2018年 JiWuChao. All rights reserved.
//

import Foundation

public class linkedListNode<T> {
    
    var value: T
    var next :linkedListNode?
    weak var previous :linkedListNode?
    
    public init(value:T) {
        self.value = value
    }
    
    
    
}
