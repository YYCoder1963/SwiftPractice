//: [Previous](@previous)

import Foundation

/*
    Swift的算数运算符出现溢出时会抛出运行时错误
    Swift有溢出运算符(&+、&-、&*)，用来支持溢出运算
 */

var min = UInt8.min
print(min) // 0
print(min &- 1) //255 循环

var max = UInt8.max
print(max) // 255
print(max &+ 1) // 0
print(max &* 2) //254,等价于 max &+ max


/*
    运算符重载：类、结构体、枚举为现有的运算符提供自定义实现，叫做运算符重载
 */

//struct Point {
//    var x: Int, y: Int
//}
//
//func + (p1: Point, p2: Point) -> Point {
//    return Point(x: p1.x + p2.x, y: p1.y + p2.y)
//}
//
//let p = Point(x: 1, y: 2) + Point(x: 2, y: 3)
//print(p)

//
//struct Point {
//    var x: Int, y: Int
//
//    static func + (p1: Point, p2: Point) -> Point {
//        return Point(x: p1.x + p2.x, y: p1.y + p2.y)
//    }
//
//    static func - (p1: Point, p2: Point) -> Point {
//        return Point(x: p1.x - p2.x, y: p1.y - p2.y)
//    }
//
//    static prefix func - (p: Point) -> Point {
//        return Point(x: -p.x, y: -p.y)
//    }
//
//    static func += (p1: inout Point, p2: Point) -> Point {
//        p1 = p1 + p2
//        return p1
//    }
//
//    static prefix func ++ (p: inout Point) -> Point {
//        return p += Point(x: 1, y: 1)
//    }
//
//    static postfix func ++ (p: inout Point) -> Point {
//        let tmp = p
//        p += Point(x: 1, y: 1)
//        return tmp
//    }
//
//    static func == (p1: Point, p2: Point) -> Bool{
//        return (p1.x == p2.x) && (p1.y == p2.y)
//    }
//}


/*
    实现实例的等价，一般做法是遵守Equatable协议，重载 == 运算符
    与此同时，也等于重载了 != 运算符
 
    Swift为以下类型提供默认的Equatable实现
    没有关联类型的枚举
    只拥有遵守Equatable协议关联类型的枚举
    只拥有遵守Equatable协议存储属性的结构体
 
    引用类型比较存储的地址是否相等（是否引用着同一个对象），使用恒等运算符 === 、 !==
 */

struct Location : Equatable {
    var x: Int, y: Int // Int类型遵守Equatable协议，有默认实现
}

var p1 = Location(x: 1, y: 1)
var p2 = Location(x: 11, y: 12)
print(p1 == p2) // false
print(p1 != p2) // true


/*
    比较两个实例的大小，一般遵守 Comparable 协议，重载相应运算符
 */

struct Student : Comparable {
    var age : Int
    var score : Int
    init(score: Int, age: Int) {
        self.score = score
        self.age = age
    }
    
    static func < (lhs: Student, rhs: Student) -> Bool {
        return (lhs.score < rhs.score) || (lhs.score == rhs.score && lhs.age > rhs.age)
    }
    
    static func > (lhs: Student, rhs: Student) -> Bool {
        return (lhs.score > rhs.score) || (lhs.score == rhs.score && lhs.age < rhs.age)
    }
    
    static func <= (lhs: Student, rhs: Student) -> Bool {
        return !(lhs > rhs)
    }
    
    static func >= (lhs: Student, rhs: Student) -> Bool {
        return !(lhs < rhs)
    }
}

var stu1 = Student(score: 100, age: 20)
var stu2 =  Student(score: 99, age: 18)
var stu3 =  Student(score: 99, age: 20)

print(stu1 > stu2)
print(stu2 > stu3)
print(stu3 <= stu1)
print(stu1 >= stu2)


/*
    自定义运算符
    prefix operator 前缀运算符
    postfix operator 后缀运算符
    infix operator 中缀运算符 ： 优先级组
 
    precedencegroup 优先级组 {
        associativity:结合性（left/right/none）
        higherThan: 比谁的优先级高
        lowerThan: 比谁的优先级低
        assignment: true代表在可选链操作中拥有跟赋值运算符一样的优先级
    }
 
 */




precedencegroup PlusMinusPrecedence {
    associativity : none
    higherThan : AdditionPrecedence
    lowerThan : MultiplicationPrecedence
    assignment : true
}
prefix operator +++
infix operator +- : PlusMinusPrecedence

struct Point {
    var x: Int, y: Int
    static prefix func +++ (p: inout Point) -> Point {
        p = Point(x: p.x + p.x, y: p.y + p.y)
        return p
    }
    
    static func +- (left: Point? ,right: Point) -> Point {
        return Point(x: left?.x ?? 0 + right.x, y: left?.y ?? 0 - right.y)
    }
}

struct Person {
    var point : Point
}

var person: Person? = nil
var p = person?.point +- Point(x: 1, y: 3)









//: [Next](@next)
