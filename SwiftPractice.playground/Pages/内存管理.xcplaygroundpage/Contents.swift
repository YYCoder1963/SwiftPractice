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
var step = 1
func increment(_ num: inout Int) {
    num += step
}
increment(&step)

//解决内存访问冲突
var copyOfStep = step
increment(&copyOfStep)
step = copyOfStep


func balance(_ x: inout Int, _ y: inout Int) {
    let sum = x + y
    x = sum / 2
    y = sum - x
}

















//: [Next](@next)







