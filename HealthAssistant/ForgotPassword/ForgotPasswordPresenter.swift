//
//  ForgotPasswordPresenter.swift
//  HealthAssistant
//
//  Created by Арсений on 21.04.24.
//

import Foundation

protocol IForgotPasswordPresenter {
    func nextButtonTouchUpInside()
    func viewDidLoad()
    func backButtonTouchUpInside()
}

final class ForgotPasswordPresenter: IForgotPasswordPresenter {
    private unowned var viewController: IForgotPasswordViewController
    private var email: String
    private var didvalidateKey = false
    private var key = ""
    
    init(viewController: IForgotPasswordViewController, email: String) {
        self.viewController = viewController
        self.email = email
    }
    
    func viewDidLoad() {
        self.viewController.setEmailLabeltext(self.email)
    }
    
    func nextButtonTouchUpInside() {
        if !didvalidateKey {
            let key = self.viewController.keyText()
            if Validator.key(from: key) {
                self.key = key!
                self.sendKey(key!)
            }else {
                viewController.showAlert(title: "Неверно заполнено поле ключ", message: "Ключ должен содержать только 6 цыфр")
            }
        }else {
            let passwordText = self.viewController.passwordText()
            if Validator.password(from: passwordText) {
                let repeatPasswordText = self.viewController.repeatPasswordText()
                if Validator.password(from: repeatPasswordText) {
                    if passwordText == repeatPasswordText {
                        self.sendNewPassword(passwordText!)
                    }else {
                        self.viewController.showAlert(title: "Пароли не совпадают", message: "")
                    }
                }else {
                    self.viewController.showAlert(title: "Неверно заполнено поле повтора пароля", message: "Пароль может содержать только латинские буквы, цифры и специальные символы")
                }
            }else {
                self.viewController.showAlert(title: "Неверно заполнено поле пароль", message: "Пароль может содержать только латинские буквы, цифры и специальные символы")
            }
        }
    }
    
    func backButtonTouchUpInside() {
        self.viewController.selfDismiss()
    }
}

extension ForgotPasswordPresenter {
    func sendKey(_ key: String) {
        if let url = URL(string:  "https://healthassistant-production.up.railway.app/api/v1.0/auth/verify-reset-code") {
            let json: [String: Any] = ["username": self.email, "code": key ]
            let jsonData = try? JSONSerialization.data(withJSONObject: json)
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = "POST"
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            urlRequest.httpBody = jsonData
            
            URLSession.shared.dataTask(with: urlRequest) {[weak self] data, response, error in
                guard let self = self else {return}
                guard let _ = data, error == nil else {
                    print(error?.localizedDescription ?? "No data")
                    return
                }
                let httpResponse = response as! HTTPURLResponse
                print("STATUS : \(httpResponse.statusCode)")
                if (httpResponse.statusCode >= 200) && (httpResponse.statusCode < 300) {
                    print("Success")
                    self.didvalidateKey = true
                    DispatchQueue.main.async {
                        self.viewController.showPasswordTextFields()
                    }
                }else {
                    DispatchQueue.main.async {
                        self.viewController.showAlert(title: "Не удалось подтвердить почту", message: "Проверьте ключ или попробуйте заново")
                    }
                }
            }
            .resume()
        }
    }
    
    func sendNewPassword(_ password: String) {
        if let url = URL(string:  "https://healthassistant-production.up.railway.app/api/v1.0/auth/reset-password") {
            let json: [String: Any] = ["username": self.email, "password": password, "code": self.key ]
            let jsonData = try? JSONSerialization.data(withJSONObject: json)
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = "POST"
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            urlRequest.httpBody = jsonData
            
            URLSession.shared.dataTask(with: urlRequest) {[weak self] data, response, error in
                guard let self = self else {return}
                guard let data = data, error == nil else {
                    print(error?.localizedDescription ?? "No data")
                    return
                }
                if let jsonString = String(data: data, encoding: .utf8) {
                    print("Received JSON: \(jsonString)")
                }
                
                let tokens = try? JSONDecoder().decode(Tokens.self, from: data)
                let httpResponse = response as! HTTPURLResponse
                print("STATUS : \(httpResponse.statusCode)")
                if (httpResponse.statusCode >= 200) && (httpResponse.statusCode < 300) && tokens != nil{
                    print("Success")
                    AppFileManager.shared.saveTokens(tokens: tokens!)
                    DispatchQueue.main.async {
                        self.viewController.showTabbar()
                    }
                }else {
                    print("Failure")
                    DispatchQueue.main.async {
                        self.viewController.showAlert(title: "Не удалось создать аккаунт", message: "")
                    }
                }
            }
            .resume()
        }
    }
}

