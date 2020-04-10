import Foundation

/*
 HASHTABLES:
    * Hash tables allow us to retrieve elements by a "key".
    * Interesting note is Swifts built-in DICTIONARY types keys are required to conform to the HASHABLE protocol. Internally it uses a hash table.
 
 HOW THEY WORK:
    * A hash table is nothing more than an array.
    * It uses the key to calculate the index where the element will end up.
 
PSEUDOCODE EXAMPLE:
    hashTable["firstName"] = "Steve"
    hashTable["hobbies"] = "Programming Swift"

    The hashTable array:
    +--------------+
    | 0:           |
    +--------------+
    | 1: hobbies   |---> Programming Swift
    +--------------+
    | 2:           |
    +--------------+
    | 3: firstName |---> Steve
    +--------------+
    | 4:           |
    +--------------+
 
    * The interesting thing is how the index is caluclated from the key.
    * It uses the hashValue from the key. This explains why the key needs to be hashable.
    * When you write "firstName".hashValue, it returns a big integer: -4799450059917011053.
    * The hashValue number is obviously too large to use as an index.
    * First we make the number positive and then take the modulous of that number with the array size.
    * Our array has size 5, so the index for the "firstName" key becomes abs(-4799450059917011053) % 5 = 3.
    * Using hashes in this manner is what makes the dictionary efficient
    * All these operations take a constant amount of time, so inserting, retrieving, and removing are all O(1).
 
 COLLISIONS:
    * There is a problem with hash tables. Since we take the modulo from the hashValue with the array size, there is a chance we could have the same index for a different element. This is called a COLLISION.
    * One of the ways to reduce the chance of a collision is to have a larger array. But collisions are bound to happen.
    * A common way to handle collisions is chaining. The array will look as follows:
 
    buckets:
    +-----+
    |  0  |
    +-----+     +----------------------------+
    |  1  |---> | hobbies: Programming Swift |
    +-----+     +----------------------------+
    |  2  |
    +-----+     +------------------+     +----------------+
    |  3  |---> | firstName: Steve |---> | lastName: Jobs |
    +-----+     +------------------+     +----------------+
    |  4  |
    +-----+
 
    * With chaining keys/values are not stored directly in the array.  The array element is a LIST of key/value pairs.
    * Usually the array elements are reffered to as "BUCKETS" and the key/value pairs are the "CHAINS"
    * In the above example we have 5 buckets, and two of these buckets have chains. The other three buckets are empty.
    * It is important to note that the chain is not going to be in any particular order. Hence the name "bucket"
 */

public struct HashTable<Key: Hashable, Value> {
    private typealias Element = (key: Key, value: Value)
    private typealias Bucket = [Element]
    private var buckets: [Bucket]
    
    private(set) public var count = 0
    
    public var isEmpty: Bool { return count == 0 }
    
    public init(capacity: Int) {
        assert(capacity > 0)
        buckets = Array<Bucket>(repeatElement([], count: capacity))
    }
    
    private func index(forKey key: Key) -> Int {  //This calculates the index for a new Element
      return abs(key.hashValue % buckets.count)   //We take the key.hashValue and get the mod from the array capacity
    }
    
    public subscript(key: Key) -> Value? {     //There are 4 main things we do with hashtables:
      get {                                    //Insert a new element
        return value(forKey: key)              //Look up an element
        }                                      //Update an existing element
      set {                                    //Remove an element
//        if let value = newValue {
//            updateValue(value, forKey: key)    //We can do all of these with a subscript function
//        } else {
//          removeValue(forKey: key)
//        }
      }
    }
    
    public func value(forKey key: Key) -> Value? {   //This retrieves the value from the hashTable
      let index = self.index(forKey: key)
      for element in buckets[index] {
        if element.key == key {
          return element.value
        }
      }
      return nil  // key not in hash table
    }
    
    public mutating func updateValue(_ value: Value, forKey key: Key) -> Value? { //Updates a value
      let index = self.index(forKey: key)               //First we convert the key into an index
      
      // Do we already have this key in the bucket?
      for (i, element) in buckets[index].enumerated() { //Then we loop thru the chain
        if element.key == key {                         //If we find the key
          let oldValue = element.value                  //We must update the value
          buckets[index][i].value = value               //It is important to note that we must keep our hashTables
          return oldValue                               //big enough so that our chain isnt too long causing us to
        }                                               //spend a lot of time in the for in loops.
      }
      
      // This key isn't in the bucket yet; add it to the chain.
      buckets[index].append((key: key, value: value))
      count += 1
      return nil
    }
    
    public mutating func removeValue(forKey key: Key) -> Value? {
      let index = self.index(forKey: key)

      // Find the element in the bucket's chain and remove it.
      for (i, element) in buckets[index].enumerated() {
        if element.key == key {
          buckets[index].remove(at: i)
          count -= 1
          return element.value
        }
      }
      return nil  // key not in hash table
    }
}

var hashTable = HashTable<String, String>(capacity: 5)
hashTable["firstName"] = "Steve"   // insert
let x = hashTable["firstName"]     // lookup
hashTable["firstName"] = "Tim"     // update
hashTable["firstName"] = nil       // delete


