//: [Previous](@previous)

import Foundation

/*
    协议
    协议可以用来定义方法、属性、下标的声明，协议可以被枚举、结构体、类遵守
    协议中定义方法时不能有默认参数值
    默认情况下，协议中定义的内容必须全部实现（也有办法只实现部分）
 */


protocol Drawable {
    func draw()
    var x: Int { get set }
    var y: Int { get }
    subscript(index: Int) -> Int { get set }
}

protocol Test1 {}
protocol Test2 {}
class TestClass : Test1, Test2 {}


/*
    协议中的属性
    协议中定义属性时必须用var关键字
    实现协议时的属性权限要不小于协议中定义的属性权限
    协议定义get、set，用var存储属性或get、set计算属性去实现
    协议定义get，用任何属性都可以实现
 */

class Person : Drawable {
//    var x: Int = 0
    var x: Int {
        get { return 0 }
        set {}
    }
    var y: Int = 0
    func draw() {
        print("Person draw")
    }
    subscript(index: Int) -> Int {
        set {}
        get { return index }
    }
}

//为了保证通用，协议中必须使用static定义类型方法、类型属性、类型下标
protocol Drawable1 {
    static func draw()
}

class Person1 : Drawable1 {
    class func draw() {
        print("Person1 draw")
    }
}

class Person2 : Drawable1 {
    static func draw() {
        print("Person2 draw")
    }
}


/*
    mutating
    只有将协议中的实例方法标记为mutating
      才允许结构体、枚举的具体实例修改自身内存
      类在实现方法时不用加mutating，枚举、结构体才需要
 */

protocol Drawable2 {
    mutating func draw()
}

class size : Drawable2 {
    var width: Int = 0
    func draw() {
        width = 10
    }
}

struct point : Drawable2 {
    var x: Int = 0
    mutating func draw() {
        x = 10
    }
}


/*
    协议中还可以定义初始化器init
    非final类实现时必须加上required
 
    如果从协议实现的初始化器，刚好是重写了父类的指定初始化器
    那么这个初始化器必须同时加上required、override
 */

protocol Drawable3 {
    init(x: Int, y: Int)
}

class Point1 : Drawable3 {
    required init(x: Int, y: Int) {}
}

final class Size : Drawable3 {
    init(x: Int, y: Int) { }
}


protocol Livable {
    init(age: Int)
}

class Person3 {
    init(age: Int) { }
}

class Student : Person3, Livable {
    func study()  { }
    required override init(age: Int) {
        super.init(age: age)
    }
}


/*
    协议中定义的init？、init！，可以用init、init？、init！去实现
    协议中定义的init，可以用init、init！去实现
*/

protocol Livable1 {
    init()
    init?(age: Int)
    init!(no: Int)
}

class Person4 : Livable1 {
//    required init () {}
    required init! () {}
    
//    required init?(age: Int) {}
//    required init(age: Int){}
    required init!(age: Int) {}
    
//    required init!(no: Int) {}
//    required init(no: Int) {}
    required init?(no: Int) {}
}


/*
    协议的继承：一个协议可以继承其他协议
 */

protocol Runnable : Livable {
    func run()
}

/*
    协议组合：最多包含一个类类型
 
    //接收Person及其子类的实例
    func fn0(obj:Person) {}
 
    //接收遵守Livable协议的实例
    func fn1(obj:Livable) {}
 
    //接收同时遵守Livable、Runnable协议的实例
    func fn2(obj: Livable & Runnable) {}
 
    //接收同时遵守Livable、Runnable协议并且是Person或其子类的实例
    func fn3(obj: Livable & Runnable & Person) {}
 
    typealias RealPerson = Livable & Runnable & Person
    func fn4(obj: RealPerson) {}
 */



/*
 
 */

enum Season: CaseIterable {
    case spring, summer, autumn, winter
}

let seasons = Season.allCases
print(seasons.count)
for season in seasons {
    print(season)
}


/*
    Cust
 */

class Player : CustomStringConvertible,CustomDebugStringConvertible {
    var age = 0
    var description: String { return "Player age is \(age)"}
    var debugDescription: String { return "debug player age is \(age)" }
}

var player = Player()
print(player)
debugPrint(player)

/*
    Swift提供了2种特殊的类型：Any，AnyObject
    Any：代表任意类型（枚举、结构体、类，也包括函数）
    AnyObject：代表任意类类型（协议后面AnyObject代表只有类能遵守这个协议）
    在协议后面写：class也代表只有类能遵守这个协议
 */

var stu: Any = 1
stu = "Lee"
stu = Student(age: 1)


/*
    is、as？、as！、as
    is用来判断是否为某种类型，as用来做强制类型转换
 */
print(stu is String)
(stu as? Student)?.study()//如果stu不是Student的实例，不会调用study
(stu as! Student).study()//如果stu不是Student的实例，会报错，nil不能调用方法
(stu as? Runnable)?.run()//如果stu不是遵守Runnable的实例，不会调用run

/*
    X.self、X.Type、AnyClass
    X.self是一个元类型(metadata)的指针，metadata存放着类型的相关信息
    X.self属于X.Type类型
*/

var perType: Person3.Type = Person3.self
var stuType: Student.Type = Student.self
perType = Student.self

var anyType: AnyObject.Type = Person.self
anyType = Student.self

public typealias AnyClass = AnyObject.Type
var anyType1: AnyClass = Person3.self
anyType1 = Student.self

var per = Person()
var perType1 = type(of: per)
print(Person.self == type(of: per)) //true


//元类型的应用

class Animal {
    required init() {}
}

class Cat : Animal {}
class Dog : Animal {}
class Pig : Animal {}

func create(_ classes: [Animal.Type]) -> [Animal] {
    var arr = [Animal]()
    for cls in classes {
        arr.append(cls.init())
    }
    return arr
}

print(create([Cat.self,Dog.self,Pig.self]))



print(class_getInstanceSize(Student.self))
print(class_getSuperclass(Student.self)!)

class BaseClass {}

print(class_getSuperclass(BaseClass.self)!)//Swift._SwiftObject,其实默认有个隐藏基类SwiftObject



/*
    Self:代表当前类型
    Self一般用做返回值类型，限定返回值跟方法调用者必须是同一类型（也可以作为参数类型）
 */

//class BaseClass1 {
//    var age = 1
//    static var count = 10
//    func fun() {
//        print(self.age)
//        print(Self.count)
//    }
//}


protocol Runnable2 {
    func test() -> Self
}

class Person5 : Runnable2 {
    required init() {}
    func test() -> Self {
       return type(of: self).init()
    }
}




//: [Next](@next)
