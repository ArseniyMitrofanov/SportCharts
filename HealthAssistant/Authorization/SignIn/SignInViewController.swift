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
    func emailText() -> String?
    func passwordText() -> String?
    func showForgotPasswordScreen(email: String)
    func endEditing()
    func showAlert(title: String, message: String)
}

final class SignInViewController: UIViewController {
    var presenter: ISignInPresenter?
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }
    
    @IBAction func forgotPasswordButtonTapped(_ sender: Any) {
        self.presenter?.forgotPasswordButtonTapped()
    }
    
    @IBAction func signInButtonTouchUpInside(_ sender: Any) {
        self.presenter?.signInButtonTouchUpInside()
    }
    
    @IBAction func createAccountTouchUpInside(_ sender: Any) {
        self.presenter?.createAccountTouchUpInside()
    }
}

extension SignInViewController: ISignInViewController {
    func showForgotPasswordScreen(email: String) {
        self.navigationController?.pushViewController(ForgotPasswordModuleBuilder.setupModule(email: email), animated: true)
    }
    
    func showAlert(title: String, message: String) {
        self.presentNativeAlert(title: title, message: message)
    }
    
    func endEditing() {
        self.view.endEditing(true)
    }
    
    func emailText() -> String? {
        return emailTextField.text
    }
    
    func passwordText() -> String? {
        return passwordTextField.text
    }
    
    func showCreateAccountScreen() {
        self.navigationController?.pushViewController(CreateAccountModuleBuilder.setupModule(), animated: true)
    }
    
    func showTabbar() {
        self.navigationController?.viewControllers = [TabbarController()]
    }
}

extension SignInViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
    }
}

private extension SignInViewController {
    func setupUI() {
        self.emailTextField.delegate = self
        self.passwordTextField.delegate = self
    }
}
