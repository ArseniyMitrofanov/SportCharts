//
//  Validator.swift
//  HealthAssistant
//
//  Created by Арсений on 11.04.24.
//

import Foundation

enum Validator {
    
    static func email(from text: String?) -> Bool {
        guard let notNilText = text else { return false }
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: notNilText)
    }
    
    static func password(from text: String?) -> Bool {
        guard let notNilText = text else { return false }
        let passwordRegex = "^[a-zA-Z0-9!@#$%^&*()\\-_=+\\\\|`~\\[{\\]};:'\",<.>/?]+$"
        let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        return passwordPredicate.evaluate(with: notNilText)
    }
}
