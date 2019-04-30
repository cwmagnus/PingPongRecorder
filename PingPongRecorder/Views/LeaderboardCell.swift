//
//  LeaderboardCell.swift
//  PingPongRecorder
//
//  Created by Chris Magnuson on 4/29/19.
//  Copyright © 2019 Chris Magnuson. All rights reserved.
//

import UIKit

// Cell to display on leaderboard table
class LeaderBoardCell : UITableViewCell {
    
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var wins: UILabel!
    @IBOutlet weak var losses: UILabel!
    
    // Fill the cell with data
    public func setup(user: User) {
        username.text = user.username
        wins.text = "Wins: \(user.wins ?? 0)"
        losses.text = "Losses: \(user.losses ?? 0)"
    }
}
