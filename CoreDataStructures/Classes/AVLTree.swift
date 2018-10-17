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
    
    private func setHeight(_ node: Node<T>) -> Void {
        let max_left: Int = node.left != nil && node.left?.value != nil ? height((node.left?.value)!) : 0
        let max_right: Int = node.right != nil && node.right?.value != nil ? height((node.right?.value)!) : 0
        let total_maximum: Int = 1 + Swift.max(max_left, max_right)
        (node as! AVLNode).height = total_maximum
    }
    
    private func taller_child(_ node: Node<T>) -> Node<T> {
        let left_height: Int = node.left != nil && node.left?.value != nil ? self.height((node.left?.value!)!) : 0
        let right_height: Int = node.right != nil && node.right?.value != nil ? height((node.right?.value)!) : 0
        if left_height > right_height {
            return node.left!
        } else if right_height > left_height {
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
    
    public func isBalanced(_ node: Node<T>) -> Bool {
        let left_height: Int = (node.left != nil && node.left?.value != nil ? self.height((node.left?.value!)!) : 0 )
        let right_height: Int = (node.right != nil && node.right?.value != nil ? self.height((node.right?.value!)!) : 0 )
        let balance_factor = left_height - right_height
        return ((-1 <= balance_factor) && (balance_factor <= 1))
    }
    
    private func rebalance(_ avl_node: inout AVLNode<T>) -> Void {
        if avl_node.isParent() {
           setHeight(avl_node)
        }
        while avl_node.value != self.root?.value {
            avl_node = AVLNode(value: avl_node.parent?.value!, left: avl_node.parent?.left, right: avl_node.parent?.right, parent: avl_node.parent?.parent)
            setHeight(avl_node)
            if !isBalanced(avl_node) {
// perform the trinode restructuring at node's tallest grandchild
                let xPos: Node<T> = taller_child(taller_child(avl_node))
                let result: Node<T> = self.restructure(xPos)!
                avl_node = AVLNode(value: result.value!, left: result.left, right: result.right, parent: result.parent)
                setHeight(avl_node.left!)
                setHeight(avl_node.right!)
                setHeight(avl_node)
            }
        }
    }
    
    override func put(_ value: T) throws {
        try super.put(value)
        let binary_node: Node<T> = super.get(value)!
        var node: AVLNode<T> = AVLNode(value: binary_node.value, left: binary_node.left, right: binary_node.right, parent: binary_node.parent)
        rebalance(&node)
    }
    
    override func remove(_ value: T) throws -> Node<T>? {
        let position: Node<T> =  sibling(node: self.get( value )!)!
        var paramter: AVLNode<T> = AVLNode(value: position.value!)
        let old_value: Node<T>? = try super.remove(value)
        if old_value != nil {
            rebalance(&paramter)
        }
        return old_value
    }
    
}

extension AVLTree.AVLNode : CustomDebugStringConvertible {
    var debugDescription: String {
        var description: String = "AVLNode[ Key:\(String(describing: self.value)), Height:\(self.height) "
        description += "Left: \(String(describing: self.left)), "
        description += "Right: \(String(describing: self.right)), "
        description += " ]"
        
        return description
    }
    
    
}


