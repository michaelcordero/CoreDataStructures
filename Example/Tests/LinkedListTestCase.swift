//
//  LinkedListTestCase.swift
//  CoreDataStructures_Tests
//
//  Created by Michael Cordero on 10/10/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import XCTest
@testable import CoreDataStructures

class LinkedListTestCase: XCTestCase {
    var linked_list: LinkedList<Int>?
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        linked_list = LinkedList<Int>()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testAdd() {
        XCTAssert(linked_list!.add(5))
    }
    
    func testGet() {
        let expected: Int = 5
        let _ = linked_list?.add( expected )
        let result: Int = (linked_list?.get(0))!
        XCTAssertEqual(result, expected)
        print("Expected: \(expected). Actual Result: \(result)")
    }
    

//    func testPerformanceExample() {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }

}
