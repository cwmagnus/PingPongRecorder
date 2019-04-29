//
//  LoginVC.swift
//  PingPongRecorder
//
//  Created by Chris Magnuson on 4/23/19.
//  Copyright © 2019 Chris Magnuson. All rights reserved.
//

import UIKit
import Alamofire

class LoginVC : UIViewController {
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        usernameTextField.becomeFirstResponder()
    }
    
    @IBAction func loginClicked(_ sender: Any) {
        let parameters: [String: String] = [
            "username": usernameTextField.text!,
            "password": passwordTextField.text!
        ]
        
        request("https://ping-pong-recorder-api.herokuapp.com/login", method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .responseJSON(completionHandler: loginCallback)
    }
    
    @IBAction func registerClicked(_ sender: Any) {
        performSegue(withIdentifier: "Register", sender: self)
    }
    
    private func loginCallback(response: DataResponse<Any>) {
        if (response.response?.statusCode == 200) {
            performSegue(withIdentifier: "LoginSuccess", sender: self)
        }
    }
}
