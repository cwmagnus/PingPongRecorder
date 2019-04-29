//
//  TitleVC.swift
//  PingPongRecorder
//
//  Created by Chris Magnuson on 4/29/19.
//  Copyright © 2019 Chris Magnuson. All rights reserved.
//

import UIKit

class TitleVC : UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func loginClicked(_ sender: Any) {
        performSegue(withIdentifier: "Login", sender: self)
    }
    
    @IBAction func registerClicked(_ sender: Any) {
        performSegue(withIdentifier: "Register", sender: self)
    }
}
