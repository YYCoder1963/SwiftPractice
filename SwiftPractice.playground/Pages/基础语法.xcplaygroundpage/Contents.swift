
import UIKit
import PlaygroundSupport

//: [prev](@previous)

// command+shift+enter 运行整个playground
// shift+enter 运行到某一行

//let定义常量，var定义变量，编译器能自动推断出变量\常量的类型
var str = "Hello, playground"
str = "hello,world"

let a = 10

//常量

//let view = UIView()
//view.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
//view.backgroundColor = UIColor.red
//PlaygroundPage.current.liveView = view

let vc = UITableViewController()
vc.view.backgroundColor = UIColor.red
PlaygroundPage.current.liveView = vc

/*
let age: Int
var height : Int
print(age,height)
 常量、变量在初始化之前不能使用
 Constant 'age' used before being initialized
 Variable 'height' used before being initialized
*/

/*
 Found an unexpected second identifier in constant declaration; is there an accidental break?
let age
age = 10
*/

let age: Int
age = 10


//标识符不能以数字开头、不能包含空白字符、制表符、箭头灯特殊字符外，几乎都可以使用;如下

let 😯 = "O"

func 🐂() {
    print("666")
}
🐂()


//:常见数据类型
/*
常见数据类型：值类型和引用类型

值类型包含：枚举、结构体类型
枚举：Optional
结构体：Bool、Int、Float、Double、Character、String、Array、Dictionary、Set
 
引用类型：类（class）
*/


//:字面量
let bool = true
let string = "啦啦"
let character:Character = "c"

let intDecimal = 12         //十进制
let intBinary = 0b1001      //二进制
let intOctal = 0o21          //八进制
let intHexadecimal = 0x11   //十六进制

let doubleDecimal = 120_000.0   //十进制
let doubleHexadecimal = 0x11    //十六进制

let array = [1,2,4]
let dictionary = ["age":20,"height":181,"weight":150];


//:类型转换

let int1:UInt16 = 1_000
let int2:UInt8 = 2
/*
 //Binary operator '+' cannot be applied to operands of type 'UInt16' and 'UInt8'
 let int3 = int1 + int2

 */
let int3 = int1 + UInt16(int2)

let int = 3
let double = 0.141_59
let pi = Double(int) + double
let intPi = Int(pi)

//因为数字字面量本身没有明确类型，可以直接相加
let result = 3 + 0.1415


//:元组
let http404Error = (404,"not found")
print("The status code is \(http404Error.0)")

let (statusCode,statusMessage) = http404Error
print("The status code is \(statusCode)")














