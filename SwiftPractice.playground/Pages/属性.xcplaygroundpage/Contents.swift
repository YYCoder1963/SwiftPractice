//: [Previous](@previous)

import UIKit
import Foundation

/*
    属性：Swift中有实例属性和类型属性
    实例属性也可以分2大类：存储属性、计算属性
 
    存储属性：类似于成员变量、存储在实例的内存中、结构体和类可以定义存储属性、枚举不可以定义存储属性
    计算属性：本质是方法（函数）、不占用实例内存、枚举、结构体、类都可以定义计算属性
 */


/*
    存储属性
    在创建类或结构体实例时，必须为所有的存储属性设置一个合适的初始值
    可以在初始化器里设初始值，也可以分配一个默认属性值
 
    计算属性
    set传入的新值默认叫做newValue，可以自定义
    只读计算属性只有get，没有set，不可以只有set没有get
    定义计算属性只能用var，let代表不可变，而计算属性的值是可能发生变化的
 */


struct Circle {
    // 存储属性
    var radius: Double = 0.0
    //计算属性
    var diameter: Double {
        set{
            radius = newValue / 2
        }
        get {
            return radius * 2
        }
    }
}

var circle = Circle(radius: 1.0)
circle.radius = 12



//枚举原始值rawValue的本质是：只读计算属性,只有get时，可以省略get{}
enum TestEnum : Int {
    case test1 = 1, test2 = 2,test3 = 3
    var rawValue: Int {
        switch self {
        case .test1:
            return 11
        case .test2:
            return 22
        case .test3:
            return 33
        }
    }
}

print(TestEnum.test3.rawValue)



/*
    延迟存储属性
    使用lazy定义延迟属性，在第一次用到属性时才会初始化
    lazy属性必须是var，不能是let
    let必须在实例的初始化方法完成之前就拥有值
    如果多条线程同时第一次访问lazy属性，不能保证属性只初始化一次
 */

class Car {
    init() {
        print("Car init")
    }
    func run() {
        print("Car is running")
    }
}

class Person {
    lazy var car = Car()
    init() {
        print("Person init")
    }
    func goOut() {
        car.run()
    }
}
/*
 Person init
 --------------------
 Car init      //用到时才初始化
 Car is running
 */
let p = Person()
print("--------------------")
p.goOut()


//class PhotoView {
//    lazy var image: Image = {
//        let url = "https://www.werjl.com/xx.png"
//        let data = Data(url:url)
//        return IMage(data:data)
//    }
//}

/*
    结构体包含延迟存储属性时，只有var才能访问延迟存储属性
    因为延迟属性初始化时需要改变结构体的内存
 */
struct Point {
    var x = 0
    var y = 0
    lazy var z = 0
}

let p1 = Point()
//Cannot use mutating getter on immutable value: 'p1' is a 'let' constant
//p1.z


/*
    可以为非lazy的var存储属性设置属性观察器
    willSet会传递新值，默认交newValue
    didSet会传递旧值，默认叫oldValue
    属性定义时和初始化器中设置属性不会触发willSet和didSet
 */
struct Square {
    var side: Double {
        willSet {
            print("willSet",newValue)
        }
        didSet {
            print("didSet",oldValue,side)
        }
    }
    
    init() {
        self.side = 1.0
        print("square init")
    }
}

var square = Square()
square.side = 10.0
//print(square.side)


//属性观察器、计算属性的功能，可以应用在全局变量和局部变量上
var num: Int {
    get {
        return 10
    }
    set {
        print("setNum",newValue)
    }
}

num = 11
//print(num)

func test() {
    var age = 1 {
        willSet {
            print("willSet",newValue)
        }
        didSet {
            print("didSet",oldValue,age)
        }
    }
    
    age = 12
}

//test()

/*
 inout的本质
 如果实参有物理内容地址，且没有设置属性观察器，直接将实参的内存地址传入函数
 如果实参是计算属性或者设置了属性观察器，则采取了Copy In Copy Out的做法
 调用该函数时，先复制实参的值，产生副本【get】
 将副本的内存地址传入函数(副本进行引用传递)，在函数内部可以修改副本的值
 函数返回后，再将副本的值覆盖实参的值【set】
 
 总结：inout的本质就是引用传递
 */

struct Shape {
    var width: Int
    var side: Int {
        willSet {
            print("willSetSide",newValue)
        }
        didSet {
            print("didSetSide",oldValue,side)
        }
    }
    var girth: Int {
        set {
            width = newValue / side
            print("setGirth",newValue)
        }
        get {
            print("getGirth")
            return width * side
        }
    }
    
    func show() {
        print("width=\(width),side\(side),girth=\(girth)")
    }
    
}

func test1(_ num: inout Int) {
    num = 20
}

var s = Shape(width: 10, side: 20)
test1(&s.width)
s.show()
print("-----------------")
test1(&s.side)
s.show()
print("-----------------")
test1(&s.girth)
s.show()
//: [Next](@next)


/*
    类型属性：只能通过类型访问
    存储类型属性：整个程序运行过程，就只有一份内存(类似全局变量)
    计算属性
    可以通过static定义类型属性，如果是类也可以用关键字class
 */

/*
    类型属性细节
    存储类型属性必须设定初始值，因为类型没有实例那样的init初始化器初始化属性值
    存储类型默认就是lazy，会在第一次使用时才初始化
    多线程同时访问，也能保证只会初始化一次（底层调用dispatch once）
    存储类型属性可以是let
    枚举类型也可以定义类型属性
 */
struct Car1 {
    static var count: Int = 0
    init() {
        Car1.count += 1
    }
}

let c1 = Car1()
let c2 = Car1()
print(Car1.count)//2


//单例模式

public class FileManager {
    public static let shared = FileManager()
    private init () {}
}

//public class FileManager {
//    public static let shared = {
//        //......
//        return FileManager()
//    }
//    private init () {}
//}
