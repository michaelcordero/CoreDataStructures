//
//  BinarySearchTreeTestCase.swift
//  CoreDataStructures_Tests
//
//  Created by Michael Cordero on 10/1/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import XCTest
@testable import CoreDataStructures

class BinarySearchTreeTestCase: XCTestCase {
    
    // MARK: - Test Object
    var tree: BinarySearchTree<Int> = BinarySearchTree<Int>(10)
    
    // MARK: - XCTestCase
    
    /**
                                10
                            /         \
                           3             21
                          / \            /  \
                         1   5          14   22
                              \         / \
                                6      13  20
     */
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        try! tree.put(3)
        try! tree.put(5)
        try! tree.put(21)
        try! tree.put(1)
        try! tree.put(6)
        try! tree.put(22)
        try! tree.put(14)
        try! tree.put(13)
        try! tree.put(20)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    // MARK: - Functional Tests
    func testAddValidValue() {
        let testValue: Int = 32
        print("Existing values: \(tree.values())")
        print("Test value: \(testValue)")
        XCTAssertNoThrow(try! tree.put(testValue))
        print("Updated values: \(tree.values())")
    }
    
    func testAddPreExistingValue() {
        let testValue: Int = 5
        print("Existing values: \(tree.values())")
        print("Test value: \(testValue)")
        XCTAssertThrowsError(try tree.put(testValue))
        print("Updated values: \(tree.values())")
    }
    
    func testRemoveValidValue() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        print("Current values: \(tree.values())")
        let testNode: Node<Int> = Node<Int>(value: 20)
        print("Value to be removed: \(testNode)")
        let removedNode: Node<Int> = try! tree.remove(testNode.value!)!
        print("Updated values: \(tree.values())")
        XCTAssertEqual(removedNode.value, testNode.value)
    }
    
    func testRemoveInvalidValue() {
        print("Valid values: \(tree.values())")
        let invalidValue: Int = 15
        print("Invalid value: \(invalidValue)")
        XCTAssertThrowsError(try tree.remove(invalidValue))
        print("Updated values: \(tree.values())")
    }
    
    func testSetRootAndInsert() {
        let anotherTree: BinarySearchTree<Int> = BinarySearchTree<Int>()
        print("Current values: \(anotherTree.values())")
        anotherTree.root = Node<Int>(value: 10)
        print("Updated values: \(anotherTree.values())")
        XCTAssertNoThrow(try anotherTree.put(0))
        print("Updated values: \(anotherTree.values())")
    }
    
    func testResetRoot() {
        print("Current values: \(tree.values())")
        let oldRoot: Node<Int> = tree.root!
        print("Old root: \(oldRoot.value!)")
        var oldValues: [Int] = Array<Int>(tree.values())
        let newRoot: Node<Int> = Node<Int>(value: 15)
        print("New root: \(newRoot.value!)")
        tree.root = newRoot
        //Add new root value for testing
        oldValues.append(newRoot.value!)
        oldValues.sort()
        print("Old Values: \(oldValues)")
        print("New values: \(tree.values(.Inorder))")
        //Make sure we retained old values
        XCTAssertEqual(oldValues, tree.values(.Inorder))
        XCTAssertNotEqual(oldRoot, tree.root)
        XCTAssertTrue(tree.root?.value == newRoot.value)
    }
    
    func testMax() {
        let actualMax: Int = tree.values().max()!
        print("Actual Max: \(actualMax)")
        let testMax: Int = (tree.max?.value!)!
        print("Test Max: \(testMax)")
        XCTAssertEqual(actualMax, testMax)
    }
    
    func testMin() {
        let actualMin: Int = tree.values().min()!
        print("Actual Min: \(actualMin)")
        let testMin: Int = (tree.min?.value ?? nil)!
        print("Test Min: \(testMin)")
        XCTAssertEqual(actualMin, testMin)
    }
    
    func testMaxWithNilRoot() {
        tree = BinarySearchTree<Int>()
        let max: Int? = tree.max?.value ?? nil
        XCTAssertNil(max)
    }
    
    func testMinWithNilRoot() {
         tree = BinarySearchTree<Int>()
         let min: Int? = tree.min?.value ?? nil
         XCTAssertNil(min)
    }
    
    func testHeight() {
        try! tree.put(7)
        try! tree.put(8)
        XCTAssertEqual(tree.height((tree.root?.value)!), 6)
    }
    
    func testDepth() {
        XCTAssertEqual(tree.depth((tree.root?.value)!), 0)
        XCTAssertEqual(tree.depth(6), 3)
    }
    
    func testNodeHeight() {
        XCTAssertEqual(tree.height(6), 1)
    }
    
    // Turning off balance for now
//    func testBalance() {
//        try! tree.put(11)
//        tree.balance()
//        let leftHeight: Int = tree.height((tree.root?.left?.value)!)
//        let rightHeight: Int = tree.height((tree.root?.right?.value)!)
//        XCTAssertTrue(abs(leftHeight - rightHeight) <= 1)
//    }
    
    /**
                    10
                /         \
                3           21
                / \         /  \
                1   5      14   22
                    \      / \
                    6     13  20
     */
    
    func testPreOrder() {
        let expected: [Int] = [10,3,1,5,6,21,14,13,20,22]
        XCTAssertEqual(expected, tree.values(.Preorder))
        XCTAssertNotEqual(tree.values(.Preorder), tree.values(.Postorder))
        XCTAssertNotEqual(tree.values( .Preorder), tree.values(.Inorder))
    }
    
    func testPostOrder() {
        let expected: [Int] = [1,6,5,3,13,20,14,22,21,10]
        XCTAssertEqual(expected, tree.values(.Postorder))
        XCTAssertNotEqual(tree.values(.Postorder), tree.values(.Preorder))
        XCTAssertNotEqual(tree.values(.Postorder), tree.values(.Inorder))
    }
    
    func testInOrder() {
        let expected: [Int] = [1,3,5,6,10,13,14,20,21,22]
        XCTAssertEqual(expected, tree.values(.Inorder))
        XCTAssertNotEqual(expected, tree.values(.Preorder))
        XCTAssertNotEqual(expected, tree.values(.Postorder))
    }
}
