//
//  WeightModuleBuilder.swift
//  HealthAssistant
//
//  Created by Арсений on 21.02.24.
//

import Foundation
import UIKit

enum WeightModuleBuilder {
    static func setupModule() -> WeightViewController {
        guard let viewController = UIStoryboard(name: "WeightStoryboard", bundle: nil)
            .instantiateViewController(withIdentifier: "WeightViewController") as? WeightViewController else {
            print("ERROR: failed to instantiate WeightViewController")
            return WeightViewController()
        }
        let presenter = WeightPresenter(viewController: viewController)
        viewController.presenter = presenter
        return viewController
    }
}
