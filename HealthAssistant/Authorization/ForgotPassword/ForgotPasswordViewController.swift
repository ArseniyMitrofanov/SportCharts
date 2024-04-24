//
//  ForgotPasswordViewController.swift
//  HealthAssistant
//
//  Created by Арсений on 21.04.24.
//

import Foundation
import UIKit

protocol IForgotPasswordViewController: AnyObject {
    func selfDismiss()
    func setEmailLabeltext(_ text: String)
    func keyText() -> String?
    func passwordText() -> String?
    func repeatPasswordText() -> String?
    func showAlert(title: String, message: String)
    func showTabbar()
    func showPasswordTextFields()
}

final class ForgotPasswordViewController: UIViewController {
    var presenter: IForgotPasswordPresenter?
    
    @IBOutlet weak var emailLabel: UILabel!
    
    @IBOutlet weak var passwordStackView: UIStackView!
    @IBOutlet weak var passwortTextField: UITextField!
    
    @IBOutlet weak var repeatPasswordStackView: UIStackView!
    @IBOutlet weak var repeatPasswortTextField: UITextField!
    
    @IBOutlet weak var keyStackView: UIStackView!
    @IBOutlet weak var keyTextField: UITextField!
    
    @IBOutlet weak var nextButton: WhiteBorderButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter?.viewDidLoad()
    }
    @IBAction func nextButtonTouchUpInside(_ sender: Any) {
        self.presenter?.nextButtonTouchUpInside()
    }
    @IBAction func backButtonTouchUpInside(_ sender: Any) {
        self.presenter?.backButtonTouchUpInside()
    }
}

extension ForgotPasswordViewController: IForgotPasswordViewController {
    func passwordText() -> String? {
        return passwortTextField.text
    }
    
    func repeatPasswordText() -> String? {
        return repeatPasswortTextField.text
    }
    
    func showPasswordTextFields() {
        self.keyStackView.isHidden = true
        self.emailLabel.isHidden = true
        self.passwordStackView.isHidden = false
        self.repeatPasswordStackView.isHidden = false
        self.nextButton.setTitle("Установить", for: .normal)
    }
    
    func showAlert(title: String, message: String) {
        self.presentNativeAlert(title: title, message: message)
    }
    
    func showTabbar() {
        self.navigationController?.viewControllers = [TabbarController()]
    }
    
    func keyText() -> String? {
        return keyTextField.text
    }
    
    func setEmailLabeltext(_ text: String) {
        self.emailLabel.text?.append(" " + text)
    }
    
    func selfDismiss() {
        self.navigationController?.popViewController(animated: true)
    }
}
