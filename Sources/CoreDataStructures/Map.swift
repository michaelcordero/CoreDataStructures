
//
//  Map.swift
//  CoreDataStructures
//
//  Created by Michael Cordero on 1/2/21.
//
import Foundation


protocol Map {
    associatedtype K : Hashable    // key
    associatedtype V    // value
    
    /*
     Core Functionality
     */
    func get(key: K) -> V?
    func put(key: K, value: V) -> V? // returns previous value, if any
    func remove(key: K) -> V?
    func isEmpty() -> Bool
    func size() -> Int
    
    /*
     Optional Functionality
     */
    func clear() -> Void
    func containsKey(key: K) -> Bool
    func containsValue(value: V) -> Bool
    func keySet() -> [K]
    func values() -> [V]
    func entrySet() -> [K:V]
}
