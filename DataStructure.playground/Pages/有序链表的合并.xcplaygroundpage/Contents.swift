//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

public class SLNode<Int> {
    var value: Int
    var next :SLNode?// 下一个结点
    public init(value:Int) {
        self.value = value
    }
}

public final class SingleLinkList {
    
    public typealias Node = SLNode<Int>
    
    fileprivate var head:Node?
    
    public init() {}
    
    //1 是否为空
    func isEmpty() -> Bool {
        return head == nil
    }
    
    //2 获取首元结点
    public var first:Node?{
        return head
    }
    
    //3 获取尾结点
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
    
    //4 链表的长度
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
    
    
    // 5 结点的获取
    
    func getNode(atIndex index:Int) -> Node? {
        if index >= 0 {
            var node = head
            var i = index
            while node != nil {
                if i == 0 {
                    return node
                }
                i -= 1
                node = node?.next
            }
        }
        return nil
    }
    
    //找到在 index 之前的 node
    func getBeforeNode(atIndex index:Int) -> Node? {
        
        let tempIndex = index - 1
        
        if tempIndex >= 0 {
            var node = head
            var i = tempIndex
            while node != nil {
                if i == 0 {
                    return node
                }
                i -= 1
                node = node?.next
            }
        }
        return nil
    }
    
    
    
    // 链表的添加
    
    public func append(_ value: Int) {
        let newNode = SLNode(value: value)
        if let lastNode = last {
            lastNode.next = newNode
        } else {
            head = newNode
        }
    }
    // 批量添加
    public func append(_ values:Array<Int>) {
        for value in values {
            append(value)
        }
    }
    
    
    //5 链表的插入 插入在第 index 结点
    
    public func insertNode(atIndex index:Int,value:Int) {
        let oldNode = getBeforeNode(atIndex: index)
        let newNode = SLNode(value: value)
        if index > 0 {
            if let old = oldNode {
                newNode.next = old.next
                old.next = newNode
            } else {
                append(value)
            }
        } else {
            append(value)
        }
    }
    //删除在某一个 位置的结点
    public func removeNode(atIndex index:Int) {
        let beforeNode = getBeforeNode(atIndex: index)
        if let before = beforeNode {
            before.next = before.next?.next
        }
    }
    // 删除所有结点
    public func removeAll() {
        head = nil
    }
    // 插入一个值 不指定位置 按 升序插入
    func insert(value: Int) {
        if self.head == nil {
            self.head = Node.init(value: value)
        } else {
            self.insert(node: &self.head!, value: value)
        }
    }
    // inout 内部可以改变外面传的参数值
    func insert(node: inout Node, value: Int) {
        if value > node.value {
            if node.next == nil {
                node.next = Node.init(value: value)
            } else {
                self.insert(node: &node.next!, value: value)
            }
        } else {
            // val is less than node, squeeze in node
            let newNode = Node.init(value: value)
            // replace val
            newNode.next = node
            node = newNode
        }
    }
    
    /// 链表合并
    ///
    /// - Parameter list: <#list description#>
    func merge(list: SingleLinkList) {
        var listNode = list.head
        while listNode != nil {
            self.insert(value: listNode!.value)
            listNode = listNode!.next
        }
    }
    
}

extension SingleLinkList:CustomStringConvertible {
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

var link = SingleLinkList.init()
    link.append([1,3,5,6,8,10])
    print(link)
var linkTow = SingleLinkList.init()
    linkTow.append([0,2,4,7,9,11])
    link.merge(list: linkTow)
    print(link)



