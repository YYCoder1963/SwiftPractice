//: [Previous](@previous)

import Foundation


/*
    值类型不支持继承，只有类支持继承
    没有父类的类称为基类，Swift没有像OC、Java规定：任何类都要继承自某个基类
    子类可以重写父类的下标、方法、属性，重写必须加override关键字
 */

class Animal {
    var age = 0
}

class Dog: Animal {
    var weight = 0
}

class ErHa : Dog {
    var iq = 0
}

let a = Animal()
a.age = 10

print(MemoryLayout<Animal>.size)
print(MemoryLayout<Dog>.size)
print(MemoryLayout<ErHa>.size)


//重写实例方法、下标
class Animal1 {
    func speak() {
        print("Animal speak")
    }
    subscript(index: Int) -> Int {
        return index
    }
}

class Cat: Animal1 {
    override func speak() {
        super.speak
        print("Cat speak")
    }
    override subscript(index: Int) -> Int {
        return super[index] + 1
    }
}

var anim : Animal1
anim = Animal1()
anim.speak()
print(anim[6])

anim = Cat()
anim.speak()
print(anim[6])

//重写类型方法、下标
//class Animal2 {
//    class func speak() {
//        print("Animal speak")
//    }
//    class subscript(index: Int) -> Int {
//        return index
//    }
//}
//
//class Cat2: Animal2 {
//    override class func speak() {
//        super.speak()
//        print("Cat Speak")
//    }
//    override class subscript(index: Int) -> Int {
//        return super[index] + 1
//    }
//}


/*
    重写属性
    子类可以将父类的属性(存储、计算)重写为计算属性
    子类不可以将父类属性重写为存储属性
    只能重写var属性，不能重写let属性
    重写时，属性名、类型要一致
 
    子类重写后的属性权限不能小于父类属性权限
        如果父类属性是只读的，那么子类重写后可以只读也可以是读写的
        如果父类属性是可读写的，那么子类重写后必须是可读写的
 */


class Circle {
    var radius: Int = 0
    var diameter: Int {
        set {
            print("Circle setDiameter")
            radius = newValue/2
        }
        get {
            print("Circle getDiameter")
            return radius * 2
        }
    }
}

class SubCircle : Circle {
    override var radius: Int {
        set {
            print("SubCircle setRadius")
            super.radius = newValue > 0 ? newValue : 0
        }
        get {
            print("SubCircle getRadius")
            return super.radius
        }
    }
    override var diameter: Int {
        get {
            print("SubCircle getDiameter")
            return super.diameter
        }
        set {
            print("SubCircle setDiameter")
            super.diameter = newValue > 0 ? newValue : 0
        }
    }
}


/*
    重写类型属性
    被class修饰过的计算类型属性，可以被子类重写
    被static修饰的类型属性（存储、计算），不可以被子类重写
 */

class Circle1 {
    static var radius: Int = 0
    class var diameter: Int {
        set {
            print("Circle1 setDiameter")
            radius = newValue / 2
        }
        get {
            print("Circle1 getDiameter")
            return radius * 2
        }
    }
}


class SubCircle1 : Circle1 {
    override static var diameter: Int {
        set {
            print("Circle1 setDiameter")
            super.diameter = newValue > 0 ? newValue : 0
        }
        get {
            print("Circle1 getDiameter")
            return super.diameter
        }
    }
}

//可以在子类中为父类属性（除了只读计算属性，let属性）增加属性观察器
class Circle2 {
    var radius: Int = 1
}

class SubCircle2 : Circle2 {
    override var radius: Int {
        willSet {
            print("SubCircle willSetRadius",newValue)
        }
        didSet {
            print("SubCircle didSetRadius",oldValue,radius)
        }
    }
}

class Circle3 {
    var radius: Int {
        set {
            print("Circle3 setDiameter")
        }
        get {
            print("Circle3 getDiameter")
            return 20
        }
    }
}

class SubCircle3 : Circle3 {
    override var radius: Int {
        willSet {
            print("SubCircle willSetRadius",newValue)
        }
        didSet {
            print("SubCircle didSetRadius",oldValue,radius)
        }
    }
}

class Circle4 {
    class var diameter: Int {
        set {
            print("Circle1 setDiameter")
        }
        get {
            print("Circle1 getDiameter")
            return 11
        }
    }
}


class SubCircle4 : Circle4 {
    override static var diameter: Int {
        willSet {
            print("SubCircle willSetRadius",newValue)
        }
        didSet {
            print("SubCircle didSetRadius",oldValue,diameter)
        }
    }
}


/*
    被final修饰的方法、下标、属性，禁止被重写
    被final修饰的类，禁止被继承
 */

//: [Next](@next)
