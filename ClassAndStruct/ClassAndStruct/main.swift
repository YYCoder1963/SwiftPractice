
import Foundation
//
//typealias Fn = (Int) -> Int
//func getFn() -> Fn {
//    var num = 15
//    func plus(_ i: Int) -> Int {
//        num += i
//        return num
//    }
//    return plus
//}//返回的plus和num形成了闭包


//var fn = getFn()
//fn(1)
//fn(2)

//
//struct Date {
//    var year: Int
//    var month: Int
//    var day: Int
//    func test() -> Void {
//
//    }
//}
//
//
//var date = Date(year: 2019, month: 8, day: 28)
//var date1 = date
//print(Mems.ptr(ofVal: &date))
//print(Mems.ptr(ofVal: &date1))

//print(Mems.memStr(ofVal: &date))
//print(MemoryLayout<Date>.size)
//print(MemoryLayout<Date>.stride)
//print(MemoryLayout<Date>.alignment)

//class Location {
//    var x: Int = 1
//    var y: Int = 2
//}
//
//var loc = Location()
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



/*
    关于String的细节
    Swift中字符串的存储类似OC的taggedPoint
    当字符个数小于等于15时，字符串的内容直接存储在字符串指针变量中
    当字符个数大于15时，字符串指针存储着字符串的内存地址
 */
/*
 s1 viewOfMemory
 30 31 32 33 34 35 36 37
 38 39 00 00 00 00 00 EA
 10 00 00 00 00 00 00 D0
 40 55 00 00 01 00 00 80
 00 00 00 00 00 00 00 00
 */
var s1 = "0123456789"

/*
 s2 viewOfMemory
 30 31 32 33 34 35 36 37
 38 39 61 62 63 64 65 EF
 00 00 00 00 00 00 00 00
 00 00 00 00 00 00 00 00
 */
var s2 = "0123456789abcde"
/*
 s3 viewOfMemory
 10 00 00 00 00 00 00 D0
 40 55 00 00 01 00 00 80
 00 00 00 00 00 00 00 00
 00 00 00 00 00 00 00 00
 */
var s3 = "0123456789abcdef"

//print(Mems.size(ofVal: &s1),Mems.size(ofVal: &s2),Mems.size(ofVal: &s3))


/*
    数组引用指针占8个字节，存储数组的地址
    数组内存中存储着引用计数、元素数量、数组容量、数组元素等
 */

var arr = [1,2,3,4,5]
var arr1 = [1,2,3,4,5,1,2,3,4,5,1,2,3,4,5,1,2,3,4,5]
print(Mems.ptr(ofRef: arr),Mems.ptr(ofRef: arr1))
print(MemoryLayout.size(ofValue: arr),MemoryLayout.size(ofValue: arr1))
