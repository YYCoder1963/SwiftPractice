//: [Previous](@previous)

import Foundation

/*
    Swift也是采用基于引用计数器的ARC内存管理方案（堆空间）
    Swift的ARC有3种引用：
    - 强引用：默认情况下，都是强引用
    - 弱引用：通过weak定义弱引用
            必须是可选类型的var，因为实例销毁后，ARC会自动将弱引用设置为nil
            ARC自动给弱引用设置nil时，不会触发属性观察器
    - 无主引用(unowned reference)：通过unowned定义无主引用
            不会产生强引用，实例销毁后仍然存储着实例的内存地址（类似OC中的unsafe_unretained）
            试图在实例销毁后访问无主引用，会产生运行时的错误（野指针）
            (Attempt to read an unowned reference bug object ox0 was already deallocated)
    weak和unowned只能用于类的实例
 */


/*
    public func autoreleasepool<Result>(invoking body: () throws -> Result) rethrows -> Result
 */
autoreleasepool {
    
}

/*
    循环引用
    weak、unowned 都能解决循环引用的问题，unowned比weak少一些性能消耗
    - 生命周期中可能会变为nil的使用weak
    - 初始化赋值后再也不会变为nil的使用unowned
 */


/*
    闭包的循环引用
    闭包表达式默认会对用到的外层对象产生额外的强引用（对外层对象进行了retain操作）
 */
class Person {
    var fn: (() -> ())?
    func run() { print("person run") }
    deinit { print("Person deinit") }
}

func test() {
    let p = Person()
    p.fn = { p.run() }
    p.fn?()
}

func test1() {
    let p = Person()
    p.fn = {
        [weak p] in
        p?.run()
    }
}

func test2() {
    let p = Person()
    p.fn = {
        [weak wp = p,unowned up = p, a = 10+10] in
        wp?.run()
    }
}

test2()


//如果想在定义闭包属性的同时引用self，这个闭包必须是lazy的（因为在实例初始化完毕之后才能引用self）
class Child {
    lazy var fn: (() -> ()) = {
        [weak self] in
        self?.run()
    }
    func run() {
        print("run")
    }
    deinit {
        print("Child deinit")
    }
}

//如果lazy属性是闭包调用的结果，那么不用考虑循环引用的问题（因为闭包调用后，闭包的生命周期也就结束了）
class Player {
    var age: Int = 0
    lazy var getAge: Int = {
        self.age
    }()
    deinit {
        print("deinit")
    }
}


/*
    @escaping
    非逃逸闭包、逃逸闭包，一般都是当做参数传递给函数
    非逃逸闭包：闭包调用发生在函数结束前，闭包调用在函数作用域内
    逃逸闭包：闭包有可能在函数结束后调用，闭包调用逃离了函数的作用域，需要通过@escaping声明
 */

typealias Fn = () -> ()

//fn是非逃逸闭包
func test1(_ fn: Fn) { fn() }

//fn是逃逸闭包
var gFn: Fn?
func test2(_ fn: @escaping Fn) {
    gFn = fn
}

func test3(_ fn: @escaping Fn) {
    DispatchQueue.global().async {
        fn()
    }
}

class Coder {
    var fn: Fn
    init(fn: @escaping Fn) {
        self.fn = fn
    }
    func run() {
        /*
            DispatchQueue.global().async也是一个逃逸闭包
            public func async(group: DispatchGroup? = nil, qos: DispatchQoS = .unspecified, flags: DispatchWorkItemFlags = [], execute work: @escaping @convention(block) () -> Void)
         */
        DispatchQueue.global().async {
            self.fn() //用到了实例成员（属性、方法），编译器会强制要求明确些出self
        }
    }
}

//逃逸闭包不可以捕获inout参数
func other1(_ fn: Fn) { fn() }
func other2(_ fn: @escaping Fn) { fn() }
func test(value: inout Int) -> Fn {
    other1 {
        value += 1
    }
    //Escaping closures can only capture inout parameters explicitly by value
    //other2 { value += 1 }
    
    //func plus() { value += 1 }
    //Nested function cannot capture inout parameter and escape
    
    func plus() { }
    return plus
}




/*  内存访问冲突
    当两个访问满足下列条件时会产生访问冲突
    - 至少一个是写入操作
    - 他们访问的是同一块内存
    - 他们的访问时间重叠（比如在同一个函数内）
 */

//没有访问冲突
func plus(_ num: inout Int) -> Int { return num + 1}
var number = 1
number = plus(&number)

//有访问冲突
/*
 Simultaneous accesses to 0x11976efd8, but modification requires exclusive access.

 var step = 1
 func increment(_ num: inout Int) {
 num += step
 }
 increment(&step)
 
 //解决内存访问冲突
 var copyOfStep = step
 increment(&copyOfStep)
 step = copyOfStep
 
 */





func balance(_ x: inout Int, _ y: inout Int) {
    let sum = x + y
    x = sum / 2
    y = sum - x
}

var num1 = 42, num2 = 10
balance(&num1, &num2)
//Inout arguments are not allowed to alias each other
//balance(&num2, &num2)


var tulpe = (health: 10, energy: 20)

//balance(&tulpe.health, &tulpe.energy)

struct Farmer {
    var name: String
    var health: Int
    var energy: Int
    mutating func shareHealth(with teammate: inout Farmer) {
        
        balance(&teammate.health, &health)
    }
}

var oscar = Farmer(name: "Oscar", health: 10, energy: 10)
var maria = Farmer(name: "Maria", health: 3, energy: 3)
oscar.shareHealth(with: &maria)

//Inout arguments are not allowed to alias each other
//oscar.shareHealth(with: &oscar)


/*
    如果下面条件满足，则重叠访问结构体的属性是安全的
    - 只访问实例存储属性，不是计算属性或类属性
    - 结构体是局部变量而非全局变量
    - 结构体要么没有被闭包捕获，要么只被非逃逸闭包捕获
 */

func demo() {
    var tuple = (health: 10, energy: 20)
    balance(&tuple.health, &tuple.energy)
    
    var holly = Farmer(name: "Holly", health: 1, energy: 1)
    balance(&holly.health, &holly.energy)
}

demo()


/*  指针
    Swift中有专门的指针类型，这些都被定性为”Unsafe“（不安全的），常见一下4种类型
    - UnsafePointer<Pointee> 类似于 const Pointee *
    - UnsafeMutablePointer<Pointee> 类似于Pointee *
    - UnsafeRawPointer 类似于 const void *
    - UnsafeMutableRawPointer 类似于 void *
 */

var age = 10
func test11(_ ptr: UnsafeMutablePointer<Int>) {
    ptr.pointee += 10
}

func test12(_ ptr: UnsafePointer<Int>) {
    print(ptr.pointee)
}

//test11(&age)
//test12(&age)
//print(age)

func test13(_ ptr: UnsafeMutableRawPointer) {
    ptr.storeBytes(of: 20, as: Int.self)
}

func test14(_ ptr: UnsafeRawPointer) {
    print(ptr.load(as: Int.self))
}

test13(&age)
//test14(&age)
//print(age)


//var arr = NSArray(objects: 1,2,3,4,5)
//arr.enumerateObjects { (obj, idx, stop) in
//    print(idx,obj)
//    if idx == 2 { stop.pointee = true }
//}
//
//print("------------------")
//
//for (idx,obj) in arr.enumerated() {
//    print(idx,obj)
//    if idx == 2 { break }
//}

// 获得指向某个变量的指针

var ptr1 = withUnsafeMutablePointer(to: &age) { $0 }
var ptr2 = withUnsafePointer(to: &age) { $0 }

ptr1.pointee = 22
//print(ptr2.pointee)
//print(age)

var ptr3 = withUnsafeMutablePointer(to: &age) { UnsafeMutableRawPointer($0) }
var ptr4 = withUnsafePointer(to: &age) { UnsafeRawPointer($0) }

ptr3.storeBytes(of: 33, as: Int.self)
print(ptr4.load(as: Int.self))
//print(age)


//获得指向堆空间实例的指针
class Dog {}
var dog = Dog()
var ptr5 = withUnsafePointer(to: &dog) { UnsafeRawPointer($0) }
//var heapPtr = UnsafeRawPointer(bitPattern: ptr5.load(as: Unit.self))


//创建指针
var p1 = UnsafeRawPointer(bitPattern: 0x100001234)

var p2 = malloc(16)
p2?.storeBytes(of: 11, as: Int.self)
p2?.storeBytes(of: 22, toByteOffset: 8, as: Int.self)
//print((p2?.load(as: Int.self))!)// 11
//print((p2?.load(fromByteOffset: 8, as: Int.self))!)// 22
free(p2)

var p3 = UnsafeMutableRawPointer.allocate(byteCount: 16, alignment: 1)
p3.storeBytes(of: 11, as: Int.self)
p3.advanced(by: 8).storeBytes(of: 22, as: Int.self)
//print(p3.load(as: Int.self)) // 11
//print(p3.advanced(by: 8).load(as: Int.self)) // 22
p3.deallocate()



var p4 = UnsafeMutablePointer<Int>.allocate(capacity: 3)
p4.initialize(to: 11)
p4.successor().initialize(to: 22)
p4.successor().successor().initialize(to: 33)

//print(p4.pointee) // 11
//print((p4 + 1).pointee) // 22
//print((p4 + 2).pointee) // 33
//
//print(p4[0])// 11
//print(p4[1])// 22
//print(p4[2])// 33

p4.deinitialize(count: 3)
p4.deallocate()


class Children {
    var age: Int
    var name: String
    init(age: Int, name: String) {
        self.age = age
        self.name = name
    }
    deinit {
        print(name,"deinit")
    }
}


var p5 = UnsafeMutablePointer<Children>.allocate(capacity: 5)
p5.initialize(to: Children(age: 10, name: "Lee"))
(p5 + 1).initialize(to: Children(age: 11, name: "Rose"))
(p5 + 2).initialize(to: Children.init(age: 12, name: "Lily"))
//
p5.deinitialize(count: 3)
p5.deallocate()



//指针之间的转换
var p6 = UnsafeMutableRawPointer.allocate(byteCount: 16, alignment: 1)
/*
    assumingMemoryBound<T>(to: T.Type)
    返回一个T类型的指针指向与原始指针相同的类型
 */
p6.assumingMemoryBound(to: Int.self).pointee = 11
(p6 + 8).assumingMemoryBound(to: Double.self).pointee = 22.0
/*
    unsafeBitCast<T, U>(_ x: T, to type: U.Type) -> U
    将T类型强制转换为U类型并返回U（要求T和U实例有相同的内存大小和布局）
    但不会因为数据类型的变化而改变原来的内存数据
 */
print(unsafeBitCast(p6, to: UnsafePointer<Int>.self).pointee)
print(unsafeBitCast(p6 + 8, to: UnsafePointer<Double>.self).pointee)

p6.deallocate()






//: [Next](@next)







