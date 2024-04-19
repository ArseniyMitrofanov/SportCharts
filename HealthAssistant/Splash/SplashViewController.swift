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
    func presentTabbar()
}

final class SplashViewController: UIViewController {
    var presenter: ISplashPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter?.viewDidLoad()
    }
}

extension SplashViewController: ISplashViewController {
    func presentTabbar() {
        self.navigationController?.viewControllers = [TabbarController()]
    }
    
    func presentSignIn() {
        let viewController = SignInModuleBuilder.setupModule()
        self.navigationController?.viewControllers = [viewController]
    }
    
    
}
