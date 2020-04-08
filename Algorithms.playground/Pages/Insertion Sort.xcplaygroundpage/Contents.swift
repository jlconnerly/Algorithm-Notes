//: [Previous](@previous)

import Foundation

// MARK: - Notes for Insertion Sort

/*
 How it works in pseudocode:
    * Put the numbers in an unsorted pile.
    * Pick a number from the pile.  It number really doesnt matter but it is easier to just pick the first one.
    * Insert this number into a new array.
    * Pick the next number from the unsorted pile and insert into new array.  It goes either before or after the first number so now these two are sorted.
    * Pick the next number and insert into correct position.
    * Continue until no more numbers in unsorted pile.
    
 Pseudocode Example:
    * Our unsorted array is:                                   new = []              old = [8, 3, 5, 4, 6]
    * Pick the first number(8) and insert into new array:      new = [8]             old = [3, 5, 4, 6]
    * Pick the next number(3) and insert into proper position: new = [3, 8]          old = [5, 4, 6]
    * iterate, pick(5):                                        new = [3, 5, 8]       old = [4, 6]
    * iterate, pick(4):                                        new = [3, 4, 5, 8]    old = [6]
    * iterate, pick(6):                                        new = [3, 4, 5, 6, 8] old = []
 */

//MARK: - Properties

let array = [8, 3, 5, 4, 6]
let longerArray = [74, 32, 43, 2, 90, 120, 58, 26, 19, 10]

//MARK: - InsertionSort

func insertionSort(_ array: [Int]) -> [Int] {
    let start = CFAbsoluteTimeGetCurrent()
    var newArray = array
    for indexOfPile in 1..<newArray.count {
        var indexToCheck = indexOfPile
        while indexToCheck > 0 && newArray[indexToCheck] < newArray[indexToCheck - 1] {
            newArray.swapAt(indexToCheck - 1, indexToCheck)
            indexToCheck -= 1
        }
    }
    let end = CFAbsoluteTimeGetCurrent() - start
    print("Total time elapsed: \(end)")
    return newArray
}

//MARK: - Insetion Sort Test Cases

insertionSort(array)
insertionSort(longerArray)


/*
 How does this work?
    * First we make a copy of the array
    * There are two loops inside this function
    * The outer loop looks at each element in the array, this is picking up the first number from the pile.
    * the variable ELEMENT is the index of where the sorted portion ends and the pile begins.
    * THe inner loop looks at the element at position of the element and steps backwards through the sorted array
    * Everytime it finds a number larger it swaps them
 */

//: [Next](@next)
