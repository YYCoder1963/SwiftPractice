//: [Previous](@previous)

import Foundation
import UIKit

// MARK: 类似OC的 #pragma mark

// MARK: - 类似OC的 #pragma mark -

// TODO: 用于标记未完成的任务

//FIXME: 用于标记待修复的问题


// 条件编译
// 操作系统：macOS\iOS\tvOS\watchOS\Linux\Android\Windows\FreeBSD
#if os(macOS) || os(iOS)
// CPU架构：i386\x86_64\arm\arm64
#elseif arch(x86_64) || arch(arm64)
// Swift版本
#elseif swift(<5) && swift(>=3)
// 模拟器
#elseif targetEnvironment(simulator)
// 可导入某模块
#elseif canImport(Foundation)

#else

#endif

// debug模式
#if DEBUG
// release模式
#else
#endif

// 可以在build Setting的swift compiler - custom flags中自定义条件编译


//系统版本检测
if #available(iOS 10,macOS 10.12, *) {
    //iOS平台，在10及以上版本执行
    //macOS平台，在macOS10.12以上版本执行
    //最后的*表示在其他所有平台都执行
}


struct Student {
    @available(*, unavailable, renamed: "study")//study_ 被重命名为study
    func study_() { }
    func study() { }
    
    @available(iOS, deprecated: 11)// 从iOS11开始被废弃
    @available(macOS, deprecated: 10.12)
    func run() { }
}


/*
    在AppDelegate上面默认有个@UIApplicationMain标记
    - 这表示编译器自动生产入口代码（main函数代码），自动设置AppDelegate为APP的代理
    
    - 也可以删掉@UIApplicationMain，自定义入口代码：新建一个main.swift文件
    import UIKit
    class YYApplication: UIApplication {}
    UIApplicationMain(CommandLine.argc,
                      CommandLine.unsafeArgv,
                      NSStringFromClass(YYApplication.self),
                      NSStringFromClass(Application.self))
 */



/*  Swift调用OC
    新建桥头文件，文件名默认为：{targetName}-Bridging-Header.h
    在桥头文件中，#import OC需要暴露给Swift的内容
 */

/*
    如果C语言暴露给Swift的函数名跟Swift中的其他函数名冲突了
    可以在Swift中使用@_silgen_name 修改C函数名
 
    int sum(int a, int b) {
        return a + b
    }

    @_silgen_name("sum") func swift_sum(_ v1: Int32,_ v2: Int32) -> Int32
    print(swift_sum(1,2))
 */


/*  OC调用Swift
    xcode会默认生成一个OC调用Swift的的头文件，文件名格式：{targetName}-Swift.h
    
    Swift暴露给OC的类最终继承自NSObject
    使用@objc修饰要暴露给OC的成员
    可以通过@objc重命名Swift暴露给OC的符号名（类名、属性名、函数名等）
    使用@objcMembers修饰类
    - 代表默认所有成员都会暴露给OC（包括扩展中定义的成员）
    - 最终是否暴露成功，还要考虑到成员自身的访问级别
    
 */

@objc(YYCar)
@objcMembers class Car: NSObject {
    var price: Double
    @objc(name)
    var band: String
    init(price: Double, band: String) {
        self.price = price
        self.band = band
    }
    @objc(drive)
    func run() {
        print(price,band,"run")
    }
    static func run() { print("Car run") }
}

extension Car {
    @objc(exec)
    func test() {
        print(price,band,"test")
    }
}

/*  选择器（Selector）
    Swift中也可以使用选择器，使用#selector(name)定义一个选择器
    - 必须是被@objcMembers或@objc修饰的方法才可以定义选择器
*/

@objcMembers class Person: NSObject {
    func test1()  {
        print("test1")
    }
    func test2(v1: Int, v2: Int) {
        print("test2")
    }
    func run() {
        perform(#selector(test1))
        perform(#selector(test2(v1:v2:)))
    }
}


/*  String
    Swift的字符串类型String和OC的NSString，在API的设计上差异较大
 */

//空字符串
var s1 = ""
var s2 = String()

print(s1.hasPrefix("1"),s1.hasSuffix("1"))

//字符串拼接
s1.append("1")

//重载运算符
s1 = s1 + "2"
s1 += "3"
// \() 插值
s1 = "\(s1)3"
// 字符串长度
print(s1.count)


// 字符串的插入和删除
var str = "12"
str.insert("_", at: str.endIndex)//12_
str.insert(contentsOf: "34", at: str.endIndex)//12_34
str.insert(contentsOf: "66", at: str.index(after: str.startIndex))//1662_34
str.insert(contentsOf: "88", at: str.index(before: str.endIndex))//1662_3884
str.insert(contentsOf: "_00", at: str.index(str.startIndex, offsetBy: 3))//166_002_3884"


str.remove(at: str.firstIndex(of: "3")!)//166_002_884
str.removeAll { (c) -> Bool in
    return c == "0"
}//166_2_884
var range = str.index(str.endIndex, offsetBy: -4)..<str.index(before: str.endIndex)
str.removeSubrange(range)//166_24

/*
    string可以通过下标、prefix、suffix等截取子串，子串类型是Substring，不是String
    Substring和它的base，共享字符串数据。当Substring发生修改或转为String时，会分配新的内存存储字符串数据
 */
var s3 = "1_2_3_4_5"
print("-----------------")
var substr1 = s3.prefix(3)//1_2
print(substr1)
var substr2 = s3.suffix(3)//4_5
print(substr2)
var range1 = s3.startIndex..<str.index(str.startIndex, offsetBy: 3)
var substr3 = s3[range1]//1_2
print(substr3)

print(substr3.base)//1_2_3_4_5

var str2 = String(substr3)
print(str2)

for c in "jack" {
    print(c)
}

var name = "Jack"
var c = name[name.startIndex]


//多行String
let sss = """
1
    "2"
3
    '4'
"""

//如果要显示3引号，至少转义1个引号

let sss1 = """
escaping the first quote \"""
escaping two quote \"\""
escaping all three quote \"\"\"
"""

/*
    String与NSString之间可以随时桥接转换
    如果觉得String的API复杂难用，可以考虑将String转换为NSString
 */

var ss: String = "Lee"
var ss1: NSString = "Lily"
var ss2 = ss as NSString
var ss3 = ss1 as String

var ss4 = ss2.substring(with: NSRange(location: 1, length: 1))

protocol  Runnable: AnyObject {}
protocol Runnable1: class {}
@objc protocol Runnable2 {}
//被@objc修饰的协议，还可以暴露给OC去遵守实现
//可以用@objc定义可选协议，这种协议只能被class遵守

//被@objc dynamic修饰的内容会具有动态性，比如调用方法会走runtime那一套流程


/*  Swift支持KVC\KVO的条件
    - 属性所在的类、监听器最终继承自NSObject
    - 用@objc dynamic 修饰对应的属性
 */



class Dog: NSObject {
    @objc dynamic var age: Int = 0
    var observation: NSKeyValueObservation?
    override init() {
        super.init()
        observation = observe(\Dog.age, options: .new, changeHandler: { (dog, change) in
            print("observe:\(change.newValue as Any)")
        })
    }
}

var d = Dog()
d.age = 1
d.setValue(2, forKey: "age")


/*  关联对象
    在Swift中，class依然可以使用关联对象
    默认情况，extension不可以增加存储属性
    - 借助关联对象，可以实现类似extension为class增加属性的效果
 */

extension Dog {
    private static var NAME_KEY: Void?
    var name: Int {
        get {
            (objc_getAssociatedObject(self, &Self.NAME_KEY) as? Int) ?? 0
        }
        set {
            objc_setAssociatedObject(self, &Self.NAME_KEY, newValue, .OBJC_ASSOCIATION_ASSIGN)
        }
    }
    
}


// 资源名管理

enum R {
    enum string:String {
        case add = "添加"
    }
    enum image: String {
        case logo
    }
    enum segue: String {
        case login_main
    }
}

extension UIImage {
    convenience init?(_ name: R.image) {
        self.init(named: name.rawValue)
    }
}

extension UIButton {
    func setTitle(_ title: R.string, for state: UIControl.State) {
        setTitle(title.rawValue, for: state)
    }
}

let img = UIImage( R.image.logo)

let btn = UIButton(type: .custom)
btn.setTitle(R.string.add, for: .normal)


//资源名管理的其他思路
enum Resource {
    enum image {
        static var logo = UIImage(named: "logo")
    }
    enum font {
        static func arial(_ size: CGFloat) -> UIFont? {
            UIFont(name: "Arial", size: size)
        }
    }
}

let image = Resource.image.logo
let font = Resource.font.arial(12)




//多线程开发--异步
public typealias Task = () -> Void

public func async(_ task: @escaping Task) {
    _async(task)
}

public func async(_ task: @escaping Task,
                  _ mainTask: @escaping Task){
    _async(task, mainTask)
}

private  func _async(_ task: @escaping Task,
                    _ mainTask: Task? = nil) {
    let item = DispatchWorkItem(block: task)
    DispatchQueue.global().async(execute: item)
    if let main = mainTask {
        item.notify(queue: DispatchQueue.main, execute: main)
    }
}


//延迟
public func delay(_ seconds: Double,
                         _ block: @escaping Task) -> DispatchWorkItem {
    let item = DispatchWorkItem(block: block)
    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + seconds, execute: item)
    return item
}

//异步延迟
public func asyncDelay(_ seconds: Double,
                       _ task: @escaping Task) -> DispatchWorkItem {
    return _asyncDelay(seconds, task)
}

private func _asyncDelay(_ seconds: Double,
                         _ task: @escaping Task,
                         _ mainTask: Task? = nil) -> DispatchWorkItem {
    let item = DispatchWorkItem(block: task)
    DispatchQueue.global().asyncAfter(deadline: DispatchTime.now() + seconds, execute: item)
    if let main = mainTask {
        item.notify(queue: DispatchQueue.main, execute: main)
    }
    return item
}



/*
    once
    dispatch_once在Swift中已经被废弃
    用类型属性或则全局变量\常量取代，默认自带lazy + dispatch_once 效果
 */

class Test {
    static let initTask: Void = {
        print("task")
    }()
    
    init() {
        let _ = Self.initTask
    }
}

var task = Test()


//加锁
class Cache {
    private static var data = [String: Any]()
    private static var lock = DispatchSemaphore(value: 1)
    private static var nslock = NSLock()
    private static var recurLock = NSRecursiveLock()
    static func set(_ key: String, _ value: Any) {
        lock.wait()
        defer {
            lock.signal()
        }
        data[key] = value
    }
    
    static func set1(_ key: String, _ value: Any) {
        nslock.lock()
        defer {
            nslock.unlock()
        }
        data[key] = value
    }
    
    static func set2(_ key: String, _ value: Any) {
        recurLock.lock()
        defer {
            recurLock.unlock()
        }
        data[key] = value
    }
}



//: [Next](@next)
