//: Playground - noun: a place where people can play

import Foundation

public class LinkedList<T> {
    public typealias Node = LinkedList<T>
    private var head :Node?
    
    public var isEmpty:Bool {
     return head == nil
    }
    public var first:Node? {
        return head
    }
    
  
    
}

let list = LinkedList<String>()

list.isEmpty
list.first




