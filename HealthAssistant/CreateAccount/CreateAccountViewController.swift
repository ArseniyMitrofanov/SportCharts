//
//  CreateAccountViewController.swift
//  HealthAssistant
//
//  Created by Арсений on 3.04.24.
//

import Foundation
import UIKit

protocol ICreateAccountViewController: AnyObject {
    func selfDismiss()
    func endEditing()
    func emailText() -> String?
    func passwordText() -> String?
    func repeatPasswordText() -> String?
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
