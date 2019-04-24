//
//  Game.swift
//  PingPongRecorder
//
//  Created by Chris Magnuson on 4/24/19.
//  Copyright © 2019 Chris Magnuson. All rights reserved.
//

import Foundation

// Serializable ping pong game data model
class Game : Codable {
    
    var title: String!
    var userScore: Int!
    var opponentScore: Int!
    
    // Initialize the game data
    init(title: String, userScore: Int, opponentScore: Int) {
        self.title = title
        self.userScore = userScore
        self.opponentScore = opponentScore
    }
    
    // Check if the user won this game
    func userDidWin() -> Bool {
        
        return userScore > opponentScore
    }
}
