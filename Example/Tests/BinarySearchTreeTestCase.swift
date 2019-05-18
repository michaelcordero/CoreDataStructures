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

    /// This method is moreso geared towards testing the
    /// actual validity of the Tree's O(log n) retrieval
    /// of data. As of 10/14/2018 The setup uses 10 elements.
    /// 22 being the furthermost right child. Quick math will
    //  tell you that 2^3 = 8, which is closer to 10, than 2^4 = 16.
    //  Therefore: the BST search method should only be recursively called
    /// between 3 and 4 times. Log2^10 = 3.3219280949.
    /// To actually count # of times a method is called:
    /// 1. Put a breakpoint at the first line of the method.
    ///    in this case BinarySearchTree::search().
    /// 2. Right Click on break point. Click edit.
    /// 3. Click "Add Action"
    /// 4. Select Log Message from the drop down menu.
    /// 5. Add the following to the text area: "%B hit %H"
    /// 6. Click checkbox, "Automatically continue after evaluating actions."
    ///    so the breakpoint doesn't stop every single iteration.
    /// 7. Run test.
    func testGetValidValue(){
        /// The setup() calls puts(), which in turn calls the search() method,
        /// to place the nodes in the correct locations.
        /// We only care about the search recursive calls in the context of our get().
        print("Ignore previous hits")
        let valid_value: Int = 22
        let returned_value: Int? = tree.get(valid_value)?.value
        XCTAssertNotNil(returned_value)
    }

    func testGetInvalidValue(){
        let invalid_value: Int = 72
        XCTAssertNil(tree.get(invalid_value))
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

    func testBalance() {
        try! tree.put(11)
        tree.balance()
        let leftHeight: Int = tree.height((tree.root?.left?.value)!)
        let rightHeight: Int = tree.height((tree.root?.right?.value)!)
        XCTAssertTrue(abs(leftHeight - rightHeight) <= 1)
    }

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
    
    //The definition of balanced is: The heights of the two child subtrees of any node differ by at most one.
    func testIsBalanced(){
        let test_tree: BinarySearchTree<Int> = BinarySearchTree(44)
        try! test_tree.put(17)
        try! test_tree.put(78) // this node becomes left heavy
        try! test_tree.put(32)
        try! test_tree.put(50)
        try! test_tree.put(88)
        try! test_tree.put(48)
        try! test_tree.put(62)
        try! test_tree.put(54)
        
        let result: Bool = test_tree.isBalanced()
        XCTAssertFalse(result)
        
        test_tree.balance()
        XCTAssertTrue(test_tree.isBalanced())
        
       
    }
}
