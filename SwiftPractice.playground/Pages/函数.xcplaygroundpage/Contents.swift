//: [Previous](@previous)

import Foundation

//有返回值
func pi() -> Double {
    return 3.14
}

func sum(v1:Int,v2:Int) -> Int {
    return v1 + v2;
}
sum(v1: 1, v2: 2)

//无返回值
func sayHi() -> Void {
    print("hi")
}

func sayHello() -> () {
   print("hello")
}

func sayGoodbey() {
    print("beybey")
}

//若整个函数是单一表达式，函数隐式返回这个表达式 //需升级到xcode11
//func add(v1:Int,v2:Int) -> Int {
//    v1 + v2
//}

//返回元组：实现多返回值

/// 运算（概述）
///
/// 2个数的加减平均运算（更详细的描述）
///
/// - Parameter v1:第一个整数
/// - Parameter v2:第二个整数
/// - Returns: 加减平均结果的元组
///
/// - Note:传入两个整数即可（批注）
///
//https://swift.org/documentation/api-design-guidelines/
//func calculate(v1:Int,v2:Int) -> (sum:Int,diffefence:Int,average:Int ) {
//    let sum = v1 + v2
//    let diffefence = v1 - v2
//    return (sum,diffefence, sum >> 1)
//}
//
//let result = calculate(v1: 10, v2: 11)
//print(result.sum,result.diffefence,result.average)


//修改参数标签
//func goToWork(at time: String){
//    print("this time is \(time)")
//}
//goToWork(at: "08:00")

//使用下划线_ 省略参数标签
//func sum(_ v1: Int, _ v2: Int) -> Int {
//    return v1 + v2
//}
//sum(11, 12)


// 参数默认值
//func check(name: String = "nobody",age: Int, job: String = "none") {
//    print("name = \(name), age = \(age), job =\(job)")
//}
//check(age: 15)
//check(name: "Joyce", age: 19)
//check(age: 19,job: "doctor")
//check(name: "Lee", age: 22, job: "coder")

//可变参数：相当于一个数组可以接收多个同类型的参数
//一个函数最多有1个可变参数，紧跟在可变参数后面的参数不能省略参数标签

//func add(_ numbers: Int...) -> Int {
//    var total = 0
//    for number in numbers {
//        total += number
//    }
//    return total
//}
//add(1,2,3,4)

//swift自带的print函数，是一个带有可变参数，有两个参数默认值的函数

/// - Parameters:
///   - items: Zero or more items to print.
///   - separator: A string to print between each item. The default is a single
///     space (`" "`).
///   - terminator: The string to print after all items have been printed. The
///     default is a newline (`"\n"`).
//public func print(_ items: Any..., separator: String = " ", terminator: String = "\n")


//inout可以定义输入输出参数：可以在函数内部修改外部实参的值
//可变参数不能标记为inout
//inout参数不能有默认值
//inout参数只能传入可以被多次赋值的
//inout参数的本质是地址传递
//func swapValues(_ v1: inout Int, _ v2: inout Int) {
//    let tmp = v1
//    v1 = v2
//    v2 = tmp
//}
/*
 利用元组更简洁优雅
func swapValues(_ v1: inout Int, _ v2: inout Int) {
    (v1,v2) = (v2,v1)
}
 */
//var num1 = 1,num2 = 2
//swapValues(&num1, &num2)

/*
 函数重载：函数名相同，参数个数不同||参数类型不同||参数标签不同
 */

//func sum1(v1: Int,v2: Int) -> Int {
//    return v1 + v2
//}
//////参数个数不同
//func sum1(v1: Int,v2: Int, v3:Int) -> Int {
//    return v1 + v2 + v3
//}
//////参数类型不同
//func sum1(v1: Int,v2: Double) -> Double {
//    return Double(v1) + v2
//}
//////参数标签不同
//func sum1(_ v1: Int,_ v2: Int) -> Int {
//    return v1 + v2
//}
//////参数标签不同
//func sum1(a: Int,b: Int) -> Int {
//    return a + b
//}

// 返回值类型与函数重载无关
/*
 func sum2(v1: Int,v2: Int) -> Int {
 return v1 + v2
 }
 func sum2(v1: Int,v2: Int) { }
 Ambiguous use of 'sum2(v1:v2:)'
 sum2(v1: 1, v2: 1)
 */

//默认参数值和函数重载一起使用也会产生二议性，编译器不会报错
//func sum2(v1: Int,v2: Int) -> Int {
//    return v1 + v2
//}
////参数个数不同
//func sum2(v1: Int,v2: Int, v3:Int = 10) -> Int {
//    return v1 + v2 + v3
//}
//sum2(v1: 1, v2: 1)


////可变参数、省略参数标签、函数重载一起使用产生二议性时，编译器会报错

//func sum3(v1: Int,v2: Int) -> Int {
//    return v1 + v2
//}
//
//func sum3(_ v1: Int,_ v2: Int) -> Int {
//    return v1 + v2
//}
//
//func sum3(_ numbers: Int...) -> Int {
//    var total = 0
//    for number in numbers {
//        total += number
//    }
//    return total
//}

//Ambiguous use of 'sum3'
//sum3(1,2)


//内联函数：将函数调用展开成函数体
//若开启了编译器优化（Release模式会默认开启），编译器会自动将某些函数变成内联函数

//不会被内联
//@inline(never) func test() {
//    print("test")
//}
////开启编译器h优化，必内联
//@inline(__always) func test1() {
//    print("test")
//}

//函数类型
//func play() {} // -> Void 或 () -> ()
//func sum4(a: Int,b: Int) -> Int { //(Int, Int) -> Int
//    return a + b
//}
//var fn:(Int, Int) -> Int = sum4
//fn(1,1)//调用时不需要参数标签
//
////函数类型做为函数参数
//func printResult(_ mathFn:(Int,Int) -> Int,_ a:Int,_ b:Int){
//    print("result:\(mathFn(a,b))")
//}
//printResult(sum4, 2, 2)

//函数作为函数返回值
//func next(_ input: Int) -> Int {
//    return input + 1
//}
//
//func previous(_ input: Int) -> Int {
//    return input - 1
//}

//func forward(_ forward:Bool) -> (Int) -> Int {
//    forward ? next : previous
//}
//forward(true)(3)


//别名:typealias用来给类型取别名
typealias Byte = Int8
typealias Short = Int16
typealias Long = Int64

typealias Date = (year:Int,mouth:Int,day:Int)
func testDate(_ date:Date){
    print(date.0,date.mouth,date.day)
}
let date = Date(2019,8,22)
testDate(date)

//给函数类型取别名
typealias IntFn = (Int,Int) -> Int

func difference(v1:Int,v2:Int) -> Int {
    return v1 - v2
}

let fn:IntFn = difference

func forward(_ forward:Bool) -> (Int) -> Int {
    func next(_ input:Int) -> Int {
        return input + 1
    }
    func previous(_ input:Int) -> Int {
        return input - 1
    }
    
    return forward ? next : previous
}

forward(true)(2)

//: [Next](@next)
