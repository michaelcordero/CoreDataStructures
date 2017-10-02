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
    public init () {
    }
    
    public init (head: T) {
        table.append(head)
    }
    
    // MARK: - Public API
    public func add(_ value: T) -> Void {
        table += [value]
    }
    
    public func remove() -> T? {
        return table.remove(at: 0)
    }
    
    public func clear() -> Void {
        table = [T]()
    }
    
    public func element() -> T? {
        return table[0]
    }
    
    public func values() -> [T] {
        return table
    }
}
