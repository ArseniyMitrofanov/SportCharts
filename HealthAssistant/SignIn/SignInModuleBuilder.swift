//
//  SignInModuleBuilder.swift
//  HealthAssistant
//
//  Created by Арсений on 28.03.24.
//

import Foundation
import UIKit

enum SignInModuleBuilder {
    static func setupModule() -> SignInViewController {
        guard let viewController = UIStoryboard(name: "SignInViewController", bundle: nil)
            .instantiateViewController(withIdentifier: "SignInViewController") as? SignInViewController else {
            print("ERROR: failed to instantiate SignInViewController")
            return SignInViewController()
        }
        
        let presenter = SignInPresenter(viewController: viewController)
        viewController.presenter = presenter
        return viewController
    }
}
