//
//  LoginVC.swift
//  PingPongRecorder
//
//  Created by Chris Magnuson on 4/23/19.
//  Copyright © 2019 Chris Magnuson. All rights reserved.
//

import UIKit
import Alamofire

// Handles loggin in a user
class LoginVC : UIViewController {
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loadingOverlay: LoadingOverlayView!
    
    // Called when the view is loaded
    override func viewDidLoad() {
        super.viewDidLoad()
        
        usernameTextField.becomeFirstResponder()
    }
    
    // Login the user
    @IBAction func loginClicked(_ sender: Any) {
        let username: String? = usernameTextField.text
        let password: String? = passwordTextField.text
        
        // If the fields aren't empty try to login
        if (username != nil && password != nil) {
            let parameters: [String: String] = [
                "username": username!,
                "password": password!
            ]
        
            request("https://ping-pong-recorder-api.herokuapp.com/login", method: .post, parameters: parameters, encoding: JSONEncoding.default)
                .responseJSON(completionHandler: loginCallback)
            
            view.endEditing(true)
            loadingOverlay.show()
        }
    }
    
    // Go to the register page
    @IBAction func registerClicked(_ sender: Any) {
        performSegue(withIdentifier: "Register", sender: self)
    }
    
    // Callback when the user finished logging in
    private func loginCallback(response: DataResponse<Any>) {
        if (response.response?.statusCode == 200) {
            
            // TODO: Put access token in memory
            // TODO: Store refresh token in user settings
            
            performSegue(withIdentifier: "LoginSuccess", sender: self)
        }
        else {
            // Show json error message
            if let json = response.result.value as? [String: String] {
                let errorAlert = UIAlertController(title: "Login Error", message: json["message"], preferredStyle: .alert)
                errorAlert.addAction(UIAlertAction(title: "Dismiss", style: .default))
                self.present(errorAlert, animated: true, completion: nil)
            }
        }
        
        view.endEditing(false)
        loadingOverlay.hide()
    }
}
