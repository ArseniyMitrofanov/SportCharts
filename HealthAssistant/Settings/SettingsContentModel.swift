//
//  SettingsModel.swift
//  HealthAssistant
//
//  Created by Арсений on 22.03.24.
//

import Foundation
import UIKit

struct  SettingsContentModel {
    var title: String
    
    static var array: [SettingsContentModel] = [
        .init(title: "Оцените нас"),
        .init(title: "Политика конфеденциальности"),
        .init(title: "Оставить отзыв"),
        .init(title: "Выйти из аккаунта"),
    ]
}
