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
    func isEmpty() -> Bool
    func all() -> [Node<T>]
    func values() -> [T]
    func all(_ order: TreeOrder ) -> [Node<T>]
    func values(_ order: TreeOrder ) -> [T]
    func contains(_ value: T) -> Bool
    
    /*computed properties*/
    var size: Int { get }
    var root: Node<T>? { get set }
    var max: Node<T>? { get }
    var min: Node<T>? { get }
    
    
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

/*OrderEnum*/
enum TreeOrder {
    case Preorder
    case Postorder
    case Inorder
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
       // return lhs.value == rhs.value && lhs.parent == rhs.parent && lhs.left == rhs.left && lhs.right == rhs.right
        if lhs.value == nil && rhs.value != nil {
            return false
        } else if rhs.value == nil && lhs.value != nil {
            return false
        }
        return lhs.value! == rhs.value!
    }
    
    static func > (lhs: Node<T>, rhs: Node<T>) -> Bool{
        return lhs.value! > rhs.value!
    }
    
    static func < (lhs: Node<T>, rhs: Node<T>) -> Bool {
        return lhs.value! < rhs.value!
    }
    
    // MARK: - Public API
    func isParent() -> Bool { return left != nil || right != nil }
    func isChild() -> Bool { return parent != nil }
    func isRoot() -> Bool { return parent == nil }
    func isLeaf() -> Bool { return left == nil && right == nil }
}

extension Node : CustomDebugStringConvertible {
    var debugDescription: String {
        var description: String = "Node[ Key:\(String(describing: self.value))"
        description += "Left: \(String(describing: self.left)), "
        description += "Right: \(String(describing: self.right)), "
        description += " ]"
        return description
    }
}
