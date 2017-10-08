//
//  BinarySearchTree.swift
//  CoreDataStructures
//
//  Created by Michael Cordero on 10/1/17.
//

import Foundation

open class BinarySearchTree<T: Comparable> {
    
    // MARK: - Properties
    private var table: [T] = [T]() {didSet {size = table.count}}
    var root: Node<T>? = Node<T>() {didSet {resetRoot((root?.value)!)}}
    var size: Int
    
    // MARK: - Constructor(s)
    public init() {
        size = 0
    }
    
    public init(rootNodeValue: T){
        root = Node(value: rootNodeValue)
        table.append((root?.value!)!)
        size = 1
    }
    
    // MARK: - Node Class
    open class Node<T: Comparable>:Equatable  {
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
        public static func == <T>(lhs: Node<T>, rhs: Node<T>) -> Bool {
            return lhs.value == rhs.value
        }
        
    }
    
    // MARK: - Error
    enum NodeError: Error {
        case PreExistingValue
        case InvalidNodeException
        case RootNilException
    }
    
    // MARK: - Private
    private func search<T,U>(indexNode: Node<T>?, value: U) -> Node<T>? {
        let compare: T? = value as? T
        
        if(indexNode == nil){
            return nil
        }
        if(indexNode?.value! == compare!){
            return indexNode
        }
        if(compare! < (indexNode?.value!)!) {
            return search(indexNode: indexNode?.left, value: value)
        } else if(compare! > (indexNode?.value!)!){
            return search(indexNode: indexNode?.right, value: value)
        }
        return nil
    }
    
    private func delete<T>(indexNode: Node<T>?, value: T) -> Node<T>?{
        if(indexNode == nil){
            return nil
        }
        if(indexNode?.value! == value){
            let parent: Node<T>? = indexNode?.parent!
            indexNode?.left?.parent = parent    
            indexNode?.right?.parent = parent
            let ix: Int = table.index(where: {$0 as! T == value})!
            table.remove(at: ix)
            return indexNode
        }
        if(value < (indexNode?.value!)!) {
            return delete(indexNode: indexNode?.left, value: value)
        } else if(value > (indexNode?.value!)!){
            return delete(indexNode: indexNode?.right, value: value)
        }
        return nil
    }
    
    private func insert(node: Node<T>, presentNode: Node<T>?) -> Void {
        if node.value! < (presentNode?.value!)! {
            if(presentNode?.left == nil){
                presentNode?.left = node
                node.parent = presentNode
                table.append(node.value!)
            } else {
                insert(node: node, presentNode: presentNode?.left)
            }
        } else if node.value! > (presentNode?.value!)! {
            if(presentNode?.right == nil) {
                presentNode?.right = node
                node.parent = presentNode
                table.append(node.value!)
            } else {
                insert(node: node, presentNode: presentNode?.right)
            }
        }
    }
    
    /* Ensures old values are retained. Inserting root first. */
    private func resetRoot(_ rootValue: T) {
        if !table.isEmpty {
            let oldValues: [T] = table
            table = [T]()
            table.append(rootValue)
            oldValues.forEach({try! put($0)})
        } else {
            table.append(rootValue)
        }
    }
    
    private func maximum(_ presentNode: Node<T>) -> Node<T>? {
        return presentNode.right == nil ? presentNode : maximum(presentNode.right!)
    }
    
    private func minimum(_ presentNode: Node<T>) -> Node<T>? {
        return presentNode.left == nil ? presentNode : minimum(presentNode.left!)
    }
    
    // MARK: - Public API
    
    /**
     Searches for the passed in value, if present returns that node.
     
     - Parameter value: The value to be searched for.
     - Returns: optional node with specified value.
     */
    public func get(_ value: T) -> Node<T>?{
        return search(indexNode: root, value: value)
    }
    
    /**
     Places a new node with specified value into the current BinarySearchTree.
     
     - Parameter value: The value of the new node.
     - Throws:
         - RootNilException: if the root node's value is undefined.
         - PreExistingValue: if there is already a node with the same value.
     
     */
    public func put(_ value: T) throws -> Void{
        if root == nil || root?.value == nil {throw NodeError.RootNilException}
        if table.contains(value) {throw NodeError.PreExistingValue}
        let node: Node<T> = Node(value: value)
        insert(node: node, presentNode: root)
    }
    
    /**
     Removes node with specified value from the current BinarySearchTree.
     
     - Parameter value: The value of the node to be removed.
     - Returns: optional node
     - Throws: InvalidNodeException if node with specified value is undeclared within BinarySearchTree.
     */
    public func remove(_ value: T) throws -> Node<T>?{
        guard let node: Node<T> = delete(indexNode: root, value: value) else {
            throw NodeError.InvalidNodeException
        }
        return node
    }
    
    /**
     Provides quick access to the immutable array containing all of the values within the BinarySearchTree.
     
     - Returns: Array containing all of the values
     */
    public func values() -> [T] {
        return self.table
    }
    
    /**
     Finds the node with the highest comparable value within the BinarySearchTree.
     
     - Returns: optional node
     */
    public func max() -> Node<T>? {
        return maximum(root!)!
    }
    
    /**
     Finds the node with the lowest comparable value within the BinarySearchTree.
     
     - Returns: optional node
     */
    public func min() -> Node<T>? {
        return minimum(root!)!
    }
    
    
}
