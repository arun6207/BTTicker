//
//  BitTickerTests.swift
//  BitTickerTests
//
//  Created by Amuri Arun Kumar on 2/6/19.
//  Copyright © 2019 Amuri Arun Kumar. All rights reserved.
//

import XCTest
@testable import BitTicker

class BitTickerTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    func testValidEmail(){
        let isValidEmail = BTDataValidator.isValidEmail("test@test.com")
        XCTAssert(isValidEmail, "valid EmailId")
        XCTAssertFalse(BTDataValidator.isValidEmail("test@"), "testvalidEmail(),failure")
    }
    func testValidPassword(){
        let isValidEmail = BTDataValidator.isValidEmail("123456")
        XCTAssert(isValidEmail, "valid password")
        XCTAssertFalse(BTDataValidator.isValidEmail("te"), "testvalidPassword(),failure")
    }

}
