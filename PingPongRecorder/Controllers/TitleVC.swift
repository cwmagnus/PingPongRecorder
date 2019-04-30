//
//  TitleVC.swift
//  PingPongRecorder
//
//  Created by Chris Magnuson on 4/29/19.
//  Copyright © 2019 Chris Magnuson. All rights reserved.
//

import UIKit

// Title view controller
class TitleVC : UIViewController {
    
    // Called when the view is loaded
    override func viewDidLoad() {
        
        super.viewDidLoad()
    }
    
    // Called when the user wants to login
    @IBAction func loginClicked(_ sender: Any) {
        
        performSegue(withIdentifier: "Login", sender: self)
    }
    
    // Called when the user wants to register
    @IBAction func registerClicked(_ sender: Any) {
        
        performSegue(withIdentifier: "Register", sender: self)
    }
}
