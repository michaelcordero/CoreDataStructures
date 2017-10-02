//
//  BinarySearchTree.swift
//  CoreDataStructures
//
//  Created by Michael Cordero on 10/1/17.
//

import Foundation

open class BinarySearchTree<T: Comparable> {
    
    // MARK: - Properties
    private var table: [T] = [T]() {didSet {size = table.count}}  //updates size property whenever element is added
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
        case PreExistingValue// = "Node with value: already exists within BinarySearchTree!"
        case InvalidNodeException// = "Node with value does not exist!"
        case RootNilException //= "Root must be set before any other nodes are added!"
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
            indexNode?.left?.parent = parent    //setting left & right children's parent to removal node's parent :(
            indexNode?.right?.parent = parent
            let ix: Int = table.index(where: {$0 as! T == value})!   //This means that duplicate values should not be allowed!!
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
    
    private func append(node: Node<T>, presentNode: Node<T>?) -> Void {
        if node.value! < (presentNode?.value!)! {
            if(presentNode?.left == nil){
                presentNode?.left = node
                node.parent = presentNode
                table.append(node.value!)
            } else {
                append(node: node, presentNode: presentNode?.left)
            }
        } else if node.value! > (presentNode?.value!)! {
            if(presentNode?.right == nil) {
                presentNode?.right = node
                node.parent = presentNode
                table.append(node.value!)
            } else {
                append(node: node, presentNode: presentNode?.right)
            }
        }
    }
    
    /* Ensures old values are retained. */
    private func resetRoot(_ rootValue: T) {
        if !table.isEmpty {
            let copyTable: [T] = table
            table = [T]()
            table.append(rootValue)
            table.append(contentsOf: copyTable)
        } else {
            table.append(rootValue)
        }
    }
    
    // MARK: - Public API
    
    public func get(_ value: T) -> Node<T>?{
        return search(indexNode: root, value: value)
    }
    
    public func insert(_ value: T) throws -> Void{
        if root == nil || root?.value == nil {throw NodeError.RootNilException}
        if table.contains(value) {throw NodeError.PreExistingValue}
        let node: Node<T> = Node(value: value)
        append(node: node, presentNode: root)
    }
    
    public func remove(_ value: T) throws -> Node<T>?{
        guard let node: Node<T> = delete(indexNode: root, value: value) else {
            throw NodeError.InvalidNodeException
        }
        return node
    }
    
    public func values() -> [T] {
        table = table.sorted()
        return self.table
    }
    
}
