//
//  LoginVC.swift
//  PingPongRecorder
//
//  Created by Chris Magnuson on 4/23/19.
//  Copyright © 2019 Chris Magnuson. All rights reserved.
//

import Foundation
import UIKit

class LoginVC : UIViewController {
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
    }
    
    @IBAction func loginClicked(_ sender: Any) {
        
        // TODO: Do processing and check if the user logged in successfully
        performSegue(withIdentifier: "LoginSuccess", sender: self)
    }
    
}
