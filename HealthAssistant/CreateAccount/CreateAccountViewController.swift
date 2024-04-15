//
//  CreateAccountViewController.swift
//  HealthAssistant
//
//  Created by Арсений on 3.04.24.
//

import Foundation
import UIKit

protocol ICreateAccountViewController: IViewController {
    func selfDismiss()
    func emailText() -> String?
    func passwordText() -> String?
    func repeatPasswordText() -> String?
    func showTabbar()
}

final class CreateAccountViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var repeatPasswordTextField: UITextField!
    
    var presenter: ICreateAccountPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }
    
    @IBAction func backButtonTouchupInside(){
        self.presenter?.backButtonTouchupInside()
    }
    @IBAction func createButtonTouchUpInside(_ sender: Any) {
        self.presenter?.createButtonTouchUpInside()
    }
}

extension CreateAccountViewController: ICreateAccountViewController {
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
    
    func repeatPasswordText() -> String? {
        return repeatPasswordTextField.text
    }
    
    func selfDismiss() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func showTabbar() {
        self.navigationController?.viewControllers = [TabbarController()]
    }
}

extension CreateAccountViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
}

private extension CreateAccountViewController {
    func setupUI() {
        self.emailTextField.delegate = self
        self.passwordTextField.delegate = self
        self.repeatPasswordTextField.delegate = self
    }
    
}
