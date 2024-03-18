//
//  SettingsPresenter.swift
//  HealthAssistant
//
//  Created by Арсений on 21.02.24.
//

import Foundation

protocol ISettingsPresenter {
    
}

final class SettingsPresenter: ISettingsPresenter {
    private unowned var viewController: ISettingsViewController
    
    init(viewController: ISettingsViewController) {
        self.viewController = viewController
    }
    
}
