
import Foundation

struct Date {
    var year: Int
    var month: Int
    var day: Int
    func test() -> Void {
        
    }
}


var date = Date(year: 2019, month: 8, day: 28)

print(Mems.memStr(ofVal: &date))
print(MemoryLayout<Date>.size)
print(MemoryLayout<Date>.stride)
print(MemoryLayout<Date>.alignment)
