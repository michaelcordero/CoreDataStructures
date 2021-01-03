//
//  StackTestCase.swift
//  CoreDataStructures_Tests
//
//  Created by Michael Cordero on 1/2/21.
//

import XCTest
@testable import CoreDataStructures

class StackTestCase: XCTestCase {
    
    // MARK: - Test Object
    let xStack: Stack<Int> = Stack<Int>()
    
    // MARK: - XCTestCase
    override func setUp() {
        super.setUp()
        xStack.push(1)
        xStack.push(2)
        xStack.push(3)
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    // MARK: - Functional Tests
    func testPeek() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        print("Current stack values: \(xStack.values())")
        let testValue: Int = 3
        print("Last added value: \(testValue)")
        XCTAssertEqual(testValue, xStack.peek())
    }
    
    func testPop() {
        print("Current stack values: \(xStack.values())")
        let testValue: Int = 3
        print("Popping: \(String(describing: testValue))")
        XCTAssertEqual(testValue, xStack.pop())
        print("Updated stack values: \(xStack.values())")
    }
    
    func testEmpty() {
        print("Current stack values: \(xStack.values())")
        let value1 = xStack.pop()
        print("Popping: \(String(describing: value1))")
        print("Updated stack values: \(xStack.values())")
        let value2 = xStack.pop()
        print("Popping: \(String(describing: value2))")
        print("Updated stack values: \(xStack.values())")
        let value3 = xStack.pop()
        print("Popping: \(String(describing: value3))")
        print("Updated stack values: \(xStack.values())")
        XCTAssertTrue(xStack.empty())
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
    }
    
}

