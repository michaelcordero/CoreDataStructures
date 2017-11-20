//
//  BinarySearchTree.swift
//  CoreDataStructures
//
//  Created by Michael Cordero on 10/1/17.
//

import Foundation

/**
 Binary Search Tree
 
 General purpose implementation of the Binary Search Tree invented by: P.F. Windley, A.D. Booth, A.J.T. Colin, and T.N. Hibbard
 Usages: Hierarchial data structure.
 Types: This implementation may contain only one type of values.
 
 Binary search trees keep their keys in sorted order, so that lookup and other operations can use the principle of binary search:
 when looking for a key in a tree (or a place to insert a new key), they traverse the tree from root to leaf, making comparisons
 to keys stored in the nodes of the tree and deciding, based on the comparison, to continue searching in the left or right subtrees.
 On average, this means that each comparison allows the operations to skip about half of the tree, so that each lookup, insertion
 or deletion takes time proportional to the logarithm of the number of items stored in the tree. This is much better than the linear
 time required to find items by key in an (unsorted) array, but slower than the corresponding operations on hash tables.
 [Wikipedia](https://en.wikipedia.org/wiki/Binary_search_tree)
 */
open class BinarySearchTree<T: Comparable> {
    
    // MARK: - Properties
    private var table: [T] = [T]() {didSet {size = table.count}}
    var root: Node<T>? = Node<T>() {didSet {resetRoot((root?.value)!)}}
    var size: Int
    
    // MARK: - Constructor(s)
    
    /**
     Creates an empty BinarySearchTree.
     */
    public init() {
        size = 0
    }
    
    /**
     Creates a BinarySearchTree, initializing the root node value, to the specified value.
     The BinarySearchTree may only contain values of the same type.
     */
    public init(rootNodeValue: T){
        root = Node(value: rootNodeValue)
        table.append((root?.value!)!)
        size = 1
    }
    
    // MARK: - Node Class
    
    /**
     Inner node class that lets the Binary Search Tree perform it's operations.
     Each value stored within the Binary Search Tree is subsequently stored in a node.
     The nodes hold references to sibling nodes, and parent node as well.
     */
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
    
    /**
     Custom error enum to notify users what went wrong.
     
     */
    enum NodeError: Error {
        case PreExistingValue
        case InvalidNodeException
        case RootNilException
    }
    
    // MARK: - Private
    
    /**
     Recursively searches the current BinarySearchTree for the specified value.
     
     - Parameters:
         - indexNode: represents the currently indexed node when searching. public methods pass in the root node as the starting point.
         - value: the value to be searched for
     - Returns: optional node if value is stored within the Binary Search Tree, nil if not.
     */
    private func search<T>(indexNode: Node<T>?, value: T) -> Node<T>? {
        
        if(indexNode == nil){
            return nil
        }
        if(indexNode?.value! == value){
            return indexNode
        }
        if(value < (indexNode?.value!)!) {
            return search(indexNode: indexNode?.left, value: value)
        } else if(value > (indexNode?.value!)!){
            return search(indexNode: indexNode?.right, value: value)
        }
        return nil
    }
    
    /**
     Recursively searches the current BinarySearchTree for the specified value. If found it is removed from the BinarySearchTree, and returned to the caller.
     
     - Parameters:
         - indexNode: represents the currently indexed node when searching. public methods pass in the root node as the starting point.
         - value: the value to be searched for and removed.
     - Returns: optional node if value is stored within the Binary Search Tree, nil if not.
     */
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
    
    /**
     Recursively searches the current BinarySearchTree for the next available leaf, closest to it's comparable value.
     
     - Parameters:
         - presentNode: represents the currently indexed node when searching. public methods pass in the root node as the starting point.
         - value: The value to be searched for.
     - Returns: Void
     */
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
    
    /**
     Ensures old values are retained. Inserting root first.
     
     - Parameters:
         - rootValue: new root value
     - Returns: Void
     */
    private func resetRoot(_ rootValue: T) -> Void{
        if !table.isEmpty {
            let oldValues: [T] = table.filter({$0 != rootValue})
            table = [T]()
            table.append(rootValue)
            oldValues.forEach({try! put($0)})
        } else {
            table.append(rootValue)
        }
    }
    
    /**
     Recursively searches the current BinarySearchTree node containing the highest comparable value.
     
     - Parameters:
         - indexNode: represents the currently indexed node when searching. public methods pass in the root node as the starting point.
     - Returns: optional node
     */
    private func maximum(_ indexNode: Node<T>) -> Node<T>? {
        return indexNode.right == nil ? indexNode : maximum(indexNode.right!)
    }
    
    /**
     Recursively searches the current BinarySearchTree node containing the lowest comparable value.
     
     - Parameters:
         - indexNode: represents the currently indexed node when searching. public methods pass in the root node as the starting point.
     - Returns: optional node
     */
    private func minimum(_ presentNode: Node<T>) -> Node<T>? {
        return presentNode.left == nil ? presentNode : minimum(presentNode.left!)
    }
    
    /**
     Recursively searches both left and right sides of binary search tree for maximum edges.
     
     - Parameters:
         - indexNode: represents the currently indexed node.
     - Returns: Int
     */
    private func height(_ indexNode: Node<T>?) -> Int {
        if indexNode?.value == nil {
            return 0
        }
        else {
            return Swift.max(height(indexNode?.left) , height(indexNode?.right)) + 1
        }
    }
    
    /**
     Calculates the depth of a node, which is the distance to the root.
     
     - Parameters:
         - indexNode: represents the currently indexed node.
     - Returns: Int
     */
    private func depth(_ indexNode: Node<T>?, _ edges: inout Int) -> Int{
        if indexNode?.parent == nil {
            return edges
        }  else {
            edges += 1
            return depth(indexNode?.parent!, &edges)
        }
    }
    
    // MARK: - Public API
    
    /**
     Searches for the passed in value, if present returns that node.
     
     - Parameters:
         - value: The value to be searched for.
     - Returns: optional node with specified value.
     */
    public func get(_ value: T) -> Node<T>?{
        return search(indexNode: root, value: value)
    }
    
    /**
     Places a new node with specified value into the current BinarySearchTree.
     
     - Parameters:
         - value: The value of the new node.
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
     
     - Parameters:
         - value: The value of the node to be removed.
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
    
    /**
     Finds the height of the tree, which is the root's distance to the lowest leaf.
     
     - Returns: Int
     */
    public func height() -> Int {
        return height(root!)
    }
    
    /**
     Finds the height of a given node, which is the node's distance to the lowest leaf.
     
     - Parameters: the node to be searched for and queried for height.
     - Returns: Int
     */
    public func nodeheight(_ value: T) -> Int {
        return height(self.get(value))
    }
    
    /**
     Finds the depth of a node, which is the distance to the root.
     
     - Parameters: the node to be queried for depth.
     - Returns: Int
     */
    public func depth(_ value: T) -> Int {
        var edges: Int = 0
        return depth(self.get(value), &edges )
    }
    
    /**
     The purpose of this function is to restore the BST to O(log n) status.
     The definition of balanced is: The heights of the two child subtrees of any node differ by at most one.
     [Wikipedia](https://en.wikipedia.org/wiki/AVL_tree)
     */
    public func balance() -> Void {
        var value = Float(table.count / 2)
        value.round(.up)
        let index = Int(value)
        table.sort()
        root = Node(value: table[index])
    }

}
