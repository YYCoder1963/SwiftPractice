//: [Previous](@previous)

import Foundation

// 下面代码中的2、false、"Lee"就是字面量
var age = 2
var isRed = false
var name = "Lee"


/*
 常见字面量的默认类型
 - public typealias IntegerLiteralType = Int
 - public typealias FloatLiteralType = Double
 - public typealias BooleanLiteralType = Bool
 - public typealias StringLiteralType = String
 */

/*
    可以通过typealias修改字面量的默认类型
 */
typealias FloatLiteralType = Float
typealias IntegerLiteralType = UInt8

var f = 1.1
var i = 1

/*
 Swift自带的绝大部分类型，都支持直接通过字面量进行初始化
 Bool、Int、Float、Double、String、Array、Dictionary、Set、Optional
 */

/*
 Swift自带类型能够通过字面量初始化是因为它们遵守了对应的协议
 Float、Double: ExpressibleByIntegerLiteral、ExpressibleByFloatLiteral
 Int : ExpressibleByIntegerLiteral
 Bool : ExpressibleByBooleanLiteral
 String : ExpressibleByStringLiteral
 Dictionary : ExpressibleByDictionaryLiteral
 Array、Set: ExpressibleByArrayLiteral
 Optional<Wrapped> : ExpressibleByNilLiteral
 */


//字面量协议的应用
//extension Int: ExpressibleByBooleanLiteral {
//    public init(booleanLiteral value: Bool) {
//        self = value ? 1 : 0
//    }
//}
//var num: Int = true
//print(num)


class Student : ExpressibleByIntegerLiteral,ExpressibleByFloatLiteral,ExpressibleByStringLiteral,CustomStringConvertible {
    var name: String = ""
    var score: Double = 0
    required init(floatLiteral value: Double) {
        self.score = value
    }
    required init(integerLiteral value: Int) {
        self.score = Double(value)
    }
    required init(unicodeScalarLiteral value: String) {
        self.name = value
    }
    required init(stringLiteral value: String) {
        self.name = value
    }
    required init(extendedGraphemeClusterLiteral value: String) {
        self.name = value
    }
    var description: String { return "name=\(name),score=\(score)"}
}

//var stu: Student = 90
//print(stu)
//stu = 98.5
//print(stu)
//stu.name = "Lee"
//print(stu)


struct Point {
    var x = 0.0, y = 0.0
}




extension Point : ExpressibleByArrayLiteral,ExpressibleByDictionaryLiteral {
    init(arrayLiteral elements: Double...) {
        guard elements.count > 0 else { return }
        self.x = elements[0]
        guard elements.count > 1 else { return }
        self.y = elements[1]
    }
    init(dictionaryLiteral elements: (String, Double)...) {
        for (k,v) in elements {
            if k == "x" { self.x = v }
            else if k == "y" { self.y = v }
        }
    }
}

//var p: Point = [10.1, 20.2]
//print(p)
//
//var p: Point = ["x": 11, "y": 22.0]
//print(p)



















//: [Next](@next)
