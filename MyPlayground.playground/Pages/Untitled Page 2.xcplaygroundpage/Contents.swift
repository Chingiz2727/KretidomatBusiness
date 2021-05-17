import Foundation

func ArrayCouples(_ arr: [Int]) -> Int {
    let dividedArray = stride(from: 0, to: arr.count, by: 2).map {
        Array(arr[$0 ..< Swift.min($0 + 2, arr.count)])
    }
    for (key,value) in dividedArray.enumerated() {
            if dividedArray[key] == dividedArray[key+1].reversed() {
            }

        
    }
    print(dividedArray)
    return arr[0]
}

ArrayCouples([2,1,1,2,3,3])
