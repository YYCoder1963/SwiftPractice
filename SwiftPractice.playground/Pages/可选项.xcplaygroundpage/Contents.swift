//: [Previous](@previous)

import Foundation

/*
    可选项：也叫可选类型，允许将值设置为nil，在类型后加？定义可选项
    可选项是对其他类型的包装，可以理解为一个盒子。如果值为nil，那么它是个空盒子；如果值不为nil，那么盒子里装的是被包装类型的数据
*/
var name: String? = "Lyy"
name = nil

var age: Int? //没有初始值，默认为nil
age = 10
age = nil

var array = [1,2,3,5]
func get(_ index: Int) -> Int? {
    if index < 0 || index >= array.count {
        return nil
    }
    return array[index]
}

//print(get(1))
//print(get(11))


/*
    强制解包：要从可选项中取出被包装的数据（将盒子里的数据取出），使用感叹号！强制解包
    注意：对值为nil的可选项强制解包，会产生运行时错误
 */
//let ageInt = age!
//var age1:Int?
//let age2 = age1!

//判断可选项是否包含值
let number = Int("1")
if number != nil {
    print("字符串转换整数成功：\(number!)")
}else {
    print("字符串转换整数失败")
}


/*
    可选绑定：使用可选绑定来判断可选项是否包含值
    如果包含值就自动解包，把值赋给你哥临时常量(let)或变量(var)并返回true，否则返回false
 */

if let number = Int("2") {
    print("字符串转换整数:\(number)")
}else {
    print("字符串转换整数失败")
}

enum Season: Int {
    case spring = 1, summer,autumn,winter
}

if let season = Season(rawValue: 2) {
    switch season {
    case .spring:
        print("this is spring")
    case .summer:
        print("this is summer")
    case .autumn:
        print("this is autumn")
    case .winter:
        print("this is winter")
    }
}else {
    print("no such season")
}



//等价写法:多个可选绑定嵌套和用逗号分隔等价
if let first = Int("4") {
    if let second = Int("42") {
        if first < second && second < 100 {
            print("\(first) < \(second) < 100")
        }
    }
}

if let first = Int("4"),
    let second = Int("42"),
    first < second && second < 100 {
    print("\(first) < \(second) < 100")
}


//while循环中使用可选绑定
var strs = ["10","20","20","30","a"]
var index = 0
var sum = 0
while let num = Int(strs[index]),num > 0 {
    sum += num
    index += 1
}
print(sum)


/*
    空合并运算符 ??
    a ?? b:
    a必须是可选项，b是可选项或者不是可选项；
    a和b的存储类型必须相同；
    如果a不为nil，就返回a，如果a为nil就返回b
    如果b不是可选项，返回a时会自动解包
 */

let a: Int? = 1
let b: Int = 2
let c = a ?? b //c = 1

let d: Int? = 3
let e = a ?? d //e = Optional(1)

let f: Int? = nil
let g: Int? = nil
let h: Int? = 4

let i = f ?? g
let j = f ?? h


//多个 ?? q一起使用
let k = a ?? d ?? 3 //k 是Int? 1
let l = f ?? g ?? 3 //l 是int 3


// ?? 与 if let配合使用
if let number = a ?? d {
    print(number)
}

if let m = a,let n = d {//类似于if m != nil && b != nil
    print(m,n)
}

func login(_ info: [String : String]) {
    let username : String
    if let tmp = info["username"] {
        username = tmp
    }else {
        print("请输入用户名")
        return
    }
    
    let password : String
    if let tmp = info["password"] {
        password = tmp
    }else{
        print("请输入密码")
        return
    }
    
    print("用户名:\(username),密码：\(password)")
}

login(["username":"lyy","password":"1234"])


/*
    guard
    当guard语句的条件为false时，会执行大括号里面的代码
    当guard语句条件为true时，会跳过guard语句
    guard语句适合用来不符合条件提前退出
 */

func login1(_ info: [String : String]) {
    guard let username = info["username"] else {
        print("请输入用户名")
        return
    }
    guard let password = info["password"] else {
        print("请输入密码")
        return
    }
    
    print("用户名:\(username),密码：\(password)")
}

login(["username":"lyy"])


/*
    隐式解包
    某些情况下，可选项一旦被设定值后会一直拥有值；
    这时，可以去掉检查，也不必每次访问都进行解包；
    可以在类型后面加 ！定义一个隐式解包的可选项；
    用 ! 修饰的变量或常量不能为nil
 */

let num1: Int! = 10
if num1 != nil {
    print(num1 + 6)
}

//let num2: Int! = nil
//let num3:Int = num2

/*
    可选项在字符串插值或直接打印时，编译器会发出警告
    有三种解决办法
*/

var age1: Int? = 10
print("my age is \(age1)")

//解决办法
print("my age is \(age1!)")
print("my age is \(String(describing: age))")
print("my age is \(age1 ?? 0)")


//多重可选项

var num2: Int? = 10
var num3: Int?? = num1
var num4: Int?? = 10

print(num2 == num3) // true










//: [Next](@next)
