//
//  FirebaseManager.swift
//  HealthAssistant
//
//  Created by Арсений on 22.04.24.
//

import Foundation
import Firebase

enum FirebaseManager {
    static func logEvent(_ name: String, parameters: [String : Any]? = nil) {
        Analytics.logEvent(name, parameters: parameters )
    }
}
    
   
