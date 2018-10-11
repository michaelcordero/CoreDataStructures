//
//  BinaryTree.swift
//  CoreDataStructures
//
//  Created by Michael Cordero on 10/10/18.
//

import Foundation

/*
 A binary tree is an ordered tree with the following properties:
    1. every node has at most two children
    2. each child node is labeled as being either a left or right child
    3. a left child procedes a right child in the ordering of children of a node
 */

protocol BinaryTree : Tree {
    func children(node: Node<T>) -> ( left: Node<T>?, right: Node<T>? )
}
