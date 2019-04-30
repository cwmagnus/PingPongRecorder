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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        usernameTextField.becomeFirstResponder()
    }
    
    // Register the user
    @IBAction func registerPressed(_ sender: Any) {
        let username: String? = usernameTextField.text
        let email: String? = emailTextField.text
        let password: String? = passwordTextField.text
        
        // If the fields aren't empty try to register the user
        if (username != nil && email != nil && password != nil) {
            let parameters: [String: String] = [
                "username": username!,
                "email": email!,
                "password": password!
            ]
            
            request("https://ping-pong-recorder-api.herokuapp.com/register", method: .post, parameters: parameters, encoding: JSONEncoding.default)
                .responseJSON(completionHandler: registerCallback)
            
            // Show
        }
    }
    
    // Go to the login page
    @IBAction func loginPressed(_ sender: Any) {
        performSegue(withIdentifier: "Login", sender: self)
    }
    
    // Regsister the user callback
    private func registerCallback(response: DataResponse<Any>) {
        // Check if the response is successful
        if (response.response?.statusCode == 201) {
            let successAlert = UIAlertController(title: "Registration Successful", message: "Thank you for registering. Please login to confirm your account.", preferredStyle: .alert)
            successAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: loginRedirect))
            self.present(successAlert, animated: true, completion: nil)
        }
        else {
            // Show json error message
            if let json = response.result.value as? [String: String] {
                let errorAlert = UIAlertController(title: "Registration Error", message: json["message"], preferredStyle: .alert)
                errorAlert.addAction(UIAlertAction(title: "Dismiss", style: .default))
                self.present(errorAlert, animated: true, completion: nil)
            }
        }
        
        // Hide
    }
    
    // Redirect to the login page
    private func loginRedirect(action: UIAlertAction) {
        performSegue(withIdentifier: "Login", sender: self)
    }
}
