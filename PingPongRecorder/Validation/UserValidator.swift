//
//  UserValidator.swift
//  PingPongRecorder
//
//  Created by Chris Magnuson on 4/30/19.
//  Copyright © 2019 Chris Magnuson. All rights reserved.
//

import Foundation

// Checks if usernames passwords or emails are correctly formatted
class UserValidator {
    
    // Check if all fields are valid
    public func isValid(username: String, email: String, password: String) -> Bool {
        return isValidUsername(username: username) && isValidEmail(email: email) && isValidPassword(password: password)
    }
    
    // Check if username and password are valid
    public func isValid(username: String, password: String) -> Bool {
        return isValidUsername(username: username) && isValidPassword(password: password)
    }
    
    // Check if the username is valid
    public func isValidUsername(username: String) -> Bool {
        let containsWhiteSpace = username.rangeOfCharacter(from: .whitespacesAndNewlines) != nil
        return !username.isEmpty && !containsWhiteSpace
    }
    
    // Check if the email is valid
    public func isValidEmail(email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }
    
    // Check if the password is valid
    public func isValidPassword(password: String) -> Bool {
        let containsWhiteSpace = password.rangeOfCharacter(from: .whitespacesAndNewlines) != nil
        return password.count >= 5 && !containsWhiteSpace
    }
}
