//
//  UserValidatorTests.swift
//  PingPongRecorderTests
//
//  Created by Chris Magnuson on 4/29/19.
//  Copyright © 2019 Chris Magnuson. All rights reserved.
//

import XCTest
@testable import PingPongRecorder

// Run tests on the user validator
class UserValidatorTests : XCTestCase {
    // Test if the username is valid
    func testUsernameCorrect() {
        let userValidator = UserValidator()
        
        XCTAssertTrue(userValidator.isValidUsername(username: "testusername"))
    }
    
    // Test if the username is incorrect
    func testUsernameIncorrect() {
        let userValidator = UserValidator()
        
        XCTAssertFalse(userValidator.isValidUsername(username: "bad username"))
    }
    
    // Test if the email is correct
    func testEmailCorrect() {
        let userValidator = UserValidator()
        
        XCTAssertTrue(userValidator.isValidEmail(email: "demo@example.com"))
    }
    
    // Test if the email is incorrect
    func testEmailIncorrect() {
        let userValidator = UserValidator()
        
        XCTAssertFalse(userValidator.isValidEmail(email: "bad email"))
    }
    
    // Test if the password is correct
    func testPasswordCorrect() {
        let userValidator = UserValidator()
        
        XCTAssertTrue(userValidator.isValidPassword(password: "password"))
    }
    
    // Test if the password is incorrect
    func testPasswordIncorrect() {
        let userValidator = UserValidator()
        
        XCTAssertFalse(userValidator.isValidPassword(password: "p"))
    }
}
