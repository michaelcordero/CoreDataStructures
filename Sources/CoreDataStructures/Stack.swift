//
//  Stack.swift
//  
//
//  Created by Michael Cordero on 1/2/21.
//

import Foundation

open class Stack<T> {
    
    // MARK: - Properties
    private var table: [T] = [T]()
    var size: Int {get{return table.count}}     //computed property
    
    // MARK: - Constructor(s)
    
    /**
     Creates empty stack.
     */
    public init() {}
    
    /**
     Creates stack initializing top of the Stack<T> to the specified value.
     */
    public init(top: T) {
        table.append(top)
    }
    
    // MARK: - Public API
    
    
    /**
     Let's caller know if the stack is empty.
     
     - Returns: Bool value indicating whether the stack is empty or not.
     */
    public func empty() -> Bool {
        return table.isEmpty
    }
    
    /**
     Inserts specified value onto the top of the stack.
     
     - Parameter value: the value to be inserted.
     - Returns: Void
     */
    public func push(_ value: T) -> Void {
        let index: Int = empty() ? 0 : table.count
        table.insert(value, at: index)
    }
    
    /**
     Removes and returns the value at the top of the stack.
     
     - Returns: optional value
     */
    public func pop() -> T? {
        let value: T? = empty() ? nil : table.remove(at: table.count - 1)
        return value
    }
    
    /**
     Returns value at the top of the stack, but does not remove.
     
     - Returns: optional value
     */
    public func peek() -> T? {
        return table[table.count - 1]
    }
    
    /**
     Provides a safe view of the values within the stack array.
     
     - Returns: all of the values stored within the stack.
     */
    public func values() -> [T] {
        return table
    }
    
}
