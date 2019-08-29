
import Foundation

struct Date {
    var year: Int
    var month: Int
    var day: Int
    func test() -> Void {
        
    }
}


var date = Date(year: 2019, month: 8, day: 28)
var date1 = date
print(Mems.ptr(ofVal: &date))
print(Mems.ptr(ofVal: &date1))

//print(Mems.memStr(ofVal: &date))
//print(MemoryLayout<Date>.size)
//print(MemoryLayout<Date>.stride)
//print(MemoryLayout<Date>.alignment)

class Location {
    var x: Int = 1
    var y: Int = 2
}

var loc = Location()
//Argument passed to call that takes no arguments
//let loc = Location(x:1,y:1)

//print(Mems.ptr(ofRef: loc))
//print(MemoryLayout<Date>.size)      //24
//print(MemoryLayout<Date>.stride)    //24
//print(MemoryLayout<Date>.alignment) //8

/*
 结构体和类的本质区别：结构体是值类型，类是引用类型
 结构体实例对象存放成员变量的值，类的实例对象存放的是对象的地址
 */


/*
 值类型赋值给var、let或者给函数传参，是直接将所有内容拷贝一份
 在Swift标准库中，为了提升性能，String、Array、Dictionary、Set等采取了Copy On Write的技术：
 仅当有“写”操作时，才会真正执行拷贝（a = b，若a、b均不修改，不执行Copy操作）
 */



