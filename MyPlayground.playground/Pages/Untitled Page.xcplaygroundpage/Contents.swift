import Foundation

func ArrayCouples(_ arr: [Int]) -> Int {
    let dividedArray = stride(from: 0, to: arr.count, by: 2).map {
        Array(arr[$0 ..< Swift.min($0 + 2, arr.count)])
    }
    for (_,value) in dividedArray.enumerated() {
        let droppedArray = dividedArray.filter { $0 != value }
        if droppedArray.contains(value.reversed()) {
            print(true)
        } else {
            print(value.reversed())
        }
    }
    return arr[0]
}

ArrayCouples([2,1,1,2,3,3])
