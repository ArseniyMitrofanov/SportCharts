//
//  CreateAccountPresenter.swift
//  HealthAssistant
//
//  Created by Арсений on 3.04.24.
//

import Foundation

protocol ICreateAccountPresenter {
    func backButtonTouchupInside()
    func createButtonTouchUpInside()
}

final class CreateAccountPresenter: ICreateAccountPresenter {
    private unowned var viewController: ICreateAccountViewController
    private var hasSentKey = false
    private var request: AuthorizationRequest?
    
    init(viewController: ICreateAccountViewController) {
        self.viewController = viewController
    }
    
    func backButtonTouchupInside() {
        self.viewController.selfDismiss()
    }
    
    func createButtonTouchUpInside() {
        
        if !self.hasSentKey {
            self.continueAction()
        }else {
            self.createAction()
        }
    }
}

private extension CreateAccountPresenter {
    
    func continueAction() {
        self.viewController.endEditing()
        let emailText = self.viewController.emailText()
        if Validator.email(from: emailText) {
            let passwordText = self.viewController.passwordText()
            if Validator.password(from: passwordText) {
                let repeatPasswordText = self.viewController.repeatPasswordText()
                if Validator.password(from: repeatPasswordText) {
                    if passwordText == repeatPasswordText {
                        let request = AuthorizationRequest(email: emailText!, password: passwordText!)
                        self.request = request
                        self.sendCreateAccountRequest(request: request)
                    }else {
                        self.viewController.showAlert(title: "Пароли не совпадают", message: "")
                    }
                }else {
                    self.viewController.showAlert(title: "Неверно заполнено поле повтора пароля", message: "Пароль может содержать только латинские буквы, цифры и специальные символы")
                }
            }else {
                self.viewController.showAlert(title: "Неверно заполнено поле пароль", message: "Пароль может содержать только латинские буквы, цифры и специальные символы")
            }
        }else {
            self.viewController.showAlert(title: "Неверно заполнено поле email", message: "")
        }
    }
    
    func createAction() {
        self.viewController.endEditing()
        if let request = self.request,
           Validator.key(from: self.viewController.keyText()) {
            let key = self.viewController.keyText()
            self.sendKeyRequest(request: request, key: key!)
        }else {
            self.viewController.showAlert(title: "Неверно заполнено поле ключ", message: "Ключ должен содержать только 6 цыфр")
        }
    }
    
    
    func sendCreateAccountRequest(request: AuthorizationRequest) {
        let json = request.encode()
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        
        if let url = URL(string:  "https://healthassistant-production.up.railway.app/api/v1.0/auth/register") {
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
                    DispatchQueue.main.async {
                        self.hasSentKey = true
                        self.viewController.showKeyContent()
                    }
                }else {
                    print("Failure")
                    DispatchQueue.main.async {
                        self.viewController.showAlert(title: "Не удалось сделать запрос на создание аккаунта", message: "")
                    }
                }
            }
            .resume()
        }
    }
    
    func sendKeyRequest(request: AuthorizationRequest, key: String) {
        let json = request.encode()
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        
        if let url = URL(string:  "https://healthassistant-production.up.railway.app/api/v1.0/auth/activate/\(key)") {
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
                let tokens = try? JSONDecoder().decode(Tokens.self, from: data)
                let httpResponse = response as! HTTPURLResponse
                print("STATUS : \(httpResponse.statusCode)")
                if (httpResponse.statusCode >= 200) && (httpResponse.statusCode < 300) && tokens != nil {
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

