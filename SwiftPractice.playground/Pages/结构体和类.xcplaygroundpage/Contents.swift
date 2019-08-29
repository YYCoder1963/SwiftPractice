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
//print(MemoryLayout<Date>.size)      //24
//print(MemoryLayout<Date>.stride)    //24
//print(MemoryLayout<Date>.alignment) //8
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



/*
    类的定义和结构体类似，但编译器没有为类自动生成可以传入成员值的初始化器
    类和结构体的本质区别：类是引用类型，结构体是值类型
    结构体实例对象存放成员变量的值，类的实例对象存放的是对象的地址
    类的初始化器
    如果类的所有成员变量定义时指定了初始值，编译器会为类生成无参的初始化器
 */
//
class Location {
    var x: Int = 1
    var y: Int = 2
}

/* 下面这段代码等同于上面类的定义
class Location {
    var x: Int
    var y: Int
    init() {
        x = 1
        y = 2
    }
}
 */

let loc = Location()
//Argument passed to call that takes no arguments
//let loc = Location(x:1,y:1)

//print(MemoryLayout<Date>.size)      //24
//print(MemoryLayout<Date>.stride)    //24
//print(MemoryLayout<Date>.alignment) //8


/*
    值类型赋值给var、let或者给函数传参，是直接将所有内容拷贝一份
    类赋值类似制作一个文件的替身，指向的是同一个文件，属于浅拷贝
 
    在Swift标准库中，为了提升性能，String、Array、Dictionary、Set等采取了Copy On Write的技术：
    仅当有“写”操作时，才会真正执行拷贝（a = b，若a、b均不修改，不执行Copy操作）
 */


/*
    对象堆空间的申请过程
    Class.__allocating_init()
    libswiftCore.dylib:_swift_allocObject_
    libswiftCore.dylib:swift_slowAlloc
    libsystem_malloc.dylib::malloc
    在Mac、iOS中malloc函数分配的内存大小总是16的倍数
    通过class_getInstanceSize可以得知类对象至少需要占用多少内容
 */

//print(class_getInstanceSize(Location.self))
//print(class_getInstanceSize(type(of: loc)))

/*
    类的成员变量的修改是通过指针找到堆空间的对象内存，覆盖内存中的值
    值类型成员变量的修改是直接覆盖成员变量的值
    所以值类型对象用let修饰不能修改成员变量的值，类对象可以
*/


/*
    枚举、结构体、类都可以定义方法
    定义在枚举、结构体、类中的函数，称做放法
    方法、函数都存储在代码段，不占用对象内存
 */


class Person {
    var name : String = ""
    var sex: String = ""
    func personalInformation() -> String {
        return "name:\(name) \n sex:\(sex)"
    }
}

let p = Person()
p.name = "lyy"
p.sex = "male"
p.personalInformation()



struct Rect {
    var x = 10
    var y = 10
    func isSquare() -> Bool {
        return x == y
    }
}

var rect = Rect()
rect.y = 20
rect.isSquare()


enum Weather : String {
    case sunny = "Sunny",rainy = "Rainy",cloudy = "Cloudy"
    func stateOfWeather() -> String {
        return "\(rawValue)"
    }
}

let weather = Weather.sunny
weather.stateOfWeather()








//: [Next](@next)
