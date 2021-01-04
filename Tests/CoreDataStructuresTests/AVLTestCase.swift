//
//  AVLTestCase.swift
//  CoreDataStructures_Tests
//
//  Created by Michael Cordero on 1/2/21.
//

import XCTest
@testable import CoreDataStructures

class AVLTestCase: XCTestCase {
    

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testPutAutoBalances() {
        let avl: AVLTree<Int>  = AVLTree<Int>(44)
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        try! avl.put(17)
        XCTAssertTrue(avl.isBalanced())

        try! avl.put(78)
        XCTAssertTrue(avl.isBalanced())

        try! avl.put(32)
        XCTAssertTrue(avl.isBalanced())

        try! avl.put(33)    // make root left heavy and 17 right heavy, i.e. Left-Right case
        XCTAssertTrue(avl.isBalanced())
        
        try! avl.put(50)
        XCTAssertTrue(avl.isBalanced())
        
        try! avl.put(88)
        XCTAssertTrue(avl.isBalanced())
        
        try! avl.put(48)
        XCTAssertTrue(avl.isBalanced())
        
        try! avl.put(62)
        XCTAssertTrue(avl.isBalanced())
        
        try! avl.put(54)
        XCTAssertTrue(avl.isBalanced())
    }
    
    func testRemoveAutoBalances() {
        let avl: AVLTree<Int>  = AVLTree<Int>(44)
        try! avl.put(50)
        try! avl.put(88)
        try! avl.put(48)
        try! avl.put(62)
        try! avl.put(54)
        
        try! _ = avl.remove(54)
        XCTAssertTrue(avl.isBalanced())
        print(avl.root.debugDescription)
        
        try! _ = avl.remove(62)
        XCTAssertTrue(avl.isBalanced())
        print(avl.root.debugDescription)
        
        //trying to remove the root
//        try! _ = avl.remove(48)
//        XCTAssertTrue(avl.isBalanced())
//        print(avl.root.debugDescription)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
            let avl: AVLTree<Int>  = AVLTree<Int>()
            for i in 0...1000 {
                try! avl.put(i)
            }
        }
    }

}

