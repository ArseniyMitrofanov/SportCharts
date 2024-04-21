//
//  WeightModel.swift
//  HealthAssistant
//
//  Created by Арсений on 19.04.24.
//

import Foundation
struct WeightModel: Codable {
    let value: Int
    let date: String
    
    init(value: Int, date: String) {
        self.value = value
        self.date = date
    }
}
