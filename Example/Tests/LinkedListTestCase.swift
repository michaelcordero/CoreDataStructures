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
        XCTAssert(linked_list!.add(1))
        XCTAssert(linked_list!.add(0))
        XCTAssert(linked_list!.add(7))
        XCTAssert(linked_list!.add(9))
    }
    
    func testGet() {
        let expected: [Int] = [8,2,1,4,5,6,3,9]
        expected.forEach({ let _ = linked_list?.add($0)})
        var result: [Int] = []
        for index in 0...expected.count-1 {
            result.append((linked_list?.get(index))!)
        }
        print("Expected: \(expected). Actual Result: \(result)")
    }
    
    func testGetEmpty() {
        let expected: [Int] = []
        expected.forEach({ let _ = linked_list?.add($0)})
        let result: [Int] = (linked_list?.all().map({$0!}))!
        print("Expected: \(expected). Actual Result: \(result)")
    }
    
    func testAll(){
        let expected: [Int] = [1,2,3,4,5,6,7,8,9]
        expected.forEach({ let _ = linked_list?.add($0)})
        let result: [Int] = (linked_list?.all())!.map({$0!})
        print("Expected: \(expected). Actual Result: \(result)")
    }
    

//    func testPerformanceExample() {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }

}
