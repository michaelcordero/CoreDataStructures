//
//  AVLTree.swift
//  CoreDataStructures
//
//  Created by Michael Cordero on 10/9/18.
//

import Foundation



/// Height-Balance Property: for every internal node of Tree,
/// the heights of the children of said internal node differ
/// by at most 1.
/// source: Data Structures & Algorithms, 5th edition
/// by Michael T Goodrich & Roberto Tamassia.
/// Ch. 10, AVL Trees
/// AVLTrees inherit size, isEmpty and get from BST, but overrides put & remove
class AVLTree<T: Comparable> : BinarySearchTree<T> {
    
    /// Node Class adds height property
     class AVLNode<T: Comparable> : Node<T> {
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
    
//    "The modification of a tree T caused by a "trinode restructuring operation is often called a
//    rotation., because of the geometric way we can visualize it changes the tree."
    
    private func rightRotate(_ node: AVLNode<T>){
        let x: AVLNode<T>? = node.left != nil ? AVLNode(node.left!) : nil
        let y: AVLNode<T>? = x!.right != nil ? AVLNode(node.right!) : nil
        
        // perform the rotation
        x!.right = node
        node.left = y
        
        // update heights
        node.height = Swift.max(height((node.left?.value!)!), height((node.right?.value!)!)) + 1
        x?.height = Swift.max(height((x?.left?.value)!), height((x?.right?.value)!))
        
    }
    
    private func leftRotate(_ node: AVLNode<T>){
        let x: AVLNode<T>? = node.right != nil ? AVLNode(node.right!) : nil
        let y: AVLNode<T>? = x?.left != nil ? AVLNode((x?.left!)!) : nil
        
        // perform the rotation
        x?.left = node
        node.right = y
        
        // update the heights
        let node_height_l = node.left != nil && node.left?.value != nil ? height((node.left?.value!)!) : 0
        let node_height_r = node.right != nil && node.right?.value != nil ? height((node.right?.value)!) : 0
        
        let x_height_l = x?.left != nil  && x?.left?.value != nil ? height((x?.left?.value)!) : 0
        let x_height_r = x?.right != nil && x?.right?.value != nil ? height((x?.right?.value)!) : 0
        
        node.height = Swift.max(node_height_l, node_height_r) + 1
        y?.height = Swift.max(x_height_l, x_height_r) + 1
    }
    
    override func put(_ value: T) throws {
        try super.put(value)
        balance()
    }
    
    override func remove(_ value: T) throws -> Node<T>? {
        let old_value: Node<T>? = try super.remove(value)
        balance()
        return old_value
    }
    
}


