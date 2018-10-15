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
    private class AVLNode<T: Comparable> : Node<T> {
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
                height = Swift.max(height, (left as! AVLNode).height )
            }
            if right != nil {
                height = Swift.max(height, 1 + (right as! AVLNode).height)
            }
        }
        
        
    }
    
    private func taller_child(_ node: Node<T>) -> Node<T> {
        if self.height((node.left?.value!)!) > self.height((node.right?.value!)!) {
            return node.left!
        } else if ( self.height((node.left?.value)!) < self.height((node.right?.value)!) ) {
            return node.right!
        }
        // tie breaker
        if self.root == node {
            return node.left!
        }
        if node == node.parent?.left {
            return node.left!
        }
        return node.right!
        
    }
    
    private func isBalanced(_ node: Node<T>) -> Bool {
        let difference = self.height((node.left?.value!)!) - self.height((node.right?.value!)!)
        return ((-1 <= difference) && (difference <= 1))
    }
    
    private func restructure(_ avl_node: AVLNode<T>) -> Void {
        var node: AVLNode = avl_node
        if node.isParent() {
           node.height = self.height(avl_node.value!)
        }
        while node != self.root {
            node = avl_node.parent as! AVLTree<T>.AVLNode<T>
            node.height = self.height(node.value!)
            if !isBalanced(node) {
// perform the trinode restructuring at node's tallest grandchild
                //let xPos: Node<T> = taller_child(taller_child(node))
               // node = restructure(xPos as! AVLNode<T>)
            }
        }
    }
    
    override func put(_ value: T) throws {
        try super.put(value)
        let node: AVLNode<T> = AVLNode(value: value)
        restructure(node)
    }
    
   
    
    
    
    
}
