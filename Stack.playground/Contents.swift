import Foundation

/*
 STACK:
    * A stack is like an array but with limited functionality
    * You can only PUSH to add a new element to the top of the Stack
    * You can POP to remove the element from the top of the stack
    * And you can peep at the top element without POPPING it off
    * The biggest take away for a STACK is it is LIFO(Last In, First Out)

 PSEDUOCODE EXAMPLE:
    * stack.push(10) // stack is now [10]
    * stack.push(3)  // stack is now [10, 3]
    * stack.push(57) // stack is now [10, 3, 57]
    * stack.pop()    // returns 54 and the stack is now [10, 3]
 */

//A STACK in Swift is easy.  We just write a wrapper around an array that lets us push, pop, and peek

public struct Stack<T> {
    fileprivate var array = [T]()
    
    public var isEmpty: Bool {
        return array.isEmpty
    }
    
    public var count: Int {
      return array.count
    }

    public mutating func push(_ element: T) {
      array.append(element)
    }

    public mutating func pop() -> T? {
      return array.popLast()
    }

    public var top: T? {
      return array.last
    }
}

/*
 NOTE:
    * When we push something it goes to the end of the stack. This keeps it O(1).
        otherwise if we try and put it at the beginning it is O(n) because we would then have to shift
 */
