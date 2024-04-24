//
//  CreateAccountModuleBuilder.swift
//  HealthAssistant
//
//  Created by Арсений on 3.04.24.
//

import Foundation
import UIKit

enum CreateAccountModuleBuilder {
    static func setupModule() -> CreateAccountViewController {
        guard let viewController = UIStoryboard(name: "CreateAccountStoryboard", bundle: nil)
            .instantiateViewController(withIdentifier: "CreateAccountViewController") as? CreateAccountViewController else {
            print("ERROR: failed to instantiate CreateAccountViewController")
            return CreateAccountViewController()
        }
        
        let presenter = CreateAccountPresenter(viewController: viewController)
        viewController.presenter = presenter
        return viewController
    }
}



