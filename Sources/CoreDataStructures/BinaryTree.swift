//
//  BinaryTree.swift
//  CoreDataStructures
//
//  Created by Michael Cordero on 1/2/21.
//
import Foundation

/*
 A binary tree is an ordered tree with the following properties:
    1. every node has at most two children
    2. each child node is labeled as being either a left or right child
    3. a left child procedes a right child in the ordering of children of a node
 */

protocol BinaryTree : Tree {
    func family(parent: Node<T>?) -> (parent: Node<T>?, left: Node<T>?, right: Node<T>?)
    func children(parent: Node<T> ) -> ( left: Node<T>?, right: Node<T>? )
    func sibling(node: Node<T> ) -> Node<T>?
}
