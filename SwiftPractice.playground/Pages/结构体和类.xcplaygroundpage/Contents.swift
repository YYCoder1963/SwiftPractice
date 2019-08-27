//: [Previous](@previous)

import Foundation


/*
    Swift标准库中，大多数公开类型都是结构体，枚举和类只占很小一部分
    常见的Bool、Int、Double、string、Array、Dictionary等都是结构体
*/

struct Date {
    var year: Int
    var month: Int
    var day: Int
}

/*
    所有结构体都有一个编译器自动生成的初始化器
    可以传入所有成员值，用以初始化所有成员
    编译器根据情况，可能会为结构体生成多个初始化器，宗旨是保证所有成员变量都有初始值
*/
var date = Date(year: 2019, month: 8, day: 28)
print(MemoryLayout<Date>.size)      //24
print(MemoryLayout<Date>.stride)    //24
print(MemoryLayout<Date>.alignment) //8
/*
    结构体date内存内容如下：
    0x00000000000007e3 0x0000000000000008 0x000000000000001c
 */


struct Point {
    var x: Int
    var y: Int
}

var p1 = Point(x: 1, y: 1)
//Missing argument for parameter 'y' in call
//var p2 = Point(x: 1)

struct Point1 {
    var x: Int = 1
    var y: Int
}
//目前xcode版本还不是11，不支持次特性
//var p2 = Point1(y: 1)

struct Point2 {
    var x: Int?
    var y: Int?
}
//因为可选项都有个默认值nil，所以下面都可以编译通过
//var p4 = Point2(x: 1)
//var p4 = Point2(y: 1)
var p3 = Point2()


/*
    自定义初始化器
    一旦定义结构体时自定义了初始化器，编译器就不会再自动生成其他初始化器
 */
struct Point3 {
    var x: Int
    var y: Int
    init(x: Int,y: Int) {
        self.x = x
        self.y = y
    }
}
var p5 = Point3(x: 1, y: 1)



//类的定义和结构体类似，但编译器没有为类自动生成可以传入成员值的初始化器
class Location {
    var x: Int = 0
    var y: Int = 0
}

let loc = Location()
print(MemoryLayout<Date>.size)      //24
print(MemoryLayout<Date>.stride)    //24
print(MemoryLayout<Date>.alignment) //8































//: [Next](@next)
