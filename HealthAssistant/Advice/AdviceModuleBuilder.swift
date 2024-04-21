//
//  AdviceModuleBuilder.swift
//  HealthAssistant
//
//  Created by Арсений on 22.04.24.
//

import Foundation
import UIKit

enum AdviceModuleBuilder {
    static func setupModule(type: AdviceType) -> AdviceViewController {
        guard let viewController = UIStoryboard(name: "AdviceStoryboard", bundle: nil)
            .instantiateViewController(withIdentifier: "AdviceViewController") as? AdviceViewController else {
            print("ERROR: failed to instantiate AdviceController")
            return AdviceViewController()
        }
        let presenter = AdvicePresenter(viewController: viewController, type: type)
        viewController.presenter = presenter
        return viewController
    }
}
