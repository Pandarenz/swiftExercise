//: Playground - noun: a place where people can play

import UIKit

/*
 属性要求
 协议可以要求遵循协议的类型提供特定名称和类型的实例属性或类型属性。协议不指定属性是存储型属性还是计算型属性，它只指定属性的名称和类型。此外，协议还指定属性是可读的还是可读可写的。
 
 如果协议要求属性是可读可写的，那么该属性不能是常量属性或只读的计算型属性。如果协议只要求属性是可读的，那么该属性不仅可以是可读的，如果代码需要的话，还可以是可写的。
 
 协议总是用 var 关键字来声明变量属性，在类型声明后加上 { set get } 来表示属性是可读可写的，可读属性则用 { get } 来表示：
 
 protocol SomeProtocol {
 var mustBeSettable: Int { get set }
 var doesNotNeedToBeSettable: Int { get }
 }
  */
protocol FullName {
    var fullName :String {get}
    
}

struct Person :FullName  {
    var fullName: String
    
}

let john = Person(fullName: "john")


print("john's fullName",john.fullName)

class Starship:FullName {
    var prefix :String?
    var name :String
    init(name:String,prefix:String? = nil) {
        self.name = name
        self.prefix = prefix
    }
    var fullName: String {
        return (prefix != nil ? prefix! + "" : "") + name
    }
    
    
}

var ncc1701 = Starship(name: "Enterprise", prefix: "USS")

print(ncc1701.fullName)


/*
 方法要求
 协议可以要求遵循协议的类型实现某些指定的实例方法或类方法。这些方法作为协议的一部分，像普通方法一样放在协议的定义中，但是不需要大括号和方法体。可以在协议中定义具有可变参数的方法，和普通方法的定义方式相同。但是，不支持为协议中的方法的参数提供默认值。
 
 正如属性要求中所述，在协议中定义类方法的时候，总是使用 static 关键字作为前缀。当类类型遵循协议时，除了 static 关键字，还可以使用 class 关键字作为前缀：
 
 */


/*
 RandomNumberGenerator 协议要求遵循协议的类型必须拥有一个名为 random， 返回值类型为 Double 的实例方法。尽管这里并未指明，但是我们假设返回值在 [0.0,1.0) 区间内。
 

 */
protocol RandomNumberGenerator {
    func random() -> Double
}

class LinearCongruentialGenerator: RandomNumberGenerator {
    var lastRandom = 42.0
    let m = 139968.0
    let a = 3877.0
    let c = 29573.0
    func random() -> Double {
        lastRandom = ((lastRandom * a + c).truncatingRemainder(dividingBy:m))
        return lastRandom / m
    }
}

let generator = LinearCongruentialGenerator()
print("Here's a random number: \(generator.random())")


 /*
 
 Mutating 方法要求
 有时需要在方法中改变方法所属的实例。例如，在值类型（即结构体和枚举）的实例方法中，将 mutating 关键字作为方法的前缀，写在 func 关键字之前，表示可以在该方法中修改它所属的实例以及实例的任意属性的值。这一过程在在实例方法中修改值类型章节中有详细描述。
 
 如果你在协议中定义了一个实例方法，该方法会改变遵循该协议的类型的实例，那么在定义协议时需要在方法前加 mutating 关键字。这使得结构体和枚举能够遵循此协议并满足此方法要求。
 
 注意
 实现协议中的 mutating 方法时，若是类类型，则不用写 mutating 关键字。而对于结构体和枚举，则必须写 mutating 关键字。
 
 */


protocol Togglable {
    mutating func toggle()
    
}
enum OnOffSwitch:Togglable {
    case off,on
   mutating func toggle() {
        switch self {
        case .off:
            self = .on
        case .on :
            self = .off
        }
    }
}

var lightSwitch = OnOffSwitch.off


/*
 构造器要求
 协议可以要求遵循协议的类型实现指定的构造器。你可以像编写普通构造器那样，在协议的定义里写下构造器的声明，但不需要写花括号和构造器的实体：
 
 protocol SomeProtocol {
 init(someParameter: Int)
 }
 */

protocol SomeProtocol {
    init(parameter:Int)
}

class SomeClass:SomeProtocol {//你可以在遵循协议的类中实现构造器，无论是作为指定构造器，还是作为便利构造器。无论哪种情况，你都必须为构造器实现标上 required 修饰符：
    required init(parameter: Int) {//使用 required 修饰符可以确保所有子类也必须提供此构造器实现，从而也能符合协议。
        //实现
    }
}


//如果一个子类重写了父类的指定构造器，并且该构造器满足了某个协议的要求，那么该构造器的实现需要同时标注 required 和 override 修饰符：

protocol SomeProtocol2 {
    init()
}

class SomeSuperClass {
    init() {
        // 这里是构造器的实现部分
    }
}

class SomeSubClass: SomeSuperClass, SomeProtocol2 {
    // 因为遵循协议，需要加上 required
    // 因为继承自父类，需要加上 override
    required override init() {
        // 这里是构造器的实现部分
    }
}

