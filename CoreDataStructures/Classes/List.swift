//
//  List.swift
//  CoreDataStructures
//
//  Created by Michael Cordero on 10/7/18.
//

import Foundation

protocol List {
    associatedtype T
    func size() -> Int
    func add(_ element: T) -> Bool // return true if element can be added
    func remove(_ element: T) -> T? // return the removed element
    func get(_ index: Int ) -> T?    // return the element at the specified index
    func set(_ index: Int, value: T) -> T?   // sets a new value at specified index, returns old value
    func all() -> [T?]      // return all the list's values in an array
    func contains(_ element: T) -> Bool
    func indexOf(_ element: T) -> Int?
    func clear() -> Void
    func sort( comparator: (T,T) throws -> Bool ) -> Void
}
