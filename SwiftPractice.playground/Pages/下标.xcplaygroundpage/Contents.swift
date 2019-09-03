//: [Previous](@previous)

import Foundation


/*
    使用下标可以给任意类型（枚举、结构体、类）增加下标功能，有些地方也翻译为下标脚本
    subscript的语法类似于实例方法、计算属性，本质是方法
    subscript中定义的返回值类型决定了get方法的返回值类型，set方法中newValue的类型
    subscript可以接受多个参数，并且类型任意
*/

class Point {
    var x = 0.0,y = 0.0
    subscript(index: Int) -> Double {
        set {
            if index == 0 {
                x = newValue
            }else if index == 1 {
                y = newValue
            }
        }
        get {
            if index == 0 {
                return x
            }else if index == 1 {
                return y
            }
            return 0
        }
    }
}

var p = Point()
p[0] = 1.1
p[1] = 2.2

print(p.x,p.y)
print(p[0],p[1])


/*
    subscript可以没有set方法，但必须有get方法；
    如果只有get方法，可以省略get
    下标可以设置参数标签，下标可以是类型方法
 */

class Point1 {
    var x = 0.0,y = 0.0
    subscript(index i: Int) -> Double {
//        get
            if i == 0 {
                return x
            }else if i == 1 {
                return y
            }
            return 0
//        }
    }
}


var p1 = Point1()
p1.x = 11
p1.y = 12
print(p1[index: 0],p1[index: 1])


//class sum {
//    static subscript(v1: Int, v2: Int) -> Int{
//        return v1 + v2
//    }
//}



class Point3 {
    var x = 0, y = 0
}

class PointManager {
    var point = Point3()
    subscript(index: Int) -> Point3 {
        get { return point }
    }
}

var pm = PointManager()
pm[0].x = 11
pm[1].y = 12
print(pm[0],pm.point)


struct Point4 {
    var x = 0, y = 0
}

class PointManager1 {
    var point = Point4()
    subscript(index: Int) -> Point4 {
        set { point = newValue }
        get { return point }
    }
}
var pm1 = PointManager1()
pm1[0].x = 11
pm1[1].y = 12
print(pm1[0],pm1.point)


//接收多个参数的下标

class Grid {
    var data = [
        [0,1,2],
        [3,4,5],
        [6,7,8]
    ]
    
    subscript(row: Int, column: Int) -> Int {
        set {
            guard row >= 0 && row < 3 && column >= 0 && column < 3 else {
                return
            }
            data[row][column] = newValue
        }
        get {
            guard row >= 0 && row < 3 && column >= 0 && column < 3 else {
                return 0
            }
            return data[row][column]
        }
    }
}

var grid = Grid()
grid[0,1] = 11
grid[1,2] = 99
print(grid.data)

//: [Next](@next)


