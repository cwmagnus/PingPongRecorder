//
//  GameTests.swift
//  PingPongRecorderTests
//
//  Created by Chris Magnuson on 4/24/19.
//  Copyright © 2019 Chris Magnuson. All rights reserved.
//

import XCTest
@testable import PingPongRecorder

// Run tests on the game class
class GameTests : XCTestCase {
    
    // Test the user winning game logic
    func testUserDidWin() {
        
        let game = Game(title: "Test Game", userScore: 15, opponentScore: 10);
        
        XCTAssertTrue(game.userDidWin())
    }
}
