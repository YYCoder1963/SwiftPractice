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

class Stack2<E> : Stackable {
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

var ss = StringStack()
ss.push("lyy")
ss.pop()

//类型约束
protocol Runnable {}
class Person {}
func swapValues<P: Person & Runnable>(_ a: inout P, _ b: inout P){
    (a, b) = (b, a)
}



protocol Stackable1 {
    associatedtype Element: Equatable
}

class Stack3<E: Equatable> : Stackable1 {
    typealias Element = E
}

func equal<S1: Stackable1, S2: Stackable1>(_ s1: S1, _ s2: S2) -> Bool
    where S1.Element == S2.Element, S1.Element : Hashable {
        return false
}

var stack10 = Stack3<Int>()
var stack11 = Stack3<Int>()
equal(stack10, stack11)


//协议类型的注意点
class Person1 : Runnable {}
class Car : Runnable {}
func get(_ type: Int) -> Runnable {
    if type == 0 {
        return Person1()
    }
    return Car()
}


protocol Runnable1 {
    associatedtype Speed
    var speed : Speed { get }
}

class Dog : Runnable {
    var speed : Double { return 0.0 }
}

class Jeep : Runnable {
    var speed : Int { return 0 }
}


func get1(_ type: Int) -> Runnable {
    if type == 0 {
        return Dog()
    }
    return Jeep()
}



func get<T : Runnable>(_ Type: Int) -> T {
    if Type == 0 {
        return Person1() as! T
    }
    return Car() as! T
}

//用some关键字声明一个不透明类型
//func get2(_ type: Int) -> some Runnable {
//    return Car()
//}


//some限制只能返回一种类型
//func get(_ type: Int) -> some Runnable {
//    if type == 0 {
//        return Person()
//    }
//    return Car()
//}


//some也可以用在属性类型上
//class Person5 {
//    var per: some Runnable {
//        return Dog()
//    }
//}


/* 可选项的本质是enum类型
 
 public enum Optional<Wrapped> : ExpressibleByNilLiteral {
    case none
    case some(Wrapped)
    public init(_ some: Wrapped)
 }
 
*/

var age: Int? = 1
var age1: Optional<Int> = Optional<Int>.some(10)
var age2: Optional = .some(1)
var age3 = Optional.some(1)
var age4 = Optional(10)
age = nil
age1 = .none

switch age {
case let v?:
    print("some",v)
case nil:
    print("none")
}

switch age1 {
case let .some(v):
    print("some",v)
case .none:
    print("none")
}


var age_: Int? = 11
var age5: Int?? = age_

var age6 = Optional.some(Optional.some(1))
//age6 = .none
var age7 = age6!
var age8 = age7!
print(age6 as Any,age7 as Any,age8)



//: [Next](@next)

