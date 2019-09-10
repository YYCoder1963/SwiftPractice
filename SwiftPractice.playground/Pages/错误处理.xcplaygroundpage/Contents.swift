//: [Previous](@previous)

import Foundation

/*
    常见错误类型
    语法错误（编译报错）、逻辑错误、运行时错误（可能导致闪退）
 */

/*
    自定义错误
    Swift可以通过Error协议自定义运行时错误信息
    函数内部可以通过throw抛出自定义Error，可能会抛出Error的函数必须加上throws声明
    需要使用try调用可能会抛出Error的函数
 */

enum SomeError : Error {
    case illegalArg(String)
    case outOfBounds(Int, Int)
    case outOfMemory
}

func divide(_ num1: Int, _ num2: Int) throws -> Int {
    if num2 == 0 {
        throw SomeError.illegalArg("0 不能作为除数")
    }
    return num1 / num2
}

//var result = try divide(10, 0)

/*
    可以使用do-catch捕捉Error
    抛出Error后，try下一句直到作用域结束的代码都将停止运行
 */
func test() {
    print(1)
    do {
        print(2)
        try divide(20, 0)
        print(3)
    } catch let SomeError.illegalArg(msg) {
        print("参数异常：",msg)
    }catch let SomeError.outOfBounds(size, index) {
        print("下标越界：","size=\(size)","index=\(index)")
    }catch SomeError.outOfMemory {
        print("内存溢出")
    }catch {
        print("其他错误")
    }
    print(4)
}

//test()

//do {
//    try divide(2, 0)
//} catch let error {
//    switch error {
//    case let SomeError.illegalArg(msg):
//        print("参数异常：",msg)
//    default:
//        print("其他错误")
//    }
//}



/*
    可以使用try？、try！调用可能会抛出Error的函数，这样就不用去处理Error
*/

//func test1() {
//    print(1)
//    var result1 = try? divide(2, 2) // Int?
//    var result2 = try? divide(1, 0) // nil
//    var result3 = try! divide(2, 1) // Int
//    print(2)
//}
//test1()
//
//var a = try? divide(2, 0)
//var b: Int?
//do {
//    b = try divide(2, 0)
//} catch {
//    b = nil
//}

// rethrows:函数本身不会抛出异常，会调用闭包参数抛出错误，将错误向上抛
func exec(_ fn: (Int, Int) throws -> Int, _ num1: Int, _ num2: Int) rethrows {
    print(try fn(num1,num2))
}
//try exec(divide, 2, 0)


/*
    defer:定义任何方式（异常、return等）离开代码块前必须要执行的代码
    defer语句将延迟至当前作用域结束之前执行
 */

func open(_ fileName: String) -> Int {
    print("open")
    return 1
}

func close(_ file: Int) {
    print("close")
}

func processFile(_ fileName: String) throws {
    let file = open(fileName)
    defer{
        close(file)
    }
    // 使用file
    //......
    try divide(2, 0)
    // close将会在这里调用
}

//try processFile("test.txt")



/*
    很多变成语言都有断言机制：不符合指定条件就抛出运行时错误，常用于调试阶段的条件判断
    默认情况下，Swift的断言只会在debug模式下生效，release模式下忽略
    增加Swift Flags修改断言的默认行为
    -assert-config Release：强制关闭断言
    -assert-config Debug：强制开启断言
 */

func divide1(_ v1: Int, _ v2: Int) -> Int {
    assert(v2 != 0, "除数不能为0")
    return v1 / v2
}

//print(divide1(2, 0))


/*
    如果遇到严重问题，希望结束程序运行时，可以直接使用fatalError函数抛出异常（这是do-catchw无法捕捉的错误）
    使用了fatalError函数，就不需要再写return
    在某些不得不实现，但不希望别人调用的方法，可以考虑内部使用fatalError函数
 */

class Person {
    var age = 0
    required init() {}
}
class Student : Person {
    required init() {
        fatalError("don't call Student.init")
    }
    init(score: Int) { }
}

var stu1 = Student(score: 98)
//var stu2 = Student()


//可以使用do实现局部作用域

do {
    let person = Person()
    person.age = 0
}


//: [Next](@next)
