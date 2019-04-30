//
//  RegisterVC.swift
//  PingPongRecorder
//
//  Created by Chris Magnuson on 4/26/19.
//  Copyright © 2019 Chris Magnuson. All rights reserved.
//

import UIKit
import Alamofire

// Registration page controller
class RegisterVC : UIViewController {
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loadingOverlay: LoadingOverlayView!
    
    // Called when the view is loaded
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        usernameTextField.becomeFirstResponder()
    }
    
    // Register the user
    @IBAction func registerPressed(_ sender: Any) {
        
        let username: String = usernameTextField.text!
        let email: String = emailTextField.text!
        let password: String = passwordTextField.text!
        
        // Check if the username, email, and password are valid and register otherwise show an error alert
        let userValidator = UserValidator()
        if userValidator.isValid(username: username, email: email, password: password) {
            
            let parameters = [
                "username": username,
                "email": email,
                "password": password
            ]
            
            // Send the register request
            request("https://ping-pong-recorder-api.herokuapp.com/register", method: .post, parameters: parameters, encoding: JSONEncoding.default)
                .responseJSON(completionHandler: registerCallback)
            
            view.endEditing(true)
            loadingOverlay.show()
        }
        else {
            // Show error alert
            let errorAlert = UIAlertController(title: "Registration Error", message: "Username, email, or password are not in a valid format", preferredStyle: .alert)
            errorAlert.addAction(UIAlertAction(title: "Dismiss", style: .default))
            self.present(errorAlert, animated: true, completion: nil)
        }
    }
    
    // Go to the login page
    @IBAction func loginPressed(_ sender: Any) {
        performSegue(withIdentifier: "Login", sender: self)
    }
    
    // Regsister the user callback
    private func registerCallback(response: DataResponse<Any>) {
        
        // Convert the response into a dictionary
        if let jsonResponse = response.result.value as? [String: Any?] {
            
            // If the result is successful then redirect the user to login
            if response.response?.statusCode == 201 {
                
                let successAlert = UIAlertController(title: "Registration Successful", message: "Thank you for registering. Please login to confirm your account.", preferredStyle: .alert)
                successAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: loginRedirect))
                self.present(successAlert, animated: true, completion: nil)
                
                performSegue(withIdentifier: "LoginSuccess", sender: self)
            }
            else {
                
                // Show error alert
                let errorAlert = UIAlertController(title: "Registration Error", message: jsonResponse["message"] as? String, preferredStyle: .alert)
                errorAlert.addAction(UIAlertAction(title: "Dismiss", style: .default))
                self.present(errorAlert, animated: true, completion: nil)
            }
        }
        
        view.endEditing(false)
        loadingOverlay.hide()
    }
    
    // Redirect to the login page
    private func loginRedirect(action: UIAlertAction) {
        performSegue(withIdentifier: "Login", sender: self)
    }
}
