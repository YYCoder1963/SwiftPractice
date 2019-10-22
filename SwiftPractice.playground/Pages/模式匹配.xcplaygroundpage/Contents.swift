//: [Previous](@previous)

import Foundation

/*
 模式:用于匹配的规则，比如switch的case、捕捉错误的catch、if、guard、while、for语句的条件等
 
 Swift中的模式有
 - 通配符模式
 - 标识符模式
 - 值邦定模式
 - 元组模式
 - 枚举Case模式
 - 可选模式
 - 类型转换模式
 - 表达式模式
 */


/*
    通配符模式
    _   匹配任何值
    _？ 匹配非nil值
 */

enum Life {
    case human(name: String, age: Int?)
    case animal(name: String, age: Int?)
}

//func check(_ life: Life) {
//    switch life {
//    case .human(let name, _):
//        print("human",name)
//    case .animal(let name, _?):
//        print("animal",name)
//    default:
//        print("other")
//    }
//}
//
//check(.human(name: "Rose", age: 2))
//check(.animal(name: "Dog", age: nil))


/*
 标识符模式：给对应的变量、常量名赋值
 */

var age = 1
let name = "Jack"


//值邦定模式
//let point = (3, 2)
//switch point {
//case let (x, y):
//    print("The point is at (\(x),\(y))")
//}

//元组模式
//let points = [(0, 0),(1,1),(2,2)]
//for (x, _) in points {
//    print(x)
//}
//
//let name1: String? = "Jack"
//let age1 = 18
//let info: Any = [1, 2]
//switch (name1,age1, info) {
//case (_?, _, _ as String):
//    print("case")
//default:
//    print("default")
//}
//
//var scores = ["Jack": 98, "Rose": 100, "Lily":  88]
//for (name, score) in scores {
//    print(name,score)
//}


// 枚举模式
//if age >= 0 && age <= 9 {
//    print("[0,9]]")
//}
//
//if case 0...9 = age {
//    print("[0,9]")
//}


//guard case 0...9 = age else {
//    return
//}
//print("[0, 9]")

//switch age {
//case 0...9:
//    print("[0,9]")
//default:
//    break
//}

// 可选模式
let i: Int? = nil
if case .some(let x) = i { print(x) }
if case let x? = i { print(x) }


let ages: [Int?] = [nil,25,nil]
for case let age? in ages {
    print(age)
}

for item in ages {
    if let age = item { print(age) }
}


// 类型转换模式
let num: Any = 9
switch num {
// 编译器依然认为num是Any类型
case is Int:
    print("is Int", num)
//case let n as Int:
//    print("as Int",n + 1)
default:
    break
}

class Animal { func eat() { print(type(of: self),"eat") } }

class Dog: Animal {
    func run() {
        print(type(of: self),"run")
    }
}

class Cat: Animal {
    func jump() {
        print(type(of: self),"jump")
    }
}

class Pig: Animal {
    func sleep() {
        print(type(of: self),"sleep")
    }
}

func check(_ animal: Animal) {
    switch animal {
    case let dog as Dog:
        dog.eat()
        dog.run()
    case is Cat:
        animal.eat()
    default:
        break
    }
}

check(Dog())
check(Cat())
check(Pig())

//表达式模式：用在case中
let point = (1, 2)
switch point {
case (0, 0):
    print("(0, 0) is  the origin")
case (-2...2, -2...2):
    print("(\(point.0), \(point.1)) is near the origin)")
default:
    print("The point is at (\(point.0), \(point.1))")
}

//自定义表达式模式

// 通过重载运算符，自定义表达式模式的匹配规则
struct Student {
    var score = 0, name = ""
    static func ~= (pattern: Int, value: Student) -> Bool { value.score >= pattern }
    static func ~= (pattern: ClosedRange<Int>, value: Student) -> Bool { pattern.contains(value.score) }
    static func ~= (pattern: Range<Int>, value: Student) -> Bool { pattern.contains(value.score) }
}

var stu = Student(score: 88, name: "Lee")
switch stu {
case 100: print("💯")
default:
    break
}

if case 80 = stu {
    print("80")
}

var info = (Student(score: 89, name: "Lily"), "优秀")
switch info {
case let (89, text):
    print(text)
default:
    break
}


extension String {
    static func ~= (pattern: (String) -> Bool, value: String) -> Bool {
        pattern(value)
    }
}

func hasPrefix(_ prefix: String) -> ((String) -> Bool) { {$0.hasPrefix(prefix)} }
func hasSuffix(_ suffix: String) -> ((String) -> Bool) { {$0.hasSuffix(suffix)} }

var str = "Jack"
switch str {
case hasPrefix("j"), hasSuffix("k"):
    print("以j开头，以k结尾")
default:
    break
}


// 自定义表达式
 
func isEven(_ i: Int) -> Bool { i % 2 == 0 }
func isOdd(_ i: Int) -> Bool { i % 2 != 0 }

extension Int {
    static func ~= (pattern: (Int) -> Bool, value: Int) -> Bool {
        pattern(value)
    }
}

switch age {
case isEven:
    print("偶数")
case isOdd:
    print("奇数")
default:
    print("其他")
}

prefix operator ~>
prefix operator ~>=
prefix operator ~<
prefix operator ~<=

prefix func ~> (_ i: Int) -> ( (Int) -> Bool ) { { $0 > i } }

prefix func ~>= (_ i: Int) -> ( (Int) -> Bool ) { { $0 >= i } }

prefix func ~< (_ i: Int) -> ( (Int) -> Bool ) { { $0 < i } }

prefix func ~<= (_ i: Int) -> ( (Int) -> Bool ) { { $0 <= i } }

switch age {
case ~>=0:
    print("大于等于0")
case ~<=10:
    print("小于等于10")
default:
    break
}

//可以使用where为模式匹配增加匹配条件
var data = (10, "Jack")
switch data {
case let (age,_) where age > 10:
    print(data.1,"age > 10")
case let (age, _) where age > 0:
    print(data.1,"age > 0")
default:
    break
}


protocol Stackable { associatedtype Element }
protocol Container {
    associatedtype Stack: Stackable where Stack.Element : Equatable
}

func equal<S1: Stackable, S2: Stackable>(_ s1:S1, _ s2: S2) -> Bool where S1.Element == S2.Element,S1.Element : Hashable {
    return true
}

extension Container where Self.Stack.Element : Hashable { }













//: [Next](@next)
