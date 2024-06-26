//
//  SignInPresenter.swift
//  HealthAssistant
//
//  Created by Арсений on 28.03.24.
//

import Foundation

protocol ISignInPresenter {
    func signInButtonTouchUpInside()
    func createAccountTouchUpInside()
    func forgotPasswordButtonTapped()
}

final class SignInPresenter: ISignInPresenter {
    private unowned var viewController: ISignInViewController
    
    init(viewController: ISignInViewController) {
        self.viewController = viewController
    }
    
    func signInButtonTouchUpInside() {
        FirebaseManager.logEvent("signInButtonTapped")
        self.viewController.endEditing()
        let emailText = self.viewController.emailText()
        if Validator.email(from: emailText) {
            let passwordText = self.viewController.passwordText()
            if Validator.password(from: passwordText) {
                let request = AuthorizationRequest(email: emailText!, password: passwordText!)
                self.sendSignInRequest(request: request)
            }else {
                self.viewController.showAlert(title: "Неверно заполнено поле пароль", message: "Пароль может содержать только латинские буквы, цифры и специальные символы")
            }
        }else {
            self.viewController.showAlert(title: "Неверно заполнено поле email", message: "")
        }
    }
    
    func createAccountTouchUpInside() {
        FirebaseManager.logEvent("signInCreateTapped")
        self.viewController.showCreateAccountScreen()
    }
    
    func forgotPasswordButtonTapped() {
        FirebaseManager.logEvent("signInForgotTapped")
        let emailText = self.viewController.emailText()
        if Validator.email(from: emailText) {
            self.sendForgotPasswordRequest(email: emailText!)
        }else {
            self.viewController.showAlert(title: "Неверно заполнено поле email", message: "")
        }
    }
}

private extension SignInPresenter {
    func sendSignInRequest(request: AuthorizationRequest) {
        let json = request.encode()
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        
        if let url = URL(string:  "https://healthassistant-production.up.railway.app/api/v1.0/auth/login") {
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
                print("SIGN IN STATUS : \(httpResponse.statusCode)")
                if (httpResponse.statusCode >= 200) && (httpResponse.statusCode < 300) && tokens != nil{
                    print("Success")
                    AppFileManager.shared.saveTokens(tokens: tokens!)
                    DispatchQueue.main.async {
                        self.viewController.showTabbar()
                    }
                }else {
                    print("Failure")
                    DispatchQueue.main.async {
                        self.viewController.showAlert(title: "Не удалось войти", message: "")
                    }
                }
            }
            .resume()
        }
    }
    
    func sendForgotPasswordRequest(email: String) {
        if let url = URL(string:  "https://healthassistant-production.up.railway.app/api/v1.0/auth/forgot-password") {
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = "POST"
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            let json: [String: Any] = ["username": email ]
            let jsonData = try? JSONSerialization.data(withJSONObject: json)
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
                    DispatchQueue.main.async {
                        self.viewController.showForgotPasswordScreen(email: email)
                    }
                }else {
                    DispatchQueue.main.async {
                        self.viewController.showAlert(title: "Не удалось восстановить пароль для этой почты", message: "")
                    }
                }
                
            }
            .resume()
        }
    }
}
