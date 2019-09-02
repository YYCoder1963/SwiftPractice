//: [Previous](@previous)

import Foundation



//Swift中，除了func，也可以通过闭包表达式定义一个函数
func sum(_ v1: Int,_ v2: Int) -> Int {
    return v1 + v2
}

/*
 闭包表达式
 {
    (参数列表) -> 返回值类型 in
    函数体代码
 }
 //目前版本不支持下列语法
var fn = {
    (v1: Int, v2: Int) -> Int in
        return v1 + v2
}

{
    (v1: Int,v2: Int) -> Int in
    return v1 + v2
}(10,11)
 
*/

/*
    闭包表达式的简写（依次递减）
 */

func exec(v1: Int,v2: Int,fn:(Int,Int) -> Int) {
    print(fn(v1,v2))
}

exec(v1: 10, v2: 20, fn: {
    (v1: Int,v2: Int) -> Int in
    return v1 + v2
})

exec(v1: 10, v2: 20, fn: {
    v1,v2 in return v1 + v2
})

exec(v1: 10, v2: 20, fn: {
    v1,v2 in v1 + v2
})

exec(v1: 10, v2: 20, fn: { $0 + $1})

exec(v1: 10, v2: 20, fn: +)

/*
    尾随闭包
    尾随闭包是一个被书写在函数调用括号外面的闭包表达式
    如果将一个很长的闭包表达式作为函数的最后一个实参，使用尾随闭包可以增强函数可读性
    如：
    func exec(v1: Int,v2: Int,fn:(Int,Int) -> Int) {
        print(fn(v1,v2))
    }
    可以写成如下
    func exec(v1: Int,v2: Int) {
        $0 + $1
    }
 */

/*
    如果闭包表达式是函数的唯一实参，而且使用了尾随闭包的语法，就不需要再函数后面写圆括号
 */

func exec(fn:(Int,Int) -> Int) {
    print(fn(1,2))
}

exec(fn: {$0 + $1})
exec(){$0 + $1}
exec{$0 + $1}



func cmp(i1: Int, i2: Int) -> Bool {
    return i1 > i2
}
var nums = [11,2,34,45,12,23]
print(nums)
nums.sort(by:cmp)
nums.sort(by: {
    (i1: Int, i2: Int) -> Bool in
    return i1 < i2
})

nums.sort(by: {i1, i2 in return i1 < i2})

nums.sort(by: {i1, i2 in i1 < i2})
nums.sort(by: {$0 < $1})
nums.sort(by: <)
nums.sort(){$0 < $1}
nums.sort{$0 < $1}

print(nums)

//忽略参数
//exec(_,_ in 10)



/*
    闭包
    一个函数和它所捕获的变量\常量环境组合起来，称为闭包
    一般指定义在函数内部的函数；一般它捕获的是外层函数的局部变量\常量
    可以把闭包想象成一个类的实例对象，内存在堆空间
    捕获的局部变量\常量就是对象的成员(存储属性)
    组成闭包的函数就是类内部定义的方法
 */

//如果声明一个全局的变量num，函数plus不会捕获num，类似block访问局部变量
// 调用getFn时捕获num
// var num = 0
typealias Fn = (Int) -> Int
func getFn() -> Fn {
    var num = 0
    func plus(_ i: Int) -> Int {
        num += i
        return num
    }
    return plus
}//返回的plus和num形成了闭包


var fn = getFn()
print(fn(1))
print(fn(2))

typealias Fn1 = (Int) -> (Int,Int)
func getFns() -> (Fn1,Fn1) {
    var num1 = 0
    var num2 = 0
    func plus(_ i:Int) -> (Int,Int){
        num1 += i
        num2 += i << 1
        return (num1,num2)
    }
    
    func minus(_ i: Int) -> (Int, Int) {
        num1 -= i
        num2 -= i << 1
        return (num1,num2)
    }
    
    return(plus,minus)
}

let (p,m) = getFns()
print(p(2))
print(m(4))

//闭包类似一个类的实例对象，num类似类的成员变量
class Closure {
    var num1 = 0
    var num2 = 0
    func plus(_ i: Int) -> (Int, Int) {
        num1 += i
        num2 += i << 1
        return (num1,num2)
    }
    func minus(_ i: Int) -> (Int, Int) {
        num1 -= i
        num2 -= i << 1
        return (num1,num2)
    }
}

var cs = Closure()
cs.plus(1)
cs.minus(2)


//如果返回值是函数类型，那么参数的修饰要保持一致
func add(_ num: Int) -> (inout Int) -> Void {
    func plus(v: inout Int) {
        v += num
    }
    return plus
}


/*
    @autoclosure 会自动将20封装成闭包 { 20 }
    @autoclosure 只支持 () -> T 格式的参数
    @autoclosure 并非只支持最后一个参数
    空合运算符 ?? 使用了 @autoclosure技术
    有@autoclosure，无@autoclosure， 构成了函数重载
 */
//func getFirstPositive(_ v1:Int,_ v2: Int) -> Int {
//    return v1 > 0 ? v1 : v2
//}
//
//getFirstPositive(10, 20)

//改成函数类型的参数，可以让v2延迟加载
func getFirstPositive(_ v1:Int, _ v2: () -> Int) -> Int? {
    return v1 > 0 ? v1 : v2()
}
getFirstPositive(-1){2}


func getFirstPositive(_ v1: Int,_ v2: @autoclosure () -> Int) -> Int? {
    return v1 > 0 ? v1 : v2()
}

getFirstPositive(-2, 11)

//: [Next](@next)
