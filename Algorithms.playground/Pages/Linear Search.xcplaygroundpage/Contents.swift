import UIKit

let array = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19]

// MARK: - LINEAR SEARCH
//  - most straight forward
//  - start at the beginning & iterate through each item
//  - stops if: (1) find target (2) reach the end of set

// Linar Search Example

func linearSearch(for target: Int, in array: [Int]) -> String {
    let start = CFAbsoluteTimeGetCurrent()

    var index: Int?
    for item in array {
        if item == target {
            index = target
        }
    }
    
    if let index = index {
        let diff = CFAbsoluteTimeGetCurrent() - start
        print("Total time elapsed: \(diff)")
        return "\(target) is at index \(index)"
    } else {
        let diff = CFAbsoluteTimeGetCurrent() - start
        print("Total time elapsed with not found: \(diff)")
        return "\(target) is not in the list"
    }
}

linearSearch(for: 12, in: array)
linearSearch(for: 20, in: array)
