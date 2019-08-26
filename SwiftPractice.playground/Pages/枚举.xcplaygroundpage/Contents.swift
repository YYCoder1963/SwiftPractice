//: [Previous](@previous)

import Foundation


//基本用法
//隐式赋值：如果枚举的原始值类型是Int，String，Swift会自动分配原始值（Direction 等价于 Direction1）

//enum Direction {
//    case north
//    case south
//    case east
//    case west
//}
//
//enum Direction1 {
//    case north,south,east,west
//}
//
//var dir = Direction.north
//dir = Direction.east
//print(dir)
//
//var dir1 = Direction1.east
//dir1 = Direction1.north
//print(dir1)
//
////递归枚举
////递归枚举需加indirect修饰
//indirect enum ArithExpr {
//    case number(Int)
//    case sum(ArithExpr,ArithExpr)
//    case difference(ArithExpr,ArithExpr)
//}
//
//enum ArithExpr1 {
//    case number(Int)
//    indirect case sum(ArithExpr,ArithExpr)
//    indirect case difference(ArithExpr,ArithExpr)
//}
//
//func calculate(_ expr:ArithExpr) -> Int {
//    switch expr {
//    case let .number(value):
//        return value
//    case let .sum(left, right):
//        return calculate(left) + calculate(right)
//    case let .difference(left, right):
//        return calculate(left) - calculate(right)
//    }
//}
//
//let diference = ArithExpr.difference(ArithExpr.number(9), ArithExpr.number(6))
//calculate(diference)
//
//
////关联值:将枚举成员值与其他类型的值关联存储在一起
//enum Score {
//    case points(Int)
//    case grade(Character)
//}
//
//var score = Score.points(99)
//score = .grade("A")
//switch score {
//case let .points(i):
//    print(i,"points")
//case let .grade(i):
//    print("grade",i)
//}
//
//enum Date {
//    case digit(year: Int,mouth: Int,day: Int)
//    case string(String)
//}
//var date = Date.digit(year: 2011, mouth: 9, day: 10)
//date = .string("2019-08-28")
//switch date {
//case .digit(let year,let mouth, let day):
//    print(year,mouth,day)
//case let .string(value):
//    print(value)
//}
//
//enum Password {
//    case number(Int, Int, Int, Int)
//    case gesture(String)
//}
//
//var pwd = Password.number(1, 9, 6, 3)
//pwd = .gesture("1963")
//
////原始值：
//enum PokerSuit : Character {
//    case spade = "♠️"
//    case heart = "♥️"
//    case diamond = "♦️"
//    case club = "♣️"
//}
//
//var suit = PokerSuit.spade
//print(suit)
//print(suit.rawValue)
//print(PokerSuit.heart.rawValue)
//
///*
//   枚举内存
//   1、如果枚举有关联值，且有多个case，枚举实际使用的内存大小等于case中关联值占内存最大值加上1（这一位用于存储区分case）
//     如果枚举没有关联值，但有多个case，枚举实际使用内存大小为1（这一位用于存储区分case）
//     如果枚举没有关联值，切只有一个case，枚举实际使用内存大小为0
// */
//
//print(MemoryLayout<Password>.stride)//40，实际分配的内存大小
//print(MemoryLayout<Password>.size)  //33，实际使用的内存大小
//print(MemoryLayout<Password>.alignment)//8，对其参数

enum TestEnum {
    case test1,test2,test3
}
//print(MemoryLayout<TestEnum>.stride)//1，实际分配的内存大小
//print(MemoryLayout<TestEnum>.size)  //1，实际使用的内存大小
//print(MemoryLayout<TestEnum>.alignment)//1，对其参数

//enum TestEnum1: Int {
//    case test1 = 1,test2 = 2,test3 = 3 //虽然有原始值，但只需要1位区分不同case即可
//}
//print(MemoryLayout<TestEnum1>.stride)//1，实际分配的内存大小
//print(MemoryLayout<TestEnum1>.size)  //1，实际使用的内存大小
//print(MemoryLayout<TestEnum1>.alignment)//1，对其参数
//
//enum TestEnum2 {
//    case test//只有一个case，不需要1位区分不同case
//}
//print(MemoryLayout<TestEnum2>.stride)//1，实际分配的内存大小
//print(MemoryLayout<TestEnum2>.size)  //0，实际使用的内存大小
//print(MemoryLayout<TestEnum2>.alignment)//1，对其参数
//
//enum TestEnum3 {
//    case test1(Int,Int,Int)
//    case test2(Int,Int)
//    case test3(Int)
//    case test4(Bool)
//    case test5
//}
//
//print(MemoryLayout<TestEnum3>.stride)//32，实际分配的内存大小
//print(MemoryLayout<TestEnum3>.size)  //25，实际使用的内存大小
//print(MemoryLayout<TestEnum3>.alignment)//8，对其参数


enum TestEnum4 {
    case test0
    case test1
    case test3
    case test4(Int)
    case test5(Int,Int)
    case test6(Int,Int,Int)
    case test7(Int,Int,Int,Bool)
}
print(MemoryLayout<TestEnum4>.stride)//32，实际分配的内存大小
print(MemoryLayout<TestEnum4>.size)  //25，实际使用的内存大小
print(MemoryLayout<TestEnum4>.alignment)//8，对其参数

enum TestEnum5{
    case test0
    case test1
    case test2
    case test4(Int)
    case test5(Int,Int)
    case test6(Int,Bool,Int)
}
print(MemoryLayout<TestEnum5>.stride)//32，实际分配的内存大小
print(MemoryLayout<TestEnum5>.size)  //25，实际使用的内存大小
print(MemoryLayout<TestEnum5>.alignment)//8，对其参数

//: [Next](@next)
