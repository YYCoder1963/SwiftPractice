//: [Previous](@previous)

import Foundation



/*
    如果可选项为nil，调用方法、下标、属性失败，结果为nil
    如果可选项不为nil，调用方法、下标、属性成功，结果被包装成可选项
      如果结果本来是可选项，不会进行再次包装
    多个？可以链接在一起（如果链中任何一个节点是nil，那么整个链就会调用失败）
 */

class Car { var price = 0 }
class Dog { var weight = 0 }
class Person {
    var name: String = ""
    var dog: Dog = Dog()
    var car: Car? = Car()
    func age() -> Int {
        return 10
    }
    func eat() {
        print("eat")
    }
    subscript(index: Int) -> Int { return index }
}

var person: Person? = Person()
var age1 = person!.age() //Int
var age2 = person?.age() // Int?
var name = person?.name  // String?
var index = person?[5]   // Int?

func getName() -> String {
    print("get name")
    return "lyy"
}

//person = nil
person?.name = getName() //如果person是nil，getName不会被调用


if let _ = person?.eat() {
    print("eat 调用成功")
}else {
    print("eat 调用失败")
}

//person = nil
var dog = person?.dog // Dog?
var weight = person?.dog.weight // Int?
var price = person?.car?.price // Int?


var scores = ["Lily":[88,90,89],"Rose":[73,93,93]]
scores["Lily"]?[0] = 100
scores["Jack"]?[0] = 100
scores["Rose"]?[0] += 10
print(scores)

var num1: Int? = 5
num1 = 9

var num2: Int? = nil
num2? = 10 // nil => nil = 10
num2 = 9

//var dict: [String:(Int, Int)] = [
//    "sum" : (+),
//    "subtract" : (-)
//]
//var result = dict["sum"]?(10,20) //Optional(30)

















//: [Next](@next)
