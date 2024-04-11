//
//  CreateAccountRequest.swift
//  HealthAssistant
//
//  Created by Арсений on 11.04.24.
//

import Foundation

struct AuthorizationRequest {
    var email: String
    var password: String
    
    public func encode() -> [String: Any] {
        return ["username": self.email,
                "password": self.password,
                "firstname": "firstname",
                "lastname": "lastname"
        ]
    }
}

struct Tokens: Codable {
    var accessToken: String
    var refreshToken: String
}
