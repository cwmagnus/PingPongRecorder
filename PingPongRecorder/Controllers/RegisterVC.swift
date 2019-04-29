//
//  RegisterVC.swift
//  PingPongRecorder
//
//  Created by Chris Magnuson on 4/26/19.
//  Copyright © 2019 Chris Magnuson. All rights reserved.
//

import UIKit

class RegisterVC : UIViewController {
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        usernameTextField.becomeFirstResponder()
    }
    
    @IBAction func registerPressed(_ sender: Any) {
        performSegue(withIdentifier: "LoginSuccess", sender: self)
    }
    
    @IBAction func loginPressed(_ sender: Any) {
        performSegue(withIdentifier: "Login", sender: self)
    }
}
