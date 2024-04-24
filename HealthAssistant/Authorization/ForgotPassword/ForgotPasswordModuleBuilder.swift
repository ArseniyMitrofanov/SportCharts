//
//  ForgotPasswordModuleBuilder.swift
//  HealthAssistant
//
//  Created by Арсений on 21.04.24.
//

import Foundation
import UIKit

enum ForgotPasswordModuleBuilder {
    static func setupModule(email: String) -> ForgotPasswordViewController {
        guard let viewController = UIStoryboard(name: "ForgotPasswordStoryboard", bundle: nil)
            .instantiateViewController(withIdentifier: "ForgotPasswordViewController") as? ForgotPasswordViewController else {
            print("ERROR: failed to instantiate ForgotPasswordController")
            return ForgotPasswordViewController()
        }
        let presenter = ForgotPasswordPresenter(viewController: viewController, email: email)
        viewController.presenter = presenter
        return viewController
    }
}
