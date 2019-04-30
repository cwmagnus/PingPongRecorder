//
//  GameValidationTests.swift
//  PingPongRecorderTests
//
//  Created by Chris Magnuson on 4/30/19.
//  Copyright © 2019 Chris Magnuson. All rights reserved.
//

import XCTest
@testable import PingPongRecorder

// Run tests on the game validator
class GameValidatorTests : XCTestCase {
    // Test if the title is correct
    func testGameTitleCorrect() {
        let gameValidator = GameValidator()
        
        XCTAssertTrue(gameValidator.isValidTitle(title: "Title"))
    }
    
    // Test if the title is incorrect
    func testGameTitleIncorrect() {
        let gameValidator = GameValidator()
        
        XCTAssertFalse(gameValidator.isValidTitle(title: ""))
    }

    // Test if the game score is correct
    func testGameScoreCorrect() {
        let gameValidator = GameValidator()
        
        XCTAssertTrue(gameValidator.isValidScore(score: 5))
    }
    
    // Test if the game score is inccorect
    func testGameScoreIncorrect() {
        let gameValidator = GameValidator()
        
        XCTAssertFalse(gameValidator.isValidScore(score: -5))
    }
}
