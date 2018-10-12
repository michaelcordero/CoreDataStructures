//
//  Tree.swift
//  CoreDataStructures
//
//  Created by Michael Cordero on 10/8/18.
//

import Foundation

protocol Tree {
    
    /*common operations*/
    associatedtype T : Comparable
    func get(_ value: T) -> Node<T>?
    func set(_ node: Node<T>, value: T) throws -> T?
    func put(_ value: T) throws -> Void
    func remove(_ value: T) throws -> Node<T>?
    func size() -> Int
    func isEmpty() -> Bool
    func root() -> Node<T>?
    func max() -> Node<T>?
    func min() -> Node<T>?
    func all() -> [Node<T>]
    func values() -> [T]
    
    /*algorithms*/
    func depth(_ value: T) -> Int
    func height(_ value: T) -> Int
    func preorder( operation: ( Node<T> ) -> Void ) -> Void
    func postorder( operation: ( Node<T> ) -> Void ) -> Void
    func inorder( operation: ( Node<T> ) -> Void ) -> Void
}

// MARK: - Error

/**
 Custom error enum to notify users what went wrong.
 
 */
enum TreeError: Error {
    case DuplicateValueError
    case InvalidNodeError
    case NilRootError
}

class Node<T: Comparable>: Equatable {
    var value: T?
    var left: Node<T>?
    var right: Node<T>?
    var parent: Node<T>?
    
    // MARK: - Node Constructor(s)
    public init() {
        self.value = nil
        self.left = nil
        self.right = nil
        self.parent = nil
    }
    
    public init(value: T?) {
        self.value = value
        self.left = nil
        self.right = nil
        self.parent = nil
    }
    public init(value: T?, left: Node<T>?, right: Node<T>?) {
        self.value = value
        self.left = left
        self.right = right
        self.parent = nil
    }
    
    public init(value: T?, left: Node<T>?, right: Node<T>?, parent: Node<T>?) {
        self.value = value
        self.left = left
        self.right = right
        self.parent = parent
    }
    
    // MARK: - Protocol Conformance
    static func == (lhs: Node<T>, rhs: Node<T>) -> Bool {
        return lhs.value == rhs.value && lhs.parent == rhs.parent && lhs.left == rhs.left && lhs.right == rhs.right
    }
    
    // MARK: - Public API
    func isParent() -> Bool { return left != nil || right != nil }
    func isChild() -> Bool { return parent != nil }
    func isRoot() -> Bool { return parent == nil }
    func isLeaf() -> Bool { return left == nil && right == nil }
}
