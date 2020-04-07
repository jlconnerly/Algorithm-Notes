//: [Previous](@previous)

import Foundation

let array = [2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61, 67, 72]

// MARK: - BINARY SEARCH
//  - Takes an ORDERED set and starts search in middle
//  - If the middle is the target then we are done! Yes!
//  - If the middle is less than the target, we eliminate the entire LEFT SIDE of array
//  - Repeat the process on the RIGHT SIDE of the array. (Start in middle, and eliminate)

// Binary Search Example - Iterative

func binarySearch(for target: Int, in array: [Int]) -> Int? {
    var lowLimit = 0
    var highLimit = array.count
    while lowLimit < highLimit {
        let middleIndex = lowLimit + (highLimit - lowLimit) / 2
        if array[middleIndex] == target {
            return middleIndex
        } else if array[middleIndex] < target {
            lowLimit = middleIndex + 1
        } else {
            highLimit = middleIndex
        }
    }
    return nil
}

binarySearch(for: 41, in: array)


/*
 NOTES:
    The performance is not O(n) like Linear Search.  For Binary Search, is is O(log n).
 
    For example: binary search on an array with 1_000_000 elements only takes about 20 steps because
                 log_2(1_000_000) = 19.9
 
    The downside to a binary search is, the array has to be sorted.
 */

//: [Next](@next)
