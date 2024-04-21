//
//  WeightModel.swift
//  HealthAssistant
//
//  Created by Арсений on 19.04.24.
//

import Foundation
struct WeightModel: Codable {
    let weight: Int
    let dateTime: String
    
    init(weight: Int, dateTime: String) {
        self.weight = weight
        self.dateTime = dateTime
    }
}
