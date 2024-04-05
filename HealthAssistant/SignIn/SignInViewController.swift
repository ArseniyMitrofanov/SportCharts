//
//  File.swift
//  HealthAssistant
//
//  Created by Арсений on 28.03.24.
//

import Foundation
import UIKit

protocol ISignInViewController: AnyObject {
    func showCreateAccountScreen()
    func showTabbar()
}

final class SignInViewController: UIViewController {
    var presenter: ISignInPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }
    @IBAction func signInButtonTouchUpInside(_ sender: Any) {
        self.presenter?.signInButtonTouchUpInside()
    }
    @IBAction func createAccountTouchUpInside(_ sender: Any) {
        self.presenter?.createAccountTouchUpInside()
    }
}

extension SignInViewController: ISignInViewController {
    func showCreateAccountScreen() {
        self.navigationController?.pushViewController(CreateAccountModuleBuilder.setupModule(), animated: true)
    }
    
    func showTabbar() {
        self.navigationController?.viewControllers = [TabbarController()]
    }
}

private extension SignInViewController {
    func setupUI() {
        
    }
}
