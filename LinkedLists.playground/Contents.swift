import UIKit

/*
 Linked List Notes:
    * A linked list is a sequence of items just like an array
    * But an array allocates a big block of memory to store the objects
    * A linked lists elements are totally separate objects in memory and are connected thru links
 
    * NODES:
        - The elements of a linked list
 
    * SINGLY LINKED LIST:
        - Each note has only has a pointer to the next node
        - node1->node2-node3
 
    * DOUBLY LINKED LIST:
        - Each node has a pointer to the next node AND the previous node
        +--------+    +--------+    +--------+    +--------+
        |        |--->|        |--->|        |--->|        |
        | node 0 |    | node 1 |    | node 2 |    | node 3 |
        |        |<---|        |<---|        |<---|        |
        +--------+    +--------+    +--------+    +--------+
 
    * HEAD and TAIL
        * We need to keep track of where the list begins.  This is usually done with a pointer called the HEAD.
        * We also need to keep track of where the list ends.  This is usually done with a pointer called the TAIL.
                 +--------+    +--------+    +--------+    +--------+
        head --->|        |--->|        |--->|        |--->|        |---> nil
                 | node 0 |    | node 1 |    | node 2 |    | node 3 |
         nil <---|        |<---|        |<---|        |<---|        |<--- tail
                 +--------+    +--------+    +--------+    +--------+
        * It is important to note that the "previous" node for the HEAD is nil.
        * Same respectivly for the TAIL.  The "next" node is nil.
 
    * Performance of Linked List:
        * Typical performance of a linked list is O(n)
        * Linked lists are generally slower than arrays but are more flexable.
        * Instead of trying to copy large chuncks of data around, you just have to move a few pointers
        * The reason it is O(n) is because you can not simply reference the 3rd node in the list for example. We have to start at the head.
        * But once you have the reference things like insert or delete are really quick.  ITS JUST FINDING THE NODE THAT IS SLOW!
        * That is why when dealing with inserting, we should do it at the head or tail. This is a O(1) operation.
        *
 */

//MARK: - LINKED LIST NODE
// Lets define a NODE
class LinkedListNode<T> {
    var value: T
    var next: LinkedListNode?
    // To avoid ownership cycles, we declair the previous pointer to be weak.
    // If we delete a node, there is a chance the node will be kept alive even after they are deleted.
    weak var previous: LinkedListNode?
    
    public init(value: T) {
        self.value = value
    }
}

//MARK: - LINKED LIST
// Lets build the LINKEDLIST
class LinkedList<T> {
    private var head: LinkedListNode<T>?
    
    public var isEmpty: Bool {
        return head == nil
    }
    
    public var first: LinkedListNode<T>? {
        return head
    }
    
    public var last: LinkedListNode<T>? {
      guard var node = head else {
        return nil
      }
      //Keeps looping until node.next is nil.
      while let next = node.next {
        node = next
      }
      return node
    }
    
    public func append(value: T) {
        let newNode = LinkedListNode<T>(value: value)
        if let lastNode = last {
            newNode.previous = lastNode
            lastNode.next = newNode
        } else {
            head = newNode
        }
    }
    
    
}

//MARK: - TESTING
let list = LinkedList<String>()
list.isEmpty //At this point should be True
list.first   //At this point should be nil
