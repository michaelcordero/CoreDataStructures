//
//  Stack.swift
//  CoreDataStructures
//
//  Created by Michael Cordero on 10/1/17.
//

import Foundation

open class Stack<T> {
    
    // MARK: - Properties
    private var table: [T] = [T]()
    var size: Int {get{return table.count}}     //computed property
    
    // MARK: - Constructor(s)
    public init() {}
    
    public init(top: T) {
        table.append(top)
    }
    
    // MARK: - Public API 
    
    public func empty() -> Bool {
        return table.isEmpty
    }
    
    public func push(_ value: T) -> Void {
        let index: Int = empty() ? 0 : table.count
        table.insert(value, at: index)
    }
    
    public func pop() -> T? {
        let value: T? = empty() ? nil : table.remove(at: table.count - 1)
        return value
    }
    
    public func peek() -> T? {
        return table[table.count - 1]
    }
    
    public func values() -> [T] {
        return table
    }
    
}
