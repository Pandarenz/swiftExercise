//
//  LinkList.swift
//  LinkList
//
//  Created by JiWuChao on 2018/7/13.
//  Copyright © 2018年 JiWuChao. All rights reserved.
//

import Foundation

public final class LinkList<T> {
    
   public typealias Node = linkedListNode<T>
    //头结点
    fileprivate var head:Node?
    
    public init() {}
    //链表是否为空
    public var isEmpty:Bool {
        return head == nil
    }
    
    //获取头结点
    public var first:Node?{
        return head
    }
    
    //获取尾结点
    public var last:Node? {
        if var node = head {
            while case let next? = node.next {
                node = next
            }
            return node
        } else {
            return nil
        }
    }
    // 链表的长度
    public var count:Int {
        if var node = head {
            var c = 1
            while case let next? = node.next {
                node = next
                c += 1
            }
            return c
        } else {
            return 0
        }
     
    }
    
    // 返回某个 index 的结点
    
    public func node(atIndex index:Int) -> Node? {
        if index >= 0 {
            var node = head
            var i = index
            while node != nil {
                if index == 0 {
                    return node
                }
                i -= 1
                node = node!.next
            }
        }
        
        return nil
    }
    
    //下标语法
    public subscript(index: Int) -> T {
        let node = self.node(atIndex: index)
        assert(node != nil)
        return node!.value
    }
    
    func append(_ value:T) {
        let newNode = Node(value: value)
        self.append(newNode)
        
    }
    func append(_ node:Node) {
        let newNode = linkedListNode(value: node.value)
        if let lastNode = last {
            newNode.previous = lastNode
            lastNode.next = newNode
        } else {
            head = newNode
        }
        
    }
    
    //把一个链表添加到另一个链表之后
    public func append(_ list: LinkList) {
        var nodeToCopy = list.head
        while let node = nodeToCopy {
            self.append(node.value)
            nodeToCopy = node.next
        }
    }
    
    //获取某一 index 的前结点和后结点
    private func nodesBeforeAndAfter(index: Int) -> (Node?, Node?) {
        assert(index >= 0)
        
        var i = index
        var next = head
        var prev: Node?
        
        while next != nil && i > 0 {
            i -= 1
            prev = next
            next = next!.next
        }
        assert(i == 0)  // if > 0, then specified index was too large
        
        return (prev, next)
    }
    //插入一个结点
    public func insert(_ value: T, atIndex index: Int) {
        let newNode = Node(value: value)
        self.insert(newNode, atIndex: index)
    }
    
    public func insert(_ node: Node, atIndex index: Int) {
        let (prev, next) = nodesBeforeAndAfter(index: index)
        let newNode = linkedListNode(value: node.value)
        newNode.previous = prev
        newNode.next = next
        prev?.next = newNode
        next?.previous = newNode
        
        if prev == nil {
            head = newNode
        }
    }
    
    public func insert(_ list: LinkList, atIndex index: Int) {
        if list.isEmpty { return }
        var (prev, next) = nodesBeforeAndAfter(index: index)
        var nodeToCopy = list.head
        var newNode: Node?
        while let node = nodeToCopy {
            newNode = Node(value: node.value)
            newNode?.previous = prev
            if let previous = prev {
                previous.next = newNode
            } else {
                self.head = newNode
            }
            nodeToCopy = nodeToCopy?.next
            prev = newNode
        }
        prev?.next = next
        next?.previous = prev
    }
    
    /// Function to remove all nodes/value from the list
    public func removeAll() {
        head = nil
    }
    
    @discardableResult public func remove(node: Node) -> T {
        let prev = node.previous
        let next = node.next
        
        if let prev = prev {
            prev.next = next
        } else {
            head = next
        }
        next?.previous = prev
        
        node.previous = nil
        node.next = nil
        return node.value
    }
    @discardableResult public func removeLast() -> T {
        assert(!isEmpty)
        return remove(node: last!)
    }
    
    @discardableResult public func remove(atIndex index: Int) -> T {
        let node = self.node(atIndex: index)
        assert(node != nil)
        return remove(node: node!)
    }
    
}
