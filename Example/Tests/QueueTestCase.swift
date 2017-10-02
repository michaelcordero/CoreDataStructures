//
//  QueueTestCase.swift
//  CoreDataStructures_Tests
//
//  Created by Michael Cordero on 10/1/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import XCTest
@testable import CoreDataStructures

class QueueTestCase: XCTestCase {
    
    // MARK: - Test Object
    let xQueue: Queue<Float> = Queue<Float>()
    
    // MARK: - XCTestCase
    override func setUp() {
        super.setUp()
        xQueue.add(1.0)
        xQueue.add(2.0)
        xQueue.add(3.0)
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    // MARK: - Functional Tests
    func testAdd() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        print("Current values: \(xQueue.values())")
        let testElement: Float = 4.0
        xQueue.add(testElement)
        XCTAssert(xQueue.values().contains(testElement))
        print("Updated values: \(xQueue.values())")
    }
    
    func testSize() {
        print("Current values: \(xQueue.values())")
        let originalSize: Int = xQueue.values().count
        let testElement: Float = 5.0
        xQueue.add(testElement)
        print("Updated values: \(xQueue.values())")
        let newSize: Int = xQueue.values().count
        XCTAssertEqual(originalSize+1, newSize)
    }
    
    func testRemove() {
        print("Current values: \(xQueue.values())")
        let testElement: Float = xQueue.values()[0]
        let actualElement: Float? = xQueue.remove()
        XCTAssertEqual(testElement, actualElement)
        XCTAssertTrue(!xQueue.values().contains(testElement))
        print("Updated values: \(xQueue.values())")
    }
    
    func testElement() {
        print("Current values: \(xQueue.values())")
        let testElement: Float = xQueue.values()[0]
        let actualElement: Float? = xQueue.element()
        XCTAssertEqual(testElement, actualElement)
        print("Updated values: \(xQueue.values())")
    }
    
    func testClear() {
        print("Current values: \(xQueue.values())")
        xQueue.clear()
        XCTAssertTrue(xQueue.values().isEmpty)
        print("Updated values: \(xQueue.values())")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
    }
    
}
