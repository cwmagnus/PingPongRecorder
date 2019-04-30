//
//  GameCell.swift
//  PingPongRecorder
//
//  Created by Chris Magnuson on 4/29/19.
//  Copyright © 2019 Chris Magnuson. All rights reserved.
//

import UIKit

// Game table view cell
class GameCell : UITableViewCell {
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var userScore: UILabel!
    @IBOutlet weak var opponentScore: UILabel!
    
    // Fill the cell with data
    public func setup(game: Game) {
        title.text = game.title
        userScore.text = "Your score: \(game.userScore ?? 0)"
        opponentScore.text = "Opponent's score: \(game.opponentScore ?? 0)"
    }
}
