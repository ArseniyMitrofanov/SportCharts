//
//  SettingsModuleBuilder.swift
//  HealthAssistant
//
//  Created by Арсений on 21.02.24.
//

import Foundation
import UIKit

enum SettingsModuleBuilder {
    static func setupModule() -> SettingsViewController {
        guard let viewController = UIStoryboard(name: "SettingsStoryboard", bundle: nil)
            .instantiateViewController(withIdentifier: "SettingsViewController") as? SettingsViewController else {
            print("ERROR: failed to instantiate SettingsViewController")
            return SettingsViewController()
        }
        let presenter = SettingsPresenter(viewController: viewController)
        viewController.presenter = presenter
        return viewController
    }
}
