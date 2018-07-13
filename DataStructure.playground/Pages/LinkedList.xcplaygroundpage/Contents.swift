//: [Previous](@previous)

import Foundation

//定义一个 结点 双向链表的结点定义格式
public class LinkListNode<T> {
    var value: T
    var next :LinkListNode?// 下一个结点
    weak var previous :LinkListNode?//前一个结点
    public init(value:T) {
        self.value = value
    }
}



/*
 总结：
 
    链式存储结构中，如果链表有头结点，则头指针指向头结点；否则头指针指向第一元素结点。
 
 任何情况下，头指针都存在，无论链表是否为空。
 
 头结点是为了方便同一操作额外添加的，通过添加头结点，对在第一个元素结点前插入新结点或者删除新结点的操作与对其他结点的插入删除操作一致。
 
 头结点根据实现可有可无。
 
 */

public final class LinkedList<T> {
    
    public typealias Node = LinkListNode<T>
    //头结点 ：链表中的第一个结点的存储位置叫做头指针，如果为了方便 也可以在单链表的第一个结点前设置一个结点 称为头结点 头结点的数据与可以不存储任何数据，此时头结点的指针域指向第一个结点的指针
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
        let newNode = LinkListNode(value: node.value)
        if let lastNode = last {
            newNode.previous = lastNode
            lastNode.next = newNode
        } else {
            head = newNode
        }
        
    }
    
    //把一个链表添加到另一个链表之后
    public func append(_ list: LinkedList) {
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
        let newNode = LinkListNode(value: node.value)
        newNode.previous = prev
        newNode.next = next
        prev?.next = newNode
        next?.previous = newNode
        
        if prev == nil {
            head = newNode
        }
    }
    
    public func insert(_ list: LinkedList, atIndex index: Int) {
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

extension LinkedList:CustomStringConvertible {
    public var description: String {
        var s = "["
        var node = head
        while node != nil {
            s += "\(node!.value)"
            node = node?.next
            if node != nil {
                s += ", "
            }
        }
        return s + "]"
    }
}


extension LinkedList {
    // 链表翻转
    public func reverse() {
        var node = head
        while let currentNode = node {
            node = currentNode.next // 把下一个赋值给node
            swap(&currentNode.next, &currentNode.previous) // 交换
            head = currentNode
        }
    }
}

extension LinkedList {
    convenience init(array: Array<T>) {
        self.init()
        for element in array {
            self.append(element)
        }
    }
}


let lin = LinkedList<String>()
lin.append("姬武超")
lin.isEmpty
lin.first?.value

let lined2 = LinkedList<String>()

    lined2.append("aaaa")

    lin.append(lined2)

    print(lin)
lin.reverse()

lin.insert("2121", atIndex: 1)

lined2.removeAll()





