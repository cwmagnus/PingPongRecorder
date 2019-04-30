//
//  AddGameVC.swift
//  PingPongRecorder
//
//  Created by Chris Magnuson on 4/24/19.
//  Copyright © 2019 Chris Magnuson. All rights reserved.
//

import UIKit
import Alamofire

// View controller for adding games
class AddGameVC : UIViewController {
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var userScoreTextField: UITextField!
    @IBOutlet weak var opponetScoreTextField: UITextField!
    
    // Load the view
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        titleTextField.becomeFirstResponder()
    }
    
    // Cancel recording a game
    @IBAction func cancelClicked(_ sender: Any) {
        
        view.endEditing(true)
        dismiss(animated: true)
    }
    
    // Finish recording a game
    @IBAction func doneClicked(_ sender: Any) {
        
        let title: String = titleTextField.text!
        let userScore: Int? = Int(userScoreTextField.text!)
        let opponentScore: Int? = Int(opponetScoreTextField.text!)
        
        // Check if the casting failed
        if (userScore != nil || opponentScore != nil) {
            
            // Check if the game is valid
            let gameValidator = GameValidator()
            if gameValidator.isValid(title: title, userScore: userScore!, opponentScore: opponentScore!) {
                
                // Make the post request
                let parameters: [String: Any] = [
                    "name": title,
                    "user_score": userScore!,
                    "opponent_score": opponentScore!
                ]
                
                let headers = [
                    "Authorization": "Bearer \(Authentication.accessToken ?? "invalid token")",
                    "Content-Type": "application/json"
                ]
                
                request("https://ping-pong-recorder-api.herokuapp.com/game", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
                    .responseJSON { response in
                        self.view.endEditing(true)
                        self.dismiss(animated: true)
                }
            }
            else {
                // Show error message if couldn't validate
                let errorAlert = UIAlertController(title: "Error Adding Game", message: "The information you entered is invalid", preferredStyle: .alert)
                errorAlert.addAction(UIAlertAction(title: "Dismiss", style: .default))
                self.present(errorAlert, animated: true, completion: nil)
            }
        }
        else {
            // Show error message if couldn't validate
            let errorAlert = UIAlertController(title: "Error Adding Game", message: "The information you entered is invalid", preferredStyle: .alert)
            errorAlert.addAction(UIAlertAction(title: "Dismiss", style: .default))
            self.present(errorAlert, animated: true, completion: nil)
        }
    }
}
