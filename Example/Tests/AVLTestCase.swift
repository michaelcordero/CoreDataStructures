//
//  AVLTestCase.swift
//  CoreDataStructures_Tests
//
//  Created by Michael Cordero on 10/15/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import XCTest
@testable import CoreDataStructures

class AVLTestCase: XCTestCase {
    var avl: AVLTree<Int>  = AVLTree<Int>(44)

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testPutAutoBalances() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        try! avl.put(17)
        XCTAssertTrue(avl.isBalanced(avl.get(17)!))
        
        try! avl.put(78)
        XCTAssertTrue(avl.isBalanced(avl.get(78)!))
        
        try! avl.put(32)
        XCTAssertTrue(avl.isBalanced(avl.get(32)!))
        
        try! avl.put(33)    // make root left heavy and 17 right heavy, i.e. Left-Right case
        XCTAssertTrue(avl.isBalanced(avl.get(33)!))
//        try! avl.put(50)
//        try! avl.put(88)
//        try! avl.put(48)
//        try! avl.put(62)
//        try! avl.put(54)
    }
    
//    func testRemoveAutoBalances() {
//        
//    }

//    func testPerformanceExample() {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }

}
