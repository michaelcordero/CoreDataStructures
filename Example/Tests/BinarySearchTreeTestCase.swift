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
    let tree: BinarySearchTree<Int> = BinarySearchTree<Int>(rootNodeValue: 10)
    
    // MARK: - XCTestCase
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        try! tree.insert(0)
        try! tree.insert(5)
        try! tree.insert(1)
        try! tree.insert(6)
        try! tree.insert(14)
        try! tree.insert(13)
        try! tree.insert(20)
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
        XCTAssertNoThrow(try tree.insert(testValue))
        print("Updated values: \(tree.values())")
    }
    
    func testAddPreExistingValue() {
        let testValue: Int = 5
        print("Existing values: \(tree.values())")
        print("Test value: \(testValue)")
        XCTAssertThrowsError(try tree.insert(testValue))
        print("Updated values: \(tree.values())")
    }
    
    func testRemoveValidValue() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        print("Current values: \(tree.values())")
        let testNode: BinarySearchTree<Int>.Node<Int> = BinarySearchTree<Int>.Node<Int>(value: 20)
        print("Value to be removed: \(testNode)")
        let removedNode: BinarySearchTree<Int>.Node<Int> = try! tree.remove(testNode.value!)!
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
    
    func testEmptyRootInsert() {
        let emptyTree: BinarySearchTree<Int> = BinarySearchTree<Int>()
        print("Current values: \(emptyTree.values())")
        let testValue: Int = 25
        XCTAssertThrowsError(try emptyTree.insert(testValue))
        print("Updated values: \(emptyTree.values())")
    }
    
    func testSetRootAndInsert() {
        let anotherTree: BinarySearchTree<Int> = BinarySearchTree<Int>()
        print("Current values: \(anotherTree.values())")
        anotherTree.root = BinarySearchTree<Int>.Node<Int>(value: 10)
        print("Updated values: \(anotherTree.values())")
        XCTAssertNoThrow(try anotherTree.insert(0))
        print("Updated values: \(anotherTree.values())")
    }
    
    func testResetRoot() {
        print("Current values: \(tree.values())")
        let oldRoot: BinarySearchTree<Int>.Node<Int> = tree.root!
        print("Old root: \(oldRoot.value!)")
        var oldValues: [Int] = tree.values()
        let newRoot: BinarySearchTree<Int>.Node<Int> = BinarySearchTree<Int>.Node<Int>(value: 15)
        print("New root: \(newRoot.value!)")
        tree.root = newRoot
        //Add new root value for testing
        oldValues.append(newRoot.value!)
        oldValues.sort()
        print("Updated values: \(tree.values())")
        //Make sure we retained old values
        XCTAssertEqual(oldValues, tree.values().sorted())
        XCTAssertNotEqual(oldRoot, tree.root)
        XCTAssertTrue(tree.root?.value == newRoot.value)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
    }
}
