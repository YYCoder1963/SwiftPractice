//: [Previous](@previous)

import Foundation



/*
    访问控制
    Swift提供了5个不同的访问级别（一下从高到低排列）
    open：允许在定义实体的模块、其他模块中访问，允许其他模块进行继承、重写（open只能用在类、类成员上）
    public：允许定义实体的模块、其他模块中访问，不允许其他模块进行继承、重写
    internal：只允许在定义实体的模块中访问，不允许在其他模块中访问
    fileprivate：只允许在定义实体的源文件中访问
    private：只允许在定义实体的封闭声明中访问
 */

/*
    一个实体不可以被更低访问级别的实体定义，比如
    变量\常量类型 ≥ 变量\常量
    参数类型、返回值类型 ≥ 函数
    父类 ≥ 子类
    父协议 ≥ 子协议
    原类型 ≥ typealias
    原始值类型、关联值类型 ≥ 枚举类型
    定义类型A时用到的其他类型 ≥ 类型A
    ......
 */

// 元组类型的访问级别是所有成员类型最低的那个
internal struct Dog {}
fileprivate class Person {}

fileprivate var data1: (Dog, Person)
private var data2: (Dog, Person)


/*
    泛型类型的访问级别是类型的访问级别和所有泛型类型参数的访问级别中最低的那个
 */

internal class Car {}
fileprivate class Dog1 {}
public class Person1 <T1,T2> {}

//Person1<Car, Dog1> 的访问级别是 fileprivate
fileprivate var p = Person1<Car, Dog1>()


/*
    类型的访问级别会影响成员（属性、方法、初始化器、下标）、嵌套类型的默认访问级别
     一般情况下，类型为private或fileprivate，那么成员\嵌套类型默认也是private或fileprivate
     一般请下，类型为internal或public，那么成员\嵌套类型默认也是internal
 */

public class PublicClass {
    public var p1 = 0 //public
    var p2 = 0  // internal
    fileprivate func f1() {} //fileprivate
    private func f2() {} //private
}

class InernalClass { // 默认 internal类型
    var p = 0 // internal
    fileprivate func f1() {} //fileprivate
    private func f2() {} // private
}

fileprivate class FilePrivateClass { // fileprivate
    func f1() { } // fileprivate
    private func f2() {} // private
}

private class PrivateClass { // private
    func f() {} // private
}


/*
    成员的重写
    子类重写成员的访问级别必须 ≥ 子类的访问级别，或 ≥ 父类被重写成员的访问级别
    父类的成员不能被成员作用域外定义的子类重写
 */


public class Person2 {
    private var age: Int = 0
}

//public class Student : Person2 {
//    override var age: Int { //Property does not override any property from its superclass
//        set {}
//        get { return 10 }
//    }
//}

public class Person3 {
    private var age: Int = 0
    public class Student : Person3 { // Student在age作用范围内
        override var age: Int {
            set {}
            get { return 1 }
        }
    }
}

// 直接在全局作用域下定义的private等价于fileprivate
//func test() {
//    private class Person4 {}
//    fileprivate class Student : Person4 {}
//}
//private class Person4 {}
//fileprivate class Student : Person4 {}

private struct Dog2 {
    var age: Int = 0
    func run() {}
}
fileprivate struct Person5 {
    var dog: Dog2 = Dog2()
    mutating func walk() {
        dog.run()
        dog.age = 1
    }
}

//private struct Dog3 {
//    private var age: Int = 0
//    private func run() {}
//}
//fileprivate struct Person6 {
//    var dog: Dog3 = Dog3()
//    mutating func walk() {
//        dog.run() //'run' is inaccessible due to 'private' protection level
//        dog.age = 1 //'age' is inaccessible due to 'private' protection level
//    }
//}



/*
    getter、setter默认自动接收它所属环境的访问级别
    可以给setter单独设置一个比getter更低的访问级别，用以限制写的权限
 */

fileprivate(set) public var num = 10

class Person8 {
    private(set) var age = 0
    fileprivate(set) public var weight: Int {
        set {}
        get { return 10 }
    }
    internal(set) public subscript(index: Int) -> Int {
        set {}
        get { return index }
    }
}

var p8 = Person8()
//Cannot assign to property: 'age' setter is inaccessible
//p8.age = 10
var age = p8.age



/*
    如果一个public类想在另一个模块调用编译生成的默认无参初始化器，必须显示提供public的无参初始化器，因为public类的默认初始化器是internal级别的
 
        required初始化器 ≥ 它的默认访问级别
    如果结构体有private\fileprivate的存储实例属性，那么它的成员初始化器也是private\fileprivate，否则就是默认internal
 */



/*
    不能给enum的每个case单独设置访问级别
    每个case自动接收enum的访问级别
    public enum定义的case也是public
 */


/*
    协议中定义的要求自动接收协议的访问级别，不能单独设置访问级别
    public协议定义的要求也是public
    协议实现的访问级别必须 ≥ 类型的访问级别，或者 ≥ 协议的访问级别
 */

public protocol Runnable {
    func run()
}

//public class Person9: Runnable {
//Method 'run()' must be declared public because it matches a requirement in public protocol 'Runnable'
//    func run() {}
//}




/*
    扩展
    如果有显示设置扩展的访问级别，扩展添加的成员自动接收扩展的访问级别
    如果没有显示设置扩展的访问级别，扩展添加的成员的默认访问级别，跟直接在类型中定义的成员一样
    可以单独给扩展添加的成员设置访问级别
    不能给用于遵守协议的扩展显示设置扩展的访问级别
 */

//'public' modifier cannot be used with extensions that declare protocol conformances
//Extension of internal class cannot be declared public
//public extension Person8 {
//
//}




/*
    在同一个文件中的扩展，可以写成类似多个部分的类型声明
    在原本的声明中声明一个私有成员，可以在同一文件的扩展中访问它
    在扩展中声明一个私有成员，可以在同一文件的其他扩展中、原本声明中访问它
 */



public class Student {
    private func run0() {}
    private func eat0() {
        run1()
    }
    
}

extension Student {
    private func run1() {}
    private func eat1() {
        run0()
    }
}

extension Student {
    private func eat2() {
        run1()
    }
}



//方法也可以像函数那样，赋值给一个let或var
struct Person10 {
    var age: Int
    func run(_ v: Int) {
        print("func run",age,v)
    }
    static func run (_ v: Int){
        print("static func run",v)
    }
}


let fn1 = Person10.run
fn1(1)

let fn2: (Int) -> () = Person10.run
fn2(2)

let fn3: (Person10) -> ((Int) -> ()) = Person10.run
fn3(Person10(age: 18))(19)

















//: [Next](@next)

