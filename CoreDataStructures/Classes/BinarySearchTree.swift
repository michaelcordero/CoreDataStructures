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
open class BinarySearchTree<T: Comparable> : BinaryTree {
    

    // MARK: - Properties
    private var table: [T] = [T]() {didSet {count = table.count}}
    var root_node: Node<T>? = Node<T>() {didSet {resetRoot((root_node?.value)!)}}
    var count: Int
    
    // MARK: - Constructor(s)
    
    /**
     Creates an empty BinarySearchTree.
     */
    public init() {
        count = 0
    }
    
    /**
     Creates a BinarySearchTree, initializing the root node value, to the specified value.
     The BinarySearchTree may only contain values of the same type.
     */
    public init(rootNodeValue: T){
        root_node = Node(value: rootNodeValue)
        table.append((root_node?.value!)!)
        count = 1
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
            oldValues.forEach({ try! put($0)})
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
    private func depth(_ indexNode: Node<T>?, _ edges: inout Int) -> Int {
        if indexNode?.parent == nil {
            return edges
        }  else {
            edges += 1
            return depth(indexNode?.parent!, &edges)
        }
    }
    
   
    ///  Preorder traversal of a tree, is when the root of the tree is visited first
    ///  and then the subtrees rooted at its children are traversed recursively.
    ///
    /// - Parameters:
    ///   - index_node: represents the currently indexed node.
    ///   - operation: a function that you want to apply to the node.
    private func preorder(_ index_node: Node<T>, operation: (Node<T>) -> Void  ) -> Void {
        operation(index_node)
        
        if index_node.left != nil {
            preorder(index_node.left!, operation: operation)
        }
        
        if index_node.right != nil {
            preorder(index_node.right!, operation: operation)
        }
    }
    
    /// Postorder traversal recursively traverses the subtrees rooted at the children of the root first,
    /// then it visits the root.
    ///
    /// - Parameters:
    ///   - index_node: represents the currently indexed node.
    ///   - operation: a function that you want to apply to the node.
    private func postorder(_ index_node: Node<T>, operation: (Node<T>) -> Void  ) -> Void {
        if index_node.left != nil {
            postorder(index_node.left!, operation: operation)
        }
        
        if index_node.right != nil {
            postorder(index_node.right!, operation: operation)
        }
        
        operation(index_node)       //postorder
    }
    
    
    /// Inorder traversal visits the node between recursive traversals of it's left and right subtrees.
    ///
    /// - Parameters:
    ///   - index_node: represents the currently indexed node.
    ///   - operation: a function that you want to apply to the node.
    private func inorder(_ index_node: Node<T>, operation: (Node<T>) -> Void  ) -> Void {
        if index_node.left != nil {
            inorder(index_node.left!, operation: operation)
        }
        
        operation(index_node)       // inorder
        
        if index_node.right != nil {
            inorder(index_node.right!, operation: operation)
        }
    }
    
    // MARK: - Public API
    func children(parent: Node<T>) -> (left: Node<T>?, right: Node<T>?) {
        return ( parent.left, parent.right )
    }
    
    func sibling(node: Node<T>) -> Node<T>? {
        guard let parent: Node<T> = self.get(node.value!)?.parent else { return nil }
        return node == parent.left ? parent.right : parent.left
    }
    
    func get(_ value: T) -> Node<T>? {
        return search(indexNode: root_node, value: value)
    }
    
    func set(_ node: Node<T>, value: T) throws -> T? {
        if let _: T = self.get(value)?.value { throw TreeError.DuplicateValueError }
        guard let operand: Node<T> = self.get( node.value! ) else { return nil }
        let previous_value: T? = operand.value
        operand.value = value // new value
        return previous_value
        
    }
    
    func put(_ value: T) throws -> Void {
        if root_node == nil || root_node?.value == nil { throw TreeError.NilRootError }
        if table.contains(value) {throw TreeError.DuplicateValueError}
        let node: Node<T> = Node(value: value)
        insert(node: node, presentNode: root_node)
    }
    
    func remove(_ value: T) throws -> Node<T>? {
        guard let node: Node<T> = delete(indexNode: root_node, value: value) else {
            throw TreeError.InvalidNodeError
        }
        return node
    }
    
    func size() -> Int {
        return count
    }
    
    func isEmpty() -> Bool {
        return count == 0
    }
    
    func root() -> Node<T>? {
        return root_node
    }
    
    func max() -> Node<T>? {
        return maximum(root_node!)
    }
    
    func min() -> Node<T>? {
        return minimum(root_node!)
    }
    
    func all() -> [Node<T>] {
        return table.map( { Node(value: $0) } )
    }
    
    func values() -> [T] {
        return table
    }
    
    func depth(_ value: T) -> Int {
        var edges: Int = 0
        return depth(self.get(value), &edges )
    }
    
    func height(_ value: T) -> Int {
        return self.height( self.get(value) )
    }
    
    func preorder( operation: (Node<T>) -> Void ) {
        preorder(root_node!, operation: operation)
    }
    
    func postorder( operation: (Node<T>) -> Void ) {
        postorder(root_node!, operation: operation)
    }
    
    func inorder( operation: (Node<T>) -> Void ) {
        inorder(root_node!, operation: operation)
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
        root_node = Node(value: table[index])
    }
}
