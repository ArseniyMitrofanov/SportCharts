//
//  SplashViewController.swift
//  HealthAssistant
//
//  Created by Арсений on 28.03.24.
//

import Foundation
import UIKit

protocol ISplashViewController: AnyObject {
    func presentSignIn()
}

final class SplashViewController: UIViewController {
    var presenter: ISplashPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.presenter?.viewDidLoad()
    }
}

extension SplashViewController: ISplashViewController {
    func presentSignIn() {
        let viewController = SignInModuleBuilder.setupModule()
        self.navigationController?.viewControllers = [viewController]
    }
    
    
}

private extension SplashViewController {
    func setupUI()  {
        
    }
}
