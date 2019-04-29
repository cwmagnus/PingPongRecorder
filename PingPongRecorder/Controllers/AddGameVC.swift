//
//  AddGameVC.swift
//  PingPongRecorder
//
//  Created by Chris Magnuson on 4/24/19.
//  Copyright © 2019 Chris Magnuson. All rights reserved.
//

import UIKit

// View controller for adding games
class AddGameVC : UIViewController {
    
    // Load the view
    override func viewDidLoad() {
        
        super.viewDidLoad()
    }
    
    // Cancel recording a game
    @IBAction func cancelClicked(_ sender: Any) {
        
        dismiss(animated: true)
    }
    
    // Finish recording a game
    @IBAction func doneClicked(_ sender: Any) {
        
        // TODO: Post game to API
    }
}
