//
//  SplashModuleBuilder.swift
//  HealthAssistant
//
//  Created by Арсений on 28.03.24.
//

import Foundation
import UIKit

enum SplashModuleBuilder {
    static func setupModule() -> SplashViewController {
        guard let viewController = UIStoryboard(name: "SplashStoryboard", bundle: nil)
            .instantiateViewController(withIdentifier: "SplashViewController") as? SplashViewController else {
            print("ERROR: failed to instantiate SplashViewController")
            return SplashViewController()
        }
        
        let presenter = SplashPresenter(viewController: viewController)
        viewController.presenter = presenter
        return viewController
    }
}

