//
//  GameValidator.swift
//  PingPongRecorder
//
//  Created by Chris Magnuson on 4/30/19.
//  Copyright © 2019 Chris Magnuson. All rights reserved.
//

class GameValidator {
    
    public func isValid(title: String, userScore: Int, opponentScore: Int) -> Bool {
        return isValidTitle(title: title) && isValidScores(userScore: userScore, opponentScore: opponentScore)
    }
    
    public func isValidTitle(title: String) -> Bool {
        return title.count >= 1
    }
    
    public func isValidScores(userScore: Int, opponentScore: Int) -> Bool {
        return isValidScore(score: userScore) && isValidScore(score: opponentScore)
    }
    
    public func isValidScore(score: Int) -> Bool {
        return score <= 11 && score >= 0
    }
}
