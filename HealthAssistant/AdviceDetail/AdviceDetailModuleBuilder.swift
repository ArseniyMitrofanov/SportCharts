//
//  AdviceDetailModuleBuilder.swift
//  HealthAssistant
//
//  Created by Арсений on 22.04.24.
//

import Foundation
import UIKit

enum AdviceDetailModuleBuilder {
    static func setupModule(type: AdviceType, model: Advice) -> AdviceDetailViewController {
        guard let viewController = UIStoryboard(name: "AdviceDetailStoryboard", bundle: nil)
            .instantiateViewController(withIdentifier: "AdviceDetailViewController") as? AdviceDetailViewController else {
            print("ERROR: failed to instantiate AdviceDetailController")
            return AdviceDetailViewController()
        }
        let presenter = AdviceDetailPresenter(viewController: viewController, type: type, model: model)
        viewController.presenter = presenter
        return viewController
    }
}

