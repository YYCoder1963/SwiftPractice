//: [Previous](@previous)

import Foundation

/*
    泛型可以将类型参数化，提高代码复用率，减少代码量
 */

func swapValues<T>(_ a: inout T, _ b: inout T) {
    (a , b) = (b, a)
}

var i1 = 10
var i2 = 20
swapValues(&i1, &i2)


struct Date {
    var year = 0, month = 0, day = 0
}

var date1 = Date(year: 2019, month: 09, day: 21)
var date2 = Date(year: 2019, month: 9, day: 11)
swapValues(&date1, &date2)

//泛型函数赋值给变量
func test<T1, T2>(_ t1: T1,_ t2: T2){}
var fn: (Int, Double) -> () = test


class Stack<E> {
    var elements = [E]()
    func push(_ element: E) {
        elements.append(element)
    }
    func pop() -> E {
        return elements.removeLast()
    }
    func top() -> E {
        return elements.last!
    }
    func size() -> Int {
        return elements.count
    }
}

var stack = Stack<Int>()
stack.push(1)
stack.size()
stack.pop()
stack.size()

struct Stack1<E> {
    var elements = [E]()
    mutating func push(_ element: E){ elements.append(element) }
    mutating func pop() -> E { return elements.removeLast() }
    func top() -> E {
        return elements.last!
    }
    func size() -> Int {
        return elements.count
    }
}

var stack1 = Stack1<Int>()
stack1.push(12)
stack1.size()
stack1.pop()

enum Score<T> {
    case point(T)
    case grade(String)
}

let score1 = Score<Int>.point(99)
let score2 = Score.point(98)
let score3 = Score.point(99.5)
let score4 = Score<Int>.grade("A")


/*
    关联类型：给协议中用到的类型定义一个占位名称
    协议中可以拥有多个关联类型
 */

protocol Stackable {
    associatedtype Element
    mutating func push(_ element: Element)
    mutating func pop() -> Element
    func top() -> Element
    func size() -> Int
}

class StringStack : Stackable {
    typealias Element = String
    var elements = [String]()
    func push(_ element: String) {
        elements.append(element)
    }
    func pop() -> String {
        return elements.removeLast()
    }
    func top() -> String {
        return elements.last!
    }
    func size() -> Int {
        return elements.count
    }
}















//: [Next](@next)

