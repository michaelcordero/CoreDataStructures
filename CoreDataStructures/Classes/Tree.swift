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
    func get(value: T) -> Node<T>?
    func put(value: T) -> Void
    func remove(value: T) -> Node<T>?
    func size() -> Int
    func isEmpty() -> Bool
    func root() -> Node<T>?
    
    /*algorithms*/
    func depth(_ value: T) -> Int
    func height(_ value: T) -> Int
    func preorder(node: Node<T>, operation: ( Node<T> ) -> Void ) -> Void
    func postorder(node: Node<T>, operation: ( Node<T> ) -> Void ) -> Void
    func inorder(node: Node<T>, operation: ( Node<T> ) -> Void ) -> Void
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
