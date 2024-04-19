//
//  UserDefaultsManager.swift
//  HealthAssistant
//
//  Created by Арсений on 15.04.24.
//

import Foundation

final class UserDefaultsManager {
    static let shared = UserDefaultsManager()
    private init() {}
    
    func saveTokens(tokens: Tokens) {
        UserDefaults.standard.setValue(tokens.accessToken, forKey: "accessToken")
        UserDefaults.standard.setValue(tokens.token, forKey: "refreshToken")
    }
    
    func getTokens() -> Tokens? {
        if let accessToken = UserDefaults.standard.string(forKey: "accessToken"),
           let refreshToken = UserDefaults.standard.string(forKey: "refreshToken") {
            return Tokens(accessToken: accessToken, token: refreshToken)
        }
        return nil
    }
}
