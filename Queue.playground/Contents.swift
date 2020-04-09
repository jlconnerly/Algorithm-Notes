import UIKit

/*
 QUEUE:
    * A Queue is just like a stack except its FIFO(First In First Out)
    * This could be helpful if the order matters
    * To enqueue is an O(1) operation because it adds the element to the back
    * Dequeue is a different story because we are removing from the front and then need to shift everything to the left(slow).
 
    EFFICIENT DEQUEUE:
        *
        *
 */

public struct Queue<T> {
  fileprivate var array = [T?]()   //We ensure the array stores a T optional
  fileprivate var head = 0         //The index is the HEAD element in this case to mark the forward most element

  
  public var isEmpty: Bool {
    return count == 0
  }

  public var count: Int {
    return array.count - head
  }
  
  public mutating func enqueue(_ element: T) {
    array.append(element)
  }
  
  public mutating func dequeue() -> T? {
    guard head < array.count, let element = array[head] else { return nil }

    array[head] = nil           //When we dequeue, we set the element to nil as a placeholder
    head += 1                   //Then increment the head to the next element which will be the new first element

    let percentage = Double(head)/Double(array.count)  //This calculates the percentage of unused spaces
    if array.count > 50 && percentage > 0.25 {         //If more than 25% of the array is unused, we trim off the
        array.removeFirst(head)                        //wasted space
      head = 0
    }
    
    return element
  }
  
  public var front: T? {
    if isEmpty {
      return nil
    } else {
      return array[head]
    }
  }
}

var q = Queue<String>()
q.array                   // [] empty array

q.enqueue("Ada")
q.enqueue("Steve")
q.enqueue("Tim")
q.array             // ["Ada", "Steve", "Tim"]
q.count             // 3

q.dequeue()         // "Ada"
q.array             // [nil, "Steve", "Tim"]
q.count             // 2

q.dequeue()         // "Steve"
q.array             // [nil, nil, "Tim"]
q.count             // 1

q.enqueue("Grace")
q.array             // [nil, nil, Tim, "Grace"]
q.count             // 2
