//: [Previous](@previous)

import Foundation

//MARK: - Initial Notes for Quick Sort

/*
    * Quicksort is one of the most famous algorithms in history.
 
 How Quicksort Works in Pseudocode:
    * Splits the array into three parts based on a pivot point.
    * All elements less than the pivot go into a new array called "less".
    * All elements equal the pivot go into an array called "equal".
    * All elements greater go into an array called "greater".
    * Once we have all three arrays, quicksort recursivly sorts the less and greater arrays.
    * Then quicksort puts the three together to get our final sorted array.
 
 Example Stepping Through Quicksort:
    * unsortedArray = [ 10, 0, 3, 9, 2, 14, 8, 27, 1, 5, 8, -1, 26]
    * First, we need to pick a pivot element.
    * In this case it will be (8) because it is in the middle.
    * Now we need to split the array into less, equal and greater.
    * less:    [0, 3, 2, 1, 5, -1]
    * equal:   [8, 8]
    * greater: [10, 9, 14, 27, 26]
    * Notice that the less and greater arrays are not sorted yet.
    * We must call quicksort again on these two subarrays
 
    Quicksort on Less Array:
        * less: [0, 3, 2, 1, 5, -1]
        * Pivot point will be 1
        * Create three sub arrays from this as well
        * less:    [ 0, -1 ]
        * equal:   [ 1 ]
        * greater: [ 3, 2, 5 ]
        * We're still not done as the less for the original less still needs to be sorted
            * We call quicksort on the less array inside the original less array
            * Our pivot point will be -1
            * less:    []
            * equal:   [-1]
            * greater: [0]
        * The less array is empty because there is no value that is less than (-1) in this case
        * Now we can go back to the orginal less' greater array
            * Our pivot will be (2)
            * less:    []
            * equal:   [2]
            * greater: [3, 5]
            * Now split greater
                * Pivot will be (3)
                * less:    []
                * equal:   [3]
                * greater: [5]
        * Now we are finsihed with the ORIGNAL less side.  Next we need to do the greater side.
 
                                [ 10, 0, 3, 9, 2, 14, 8, 27, 1, 5, 8, -1, 26]
                                /                     |                     \
                            less                    equal                   greater
                    [0, 3, 2, 1, 5, -1]             [8, 8]              [10, 9, 14, 27, 26]
                    /       |      \                                    /       |       \
                less      equal    greater                             less      equal      greater
            [0, -1]       [1]     [3, 2, 5]                            [10, 9]     [14]       [27, 26]
            /  |  \               /    |    \                         /   |   \              /    |   \
        less equal greater      less  equal greater                less  equal greater     less  equal greater
        []   [-1]  [0]          []    [2]   [3, 5]                 []    [9]   [10]        []    [26]  [27]
                                           /   |  \
                                        less equal greater
                                        []   [3]   [5]
        * If we look at the bottom most numbers in this graph, we will notice they are sorted.
        * now lets push them back together. [-1, 0, 1, 3, 5, 8, 8, 9, 10, 26, 27]
 */

//MARK: - Propteries
let unsortedArray = [ 10, 0, 3, 9, 2, 14, 8, 27, 1, 5, 8, -1, 26]

//MARK: - Quicksort

func quicksort(_ array: [Int]) -> [Int] {
    guard array.count > 1 else { return array }
    
    let pivot    = array[array.count / 2]
    let less     = array.filter { $0 < pivot }
    let equal    = array.filter { $0 == pivot }
    let greater  = array.filter { $0 > pivot }
    
    return quicksort(less) + equal + quicksort(greater)
}

quicksort(unsortedArray)
//: [Next](@next)
