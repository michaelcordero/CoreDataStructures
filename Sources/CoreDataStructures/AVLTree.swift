//
//  AVLTree.swift
//  CoreDataStructures
//
//  Created by Michael Cordero on 1/2/21.
//

import Foundation



/// Height-Balance Property: for every internal node of Tree,
/// the heights of the children of said internal node differ
/// by at most 1.
/// source: Data Structures & Algorithms, 5th edition
/// by Michael T Goodrich & Roberto Tamassia.
/// Ch. 10, AVL Trees
/// AVLTrees inherit size, isEmpty and get from BST, but overrides put & remove
open class AVLTree<T: Comparable> : BinarySearchTree<T> {
    
    /// Node Class adds height property
     open class AVLNode<T: Comparable> : Node<T> {
        // MARK: - Properties
        var height: Int
        override init() {
            self.height = 0
            super.init()
        }
        override init(value: T?) {
            self.height = 0
            super.init(value: value)
        }
        override init(value: T?, left: Node<T>?, right: Node<T>?, parent: Node<T>?) {
            self.height = 0
            super.init(value: value, left: left, right: right, parent: parent)
            if left != nil {
                let left_child: AVLNode<T> = AVLNode(value: self.left?.value, left: self.left?.left, right: self.left?.right, parent: self.left?.parent)
                height = Swift.max(height, left_child.height )
                self.left = left_child
            }
            if right != nil {
                let right_child: AVLNode<T> = AVLNode(value: self.right?.value, left: self.right?.left, right: self.right?.right, parent: self.right?.parent)
                self.right = right
                height = Swift.max(height, 1 + right_child.height )
            }
        }
        
        init(_ node: Node<T>){
            self.height = 0
            super.init(value: node.value, left: node.left, right: node.right, parent: node.parent)
        }
    }
    
    override public func put(_ value: T) throws {
        try super.put(value)
        balance()
    }
    
    override public func remove(_ value: T) throws -> Node<T>? {
        let old_value: Node<T>? = try super.remove(value)
        balance()
        return old_value
    }
    
}



