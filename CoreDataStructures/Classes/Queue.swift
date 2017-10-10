//
//  Queue.swift
//  CoreDataStructures
//
//  Created by Michael Cordero on 10/1/17.
//

import Foundation

open class Queue<T> {
    
    // MARK: - Properties
    private var table: [T] = [T]()
    var size: Int {get{return table.count}}     //computed property
    
    // MARK: - Constructor(s)
    
    /**
     Creates empty queue with no values.
     */
    public init () {
    }
    
    /**
     Creates queue; initializing head to the specified value.
     
     - Parameters:
         - head: specified value.
     */
    public init (head: T) {
        table.append(head)
    }
    
    // MARK: - Public API
    
    /**
     Adds a new value to the end of the Queue.
     
     - Parameters:
         - value: The value to be added.
     - Returns: Void
     */
    public func add(_ value: T) -> Void {
        table += [value]
    }
    
    /**
     Removes and returns the value at the head of the queue.

     - Returns: Value
     */
    public func remove() -> T? {
        return table.remove(at: 0)
    }
    
    /**
     Re-initializes the queue to an empty queue.
     
     - Returns: Void
     */
    public func clear() -> Void {
        table = [T]()
    }
    
    /**
     Returns the head of the queue without removing.
     
     - Returns: optional value at the head of the queue.
     */
    public func element() -> T? {
        return table[0]
    }
    
    /**
     Returns all of the values stored in the queue.
     
     - Returns: all values.
     */
    public func values() -> [T] {
        return table
    }
}
