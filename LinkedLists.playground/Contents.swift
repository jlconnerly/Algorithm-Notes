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
    // Next is a reference to the next node
    var next: LinkedListNode?
    //previous is a reference to the previous node
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
        //Since this is a Linked List we have to start at the head to reach the last node
        //If the node is nil at the head, our Linked List is empty
        guard var node = head else {
            return nil
        }
        //Keeps looping until node.next is nil to retrive the reference for last object
        while let next = node.next {
            node = next
        }
        return node
    }
    
    //Appends a node to the end of the Linked List
    public func append(value: T) {
        let newNode = LinkedListNode<T>(value: value) //First creates new node object
        if let lastNode = last {                      //The askes for the last node using the last property
            newNode.previous = lastNode               //If last has an object we connect them HERE
            lastNode.next = newNode                   //And here
        } else {                                      //Otherwise if ther is no last object, we know our list is empty so we...
            head = newNode                            //Create the head
        }
    }
    
    //This computed property allows us to count how many nodes we have in our list
    public var count: Int {
        guard var node = head else {   //Check to make sure the head isn't nil indicating we have an empty list
            return 0                   //Return zero for the count because the list is empty. NOTE: This executes only if HEAD is nil
        }
        var count = 1                  //At this point if HEAD is not nil then we have at least one node
        while let next = node.next {   //Checks to make sure the next node is not nil
            node = next                //If there is a next node we move to that node
            count += 1                 //Then increase our count
        }
        return count                   //Finally if the next node is nil then we have reached the TAIL and exit the while loop
    }
}

//MARK: - TESTING
// Lets test using Strings value types
let list = LinkedList<String>()
list.isEmpty //At this point should be True
list.first   //At this point should be nil

list.append(value: "Hello")
list.isEmpty                  //Should be false
list.append(value: "World")
list.first?.value             //"Hello"
list.last?.value              //"World"
/*
 At this point the visual representation of the list should look like this:
                 +---------+    +---------+
        head --->|         |--->|         |---> nil
                 | "Hello" |    | "World" |
         nil <---|         |<---|         |
                 +---------+    +---------+
 */

//How can we verify that this is what the list looks like?
list.first?.previous        //Should be nil
list.first?.next?.value     //Should be "World"
list.last?.next             //Should be nil
list.last?.previous?.value  //SHould be "Hello"

