//
//  AddWeightModuleBuilder.swift
//  HealthAssistant
//
//  Created by Арсений on 15.04.24.
//

import Foundation
import UIKit

enum AddWeightModuleBuilder {
    static func setupModule() -> AddWeightViewController {
        guard let viewController = UIStoryboard(name: "AddWeightStoryboard", bundle: nil)
            .instantiateViewController(withIdentifier: "AddWeightViewController") as? AddWeightViewController else {
            print("ERROR: failed to instantiate AddWeightViewController")
            return AddWeightViewController()
        }
        let presenter = AddWeightPresenter(viewController: viewController)
        viewController.presenter = presenter
        viewController.modalPresentationStyle = .fullScreen
        viewController.modalTransitionStyle = .coverVertical
        return viewController
    }
}

