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
    var size: Int
    var root: Node<T>? = Node<T>() {
        // This operation saves the old values before re-setting the root.
        // *Re-setting the root means you lose all nodes.
        willSet {
            self.old_values = self.values()
        }
        // This operation takes those old values and adds them back.
        didSet {
            old_values?.forEach({try! put($0)})
        }
    }
    var max: Node<T>? { get { return maximum(root!) } }
    var min: Node<T>? { get { return minimum(root!) } }
    private var old_values: [T]?    // internal use only!!
    
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
    public init(_ root_node_Value: T){
        root = Node(value: root_node_Value)
        size = 1
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
        if(indexNode?.value! == value){ //found the node to be deleted
            let parent: Node<T>? = indexNode?.parent!
            let left_child: Node<T>? = indexNode?.left
            let right_child: Node<T>? = indexNode?.right
            
            // re-attaching the appropriate child to the deleted node's parent
            // effectively un-attaching indexNode effectively deleting it from the
            // data structure.
            // this method assumes that the right child is inserted with a greater
            // value than the left sibling and the parent.
            if right_child?.value != nil {
                if indexNode == parent?.left {
                    parent?.left = right_child
                } else {
                    parent?.right = right_child
                }
            } else {
                if indexNode == parent?.right {
                    parent?.right = left_child
                } else {
                    parent?.left = left_child
                }
            }
            // end re-attachment.
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
                size += 1
            } else {
                insert(node: node, presentNode: presentNode?.left)
            }
        } else if node.value! > (presentNode?.value!)! {
            if(presentNode?.right == nil) {
                presentNode?.right = node
                node.parent = presentNode
                size += 1
            } else {
                insert(node: node, presentNode: presentNode?.right)
            }
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
    func family(parent: Node<T>?) -> (parent: Node<T>?, left: Node<T>?, right: Node<T>?) {
        return (parent!, parent!.left, parent!.right)
    }
    func children(parent: Node<T>) -> (left: Node<T>?, right: Node<T>?) {
        return ( parent.left, parent.right )
    }
    
    func sibling(node: Node<T>) -> Node<T>? {
        guard let parent: Node<T> = self.get(node.value!)?.parent else { return nil }
        return node == parent.left ? parent.right : parent.left
    }
    
    func get(_ value: T) -> Node<T>? {
        return search(indexNode: root, value: value)
    }
    
    func set(_ node: Node<T>, value: T) throws -> T? {
        if let _: T = self.get(value)?.value { throw TreeError.DuplicateValueError }
        guard let operand: Node<T> = self.get( node.value! ) else { return nil }
        let previous_value: T? = operand.value
        operand.value = value // new value
        return previous_value
        
    }
    
    func put(_ value: T) throws -> Void {
        if root == nil || root?.value == nil { root = Node(value: value); return }
        if self.get(value) != nil {throw TreeError.DuplicateValueError}
        let node: Node<T> = Node(value: value)
        insert(node: node, presentNode: root)
    }
    
    func remove(_ value: T) throws -> Node<T>? {
        guard let node: Node<T> = delete(indexNode: root, value: value) else {
            throw TreeError.InvalidNodeError
        }
        return node
    }
    
    func isEmpty() -> Bool {
        return size == 0
    }
    
    func all() -> [Node<T>] {
        var result: [Node<T>] = []
        preorder(operation: {result.append($0)})
        return result
    }
    
    func values() -> [T] {
        var result: [T] = []
        preorder(operation: {
            guard let value: T = $0.value else { return } //do not add to array
            result.append(value)
        })
        return result
    }
    
    func all(_ order: TreeOrder) -> [Node<T>] {
        var result: [Node<T>] = []
        switch order {
        case .Preorder: preorder(operation: {result.append($0)})
        case .Postorder: postorder(operation: {result.append($0)})
        case .Inorder: inorder(operation: {result.append($0)})
        }
        return result
    }
    
    func values(_ order: TreeOrder) -> [T] {
        var result: [T] = []
        switch order {
        case .Preorder: preorder(operation: {
            guard let value: T = $0.value else { return }
            result.append(value)
        })
        case .Postorder: postorder(operation: {
            guard let value: T = $0.value else { return }
            result.append(value)
        })
        case .Inorder: inorder(operation: {
            guard let value: T = $0.value else { return }
            result.append(value)
        })
        }
        return result
    }
    
    func contains(_ value: T) -> Bool {
        return self.get(value) != nil
    }
    
    func depth(_ value: T) -> Int {
        var edges: Int = 0
        return depth(self.get(value), &edges )
    }
    
    func height(_ value: T) -> Int {
        return self.height( self.get(value) )
    }
    
    func preorder( operation: (Node<T>) -> Void ) {
        preorder(root!, operation: operation)
    }
    
    func postorder( operation: (Node<T>) -> Void ) {
        postorder(root!, operation: operation)
    }
    
    func inorder( operation: (Node<T>) -> Void ) {
        inorder(root!, operation: operation)
    }
    
    /**
     The purpose of this function is to restore the BST to O(log n) status.
     The definition of balanced is: The heights of the two child subtrees of any node differ by at most one.
     This code is inspired by Data Structures & Algorithms, 5th edition. Goodrich & Tamassia.
     Ch. 10.2 pg. 451
     "The modification of a tree T caused by a "trinode restructuring operation is often called a
     rotation., because of the geometric way we can visualize it changes the tree."
     */
    
    func restructure(_ x: Node<T>) -> Void {
        let y: Node<T> = x.parent!  // parent
        let z: Node<T> = (x.parent?.parent!)! // grandparent
        
        
        // 1. let (a, b, c) be an inorder listing of the nodes xyz
        let a: Node<T> = z
        let b: Node<T> = y
        let c: Node<T> = x
        
        // Subtrees of the root's childrens (a,b,c) i.e. children's children
        let t0: (Node<T>?, Node<T>?, Node<T>?) = b.left != nil ? family(parent: b.left) : (b.left ?? nil, nil, nil)
        let t1: (Node<T>?, Node<T>?, Node<T>?) = c.left != nil ? family(parent: c.left! ) : (c.left ?? nil, nil, nil)
        let t2: (Node<T>?, Node<T>?, Node<T>?) = c.right != nil ? family(parent: c.right) : (c.right ?? nil, nil, nil)
        let t3: (Node<T>?, Node<T>?, Node<T>?) = a.right != nil ? family(parent: a.right) : (a.right ?? nil, nil, nil)

        // 2. replace the subtree rooted at a with a new subtree rooted at b
        // High Level swap
        if z == z.parent?.left {
            z.parent?.left = c
        } else {
            z.parent?.right = c
        }
        // T0 & T1 go to b. T0 already belongs to b (not necessary).
        // T1 originally belonged to c, so move is necessary.
        // High Level Swap
        c.left = b
        // High Level Swap
        b.left = t0.0
        // Low Level Swap
        b.left?.left = t0.1     // left child
        b.left?.right = t0.2    // right child
        b.right = t1.0          // parent
        b.right?.left = t1.1    // left child
        b.right?.right = t1.2  // right child
        
        
        // T2 & T3 goes to a
        // T2 orignally belonged to c, so move is necessary
        // T3 orignally belong to a, so move is (not necessary)
        // High Level Swap
        c.right = a
        // High Level Swap
        a.left = t2.0
        // Low Level Swap
        a.left?.left = t2.1
        a.left?.right = t2.2
        a.right = t3.0
        a.right?.left = t3.1
        a.right?.right = t3.2
        
    }
}
