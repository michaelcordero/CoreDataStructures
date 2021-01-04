//
//  LinkedList.swift
//  CoreDataStructures
//
//  Created by Michael Cordero on 1/2/21.
//
import Foundation

open class LinkedList<T: Equatable> : List {
    
    // MARK: - Properties
    private var head: Node<T>?
    private var tail: Node<T>?
    private var count: Int
    
    // MARK: - Constructors
    public init() {
        count = 0
    }
    public init(_ first: T ) {
        head = LinkedList<T>.Node(item: first)
        count = 1
    }
    
    public init(_ first: T, _ last: T) {
        head = LinkedList<T>.Node(item: first)
        tail = LinkedList<T>.Node(item: last)
        head?.next = tail
        tail?.previous = head
        count = 2
    }
    
    // MARK: - Node Inner Class
    private class Node<T> {
        var value: T?
        var previous: Node<T>?
        var next: Node<T>?
        
        // Head Constructor
        public init(item: T) {
            previous = nil
            next = nil
            value = item
        }
        
        public init(predecessor: Node<T>?, successor: Node<T>?, item: T){
            previous = predecessor
            next = successor
            value = item
        }
    }
    
    // MARK: - Private Implementations
    
    private func addAll( collection: Array<T> ) {
        // to be finished later
//        for i in 0..<ar.count {
//            if i == 0 {
//                self.head = Node(item: ar[i])
//            }
//        }
    }
    
    private func linkFirst(_ item: T) -> Void {
        
    }
    
    private func linkLast(_ item: T) -> Bool {
        // initialize head if it doesn't exist already
        let current_last_node: Node<T>? = tail
        let new_node: Node<T> = Node(predecessor: current_last_node, successor: nil, item: item)
        tail = new_node
        if current_last_node == nil {
            head = new_node
        } else {
            current_last_node?.next = new_node
        }
        count += 1
        return true
    }
    
    private func linkBefore(_ item: T, prev: Node<T> ) -> Void {
        
    }
    
    //    private func unlinkFirst(first: Node<T> ) -> T {
    //
    //    }
    //
    //    private func unlinkLast(last: Node<T> ) -> T {
    //
    //    }
    //
    private func unlink(node: Node<T> ) -> T? {
        if let deleted: Node<T> = find( node.value! ) {
            // link up previous
            if let preceding: Node<T> = deleted.previous {
                preceding.next = deleted.next
            }
            // link up tail
            if let succeeding: Node<T> = deleted.next {
                succeeding.previous = deleted.previous
            }
            // returned detached
            return deleted.value
        } else {
            return nil
        }
    }
    
    private func getFirst() -> Node<T>? {
        return head
    }
    
    private func getLast() -> Node<T>? {
        return tail
    }
    
    /**
     - Returns: The specified node if present
     - Complexity: O(n/2)
    */
    private func find(_ index: Int ) -> Node<T> {
        // start at the beggining
        if index < ( count >> 1 ) {     // dividing number of elements (count) by 2 which yields the middle value
            var position: Int = 0
            var current: Node<T> = head!
            while(position < index){
                current = current.next ?? current
                position += 1
            }
            return current
        } else {
            // start at the end and work way backwards
            var position: Int = count - 1
            var current: Node<T> = tail!
            while(position > index){
                current = current.previous ?? current
                position -= 1
            }
            return current
        }
    }
    
    private func find(_ element: T) -> Node<T>? {
        var current: Node<T> = head!
        var position: Int = 1
        while position <= count {
            if current.value == element {
                return current
            } else {
                guard current.next != nil else {
                    return nil // not found
                }
                current = current.next!
                position += 1
            }
        }
        return nil
    }
    
    private func isValidIndex(_ index: Int ) -> Bool {
        return index >= 0 && index <= count
    }
    
    // MARK: - API
    public func size() -> Int {
        var count: Int = 0
        guard var current: Node<T> = head else { return count }
        while current.next != nil {
            count += 1
            current = current.next!
        }
        return count
    }
    
    public func add(_ element: T) -> Bool {
        return linkLast( element )
    }
    
    public func remove(_ element: T) -> T? {
        if let node: Node<T> = find( element ) {
            return unlink(node: node)
        }
        return nil
    }
    
    public func get(_ index: Int) -> T? {
        return isValidIndex( index ) ? find( index ).value : nil
    }
    
    public func set(_ index: Int, value: T) -> T? {
        if isValidIndex( index ) {
            let node: Node<T> = find( index )
            let old_value = node.value
            node.value = value
            return old_value
        } else {
            return nil
        }
    }
    
    public func all() -> [T?] {
        var allValues: [T?] = [T?]()
        var current: Node<T>? = head ?? nil
        if current == nil { return allValues }
        repeat {
            allValues.append(current!.value)
            current = current!.next ?? nil
        } while current != nil
        return allValues
    }
    
    public func contains(_ element: T) -> Bool {
        return find( element ) != nil
    }
    
    public func indexOf(_ element: T) -> Int? {
        return Int(0)
    }
    
    public func clear() {
        head = nil
        tail = nil
    }
    
    public func sort(comparator: (T, T) throws -> Bool) {
        // add to array
        var ar: Array<T> = Array()
        guard var current: Node<T> = head else {
            return
        }
        repeat {
            if let item: T = current.value {
                ar.append( item )
            }
            if let next: Node<T> = current.next {
                current = next
            }
        } while current.next != nil
        // sort the array
        try! ar.sort(by: comparator)
        // wipe old data
        clear()
        // create a new LinkedList
        addAll(collection: ar)
    }
    
}
