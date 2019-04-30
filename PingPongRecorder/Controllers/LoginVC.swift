//
//  LoginVC.swift
//  PingPongRecorder
//
//  Created by Chris Magnuson on 4/23/19.
//  Copyright © 2019 Chris Magnuson. All rights reserved.
//

import UIKit
import Alamofire

// Handles logging in a user
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
        
        let username: String = usernameTextField.text!
        let password: String = passwordTextField.text!
        
        // Check if the username and password are valid and login otherwise show an error alert
        let userValidator = UserValidator()
        if userValidator.isValid(username: username, password: password) {
            
            let parameters = [
                "username": username,
                "password": password
            ]
        
            // Send the login request
            request("https://ping-pong-recorder-api.herokuapp.com/login", method: .post, parameters: parameters, encoding: JSONEncoding.default)
                .responseJSON(completionHandler: loginCallback)
            
            view.endEditing(true)
            loadingOverlay.show()
        }
        else {
            // Show error alert
            let errorAlert = UIAlertController(title: "Login Error", message: "Username or password are not in a valid format", preferredStyle: .alert)
            errorAlert.addAction(UIAlertAction(title: "Dismiss", style: .default))
            self.present(errorAlert, animated: true, completion: nil)
        }
    }
    
    // Go to the register page
    @IBAction func registerClicked(_ sender: Any) {
        
        performSegue(withIdentifier: "Register", sender: self)
    }
    
    // Callback when the user finished logging in
    private func loginCallback(response: DataResponse<Any>) {
        
        // Convert the response into a dictionary
        if let jsonResponse = response.result.value as? [String: Any?] {

            // If the result is successful then save the access token and proceed otherwise show the server error message
            if response.response?.statusCode == 200 {
                
                Authentication.accessToken = jsonResponse["access_token"] as? String
                // TODO: Store refresh token in user settings
                    
                performSegue(withIdentifier: "LoginSuccess", sender: self)
            }
            else {
                
                // Show error alert
                let errorAlert = UIAlertController(title: "Login Error", message: jsonResponse["message"] as? String, preferredStyle: .alert)
                errorAlert.addAction(UIAlertAction(title: "Dismiss", style: .default))
                self.present(errorAlert, animated: true, completion: nil)
            }
        }
        
        view.endEditing(false)
        loadingOverlay.hide()
    }
}
