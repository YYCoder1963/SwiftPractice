//: [Previous](@previous)

import Foundation

var arr = [1,2,3]

var arr1 = arr.map { (e) -> Int in
    return e * 2
}

var arr2 = arr.filter { (e) -> Bool in
    return e % 2 == 0
}

var res = arr.reduce(0) { (result, element) -> Int in
    result + element * 2
}


//print(arr,arr1,arr2)

//[[1], [2, 2], [3,3,3]]
//var arr3 = arr.map { Array.init(repeating: $0, count: $0) }
var arr3 = arr.map { (e) -> Array<Int> in
    Array.init(repeating: e, count: e)
}
//[1, 2, 2, 3, 3, 3]
var arr4 = arr.flatMap { (e) -> Array<Int> in
     Array.init(repeating: e, count: e)
}


let result = arr.lazy.map { (i) -> Int in
    print("mapping \(i)")
    return i * 2
}

print("begin ------------------")
print("mapped0",result[0])
print("mapped1",result[1])
print("mapped2",result[2])
print("end ------------------")


//Optional的map和flatMap

var num1: Int? = 1
var num2 = num1.map { $0 * 2 } // Optional(2)

var num3: Int? = nil
var num4 = num3.map { $0 * 2 } // nil

var num5 = num1.map { Optional.some($0 * 2)}//Optional(Optional(2))
var num6 = num1.flatMap { Optional.some($0 * 2)}//Optional(2)

var num7 = (num1 != nil) ? (num1! + 1) : nil
var num8 = num1.map { $0 + 1 } // num7和num8等价

var fmt = DateFormatter()
fmt.dateFormat = "YYYY-MM-DD"
var dateStr: String? = "2019-10-21"

var date1 = dateStr != nil ? fmt.date(from: dateStr!) : nil
var date2 = dateStr.flatMap(fmt.date)



















































//: [Next](@next)
