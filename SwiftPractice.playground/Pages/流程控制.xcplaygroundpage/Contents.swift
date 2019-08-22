
//: [Previous](@previous)

import UIKit


//: if-else

let age = 3
/*
 'Int' is not convertible to 'Bool'
 if后面的条件只能是bool类型，小括号可以省略d，大括号不可省略
 if age {}
 */

if age >= 18 {
    print("adult");
}else if age >= 7 {
    print("go to scholl")
}else {
    print("child")
}

var num = 5
while num > 0 {
    print("num is \(num)")
    num -= 1
    /*
     Use of unresolved operator '--'; did you mean '-= 1'? Swift3开始去除自增、自减
     num--
     */
    
}


//:for
let names = ["Joyce","Luoise","Steven"]

//闭区间
for i in 0...2 {
    print(names[i])
}

//i默认是let，需要时可以声明为var
for var i in 1...3 {
    i += 2
    print(i)
}

for _ in 1...3 {
    print("--------\n")
}

//半开区间运算符
for i in 1..<3 {
    print(i)
}

for name in names[2...] {
    print(name)
}


for name in names[...2] {
    print(name)
}


for name in names[..<2] {
    print(name)
}


//:区间类型
let range1: ClosedRange<Int> = 1...3
let range2: Range<Int> = 1..<3
let range3: PartialRangeThrough<Int> = ...5

let stringRange1 = "aa"..."dd"
stringRange1.contains("az")     //true
stringRange1.contains("ff")     //false

//\0到~囊括了所有可能用到的ASCII字符
let characterRange: ClosedRange<Character> = "\0"..."~"
characterRange.contains("G")


//带间隔的区间

let hours = 11
let hourInterval = 2
for tickMark in stride(from: 4, through: hours, by: hourInterval){
    print(tickMark)
}

//:Swift

//case、default后面不能写大括号；默认不写break，不会贯穿后面条件
var number = 1
switch number {
case 1:
    print("number = 1")
case 2:
    print("number = 2")
case 3:
    print("number = 3")
default:
    print("number is other")
}

//使用fallthrough可以实现贯穿效果
switch number {
case 1:
    print("number = 1")
    fallthrough
case 2:
    print("number = 2")
case 3:
    print("number = 3")
default:
    print("number is other")
}

/*
 Switch must be exhaustive Switch必须处理所有情况，case、default后面至少有一条语句，若不用处理任何事，加个break即可
 
 switch number {
    case 1:
    print("number = 1")
 }
 */

switch number {
    case 1:
        print("number = 1")
    case 2:
        break
    default:
        break
}

//若能保证处理了所有情况，可以不适用default
enum Answer {case right,wrong}
let answer = Answer.right
switch answer {
case .right:
    print("right")
case .wrong:
    print("wrong")
}

//swtich也支持Character、String类型
let string = "Lily"
switch string {
case "Lily","Jack":
    print("Right Person")
default:
    break
}

let character:Character = "a"
switch character {
case "a","A":
    print("the letter a")
default:
    print("not letter a")
}

//区间、元组匹配
let point = (1,1)
switch point {
case (0,0):
    print("the origin")
case (_,0):
    print("x-axis")
case (0,_):
    print("y-axis")
case (-2...2,-2...2):
    print("inside of the box")
default:
    print("outsize of the box")
}


let count = 62
switch count {
case 0:
    print("none")
case 1..<5:
    print("a few")
case 5..<12:
    print("several")
case 12..<100:
    print("dozens of")
case 100..<1000:
    print("hundreds of")
default:
    print("a litter")
}

//值绑定
switch point {
case (let x,0):
    print("on the x-axis with an x value of \(x)")
case (0,let y):
    print("on the y-axis with an y value of \(y)")
case let (x,y):
    print("somewhere else at (\(x),\(y))")
}

//结合where
switch point {
case let(x,y) where x == y:
    print("on the line which x == y")
case let(x,y) where x == -y:
    print("on the line which x == -y")
case let(x,y):
    print("(\(x),\(y)) is just some arbitrary point")
}

var numbers = [1,2,3,4,-3,-4]
var sum = 0
for num in numbers where num > 0{
    sum += sum;
}
print(sum)


outer:for i in 1...4 {
    for k in 1...4 {
        if k == 3 {
            continue outer
        }
        if i == 3 {
            break outer
        }
        print("i ==\(i),k == \(k)")
    }
}


//: [Next](@next)
