//: [Previous](@previous)

import Foundation


/*
    枚举、结构体、类都可以定义实例方法、类型方法
    实例方法：通过实例对象调用
    类型方法：通过类型调用，用static或者class关键字定义
    self在实例方法中代表实例对象，在类型方法中代表类型
 */

class Car {
    static var count = 0
    init() {
        Car.count += 1
    }
    static func getCount() -> Int { return count }
}
// 在类型方法getCount中，count等价于self.count、Car.count、Car.self.count

let c0 = Car()
let c1 = Car()
print(Car.getCount())


/*
    结构体和枚举是值类型，默认情况下，值类型的属性不能被自身的实例方法修改
    在func关键字前加mutating可以允许修改
    在func前加
 */

struct Point {
    var x = 0.0,y = 0.0
    mutating func moveBy(deltaX: Double, deltaY: Double) {
        x += deltaX
        y += deltaY
    }
}



enum StateSwitch {
    case low,middle,high
    mutating func next() {
        switch self {
        case .low:
            self = .middle
        case .middle:
            self = .high
        case .high:
            self = .low
        }
    }
}

struct Location {
    var x = 0.0,y = 0.0
    @discardableResult mutating
    func moveX(deltaX: Double) -> Double {
        x += deltaX
        return x
    }
}

var loc = Location()
loc.moveX(deltaX: 11)


//: [Next](@next)
