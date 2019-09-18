//: [Previous](@previous)

import Foundation

/*
    Swift中的扩展类似于OC中的分类
    扩展可以为枚举、i结构体、类、协议添加新功能
      可以添加方法、计算属性、下标、（便捷）初始化器、嵌套类型、协议等
 
    扩展不能办到的事
      不能覆盖原有的功能
      不能添加存储属性，不能向已有的属性添加属性观察器
      不能添加父类
      不能添加指定初始化器，不能添加反初始化器
      ......
 */


extension Double {
    var km: Double { return self * 1_000.0 }
    var m: Double { return self }
    var dm: Double { return self / 10.0 }
    var cm: Double { return self / 100.0 }
    var mm: Double { return self / 1_000.0 }
}


extension Array {
    subscript(nullable idx: Int) -> Element? {
        if (startIndex..<endIndex).contains(idx){
            return self[idx]
        }
        return nil
    }
}

extension Int {
    func repetitions(task: () -> Void) {
        for _ in 0..<self {
            task()
        }
    }
    
    mutating func square() -> Int {
        self = self * self
        return self
    }
    
    enum Kind {
        case negative, zero, positive
    }
    var kind : Kind {
        switch self {
        case 0:
            return .zero
        case let x where x > 0:
            return .positive
        default:
            return .negative
        }
    }
    
    subscript(digitIndex: Int) -> Int {
        var decimalBase = 1
        for _ in 0..<digitIndex {
            decimalBase *= 10
        }
        return (self / decimalBase) % 10
    }
}


/*
    如果希望自定义初始化器的同时，编辑器也能够生成默认初始化器
    可以在扩展中编写自定义初始化器
    required初始化器也不能写在扩展中
 */

class Person {
    var age: Int
    var name: String
    init(age: Int, name: String) {
        self.age = age
        self.name = name
    }
}

extension Person : Equatable {
    static func == (left: Person, right: Person) -> Bool {
        return left.age == right.age && left.name == right.name
    }
    convenience init() {
        self.init(age: 0, name: "Leo")
    }
}

/*
    如果一个类型已经实现了协议的所有的要求，但是还没有声明它遵守了这个协议
    可以通过扩展来让它遵守这个协议
 */

protocol TestProtocol {
    func test()
}

class TestClass {
    func test() {
        print("test")
    }
}

extension TestClass : TestProtocol {}


func isOdd<T: BinaryInteger>(_ i: T) -> Bool {
    return i % 2 != 0
}

extension BinaryInteger {
    func isOdd() -> Bool {
        return self % 2 != 0
    }
}


/*
    扩展可以给协议提供默认实现，间接实现 可选协议 的效果
    扩展可以给协议扩充 协议中从未声明过的方法
 */

extension TestProtocol {
    func test() {
        print("TestProtocol test")
    }
    func test1() {
        print("TestProtocol test1")
    }
}


class TestClass1: TestProtocol {}

var cls = TestClass1()
cls.test()
cls.test1()

var cls2: TestProtocol = TestClass1()
cls2.test1()
cls2.test()

class TestClass2 : TestProtocol {
    func test1() {
        print("TestClass test1")
    }
    func test() {
        print("TestClass test")
    }
}

var cls3 = TestClass2()
cls3.test1()
cls3.test()

var cls4 : TestProtocol = TestClass2()
cls4.test1()
cls4.test()




//扩展中也可以使用原类型中的泛型类型
class Stack<E> {
    var elements = [E]()
}

extension Stack {
    func top() -> E {
        return elements.last!
    }
}

// 泛型E遵守Equatable才扩展
extension Stack : Equatable where E : Equatable {
    static func == (left: Stack ,right: Stack) -> Bool {
        return left.elements == right.elements
    }
}





//: [Next](@next)
