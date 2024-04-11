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
    
    init(viewController: ICreateAccountViewController) {
        self.viewController = viewController
    }
    
    func backButtonTouchupInside() {
        self.viewController.selfDismiss()
    }

    func createButtonTouchUpInside() {
        self.viewController.endEditing()
        
        if let email = viewController.emailText(),
           let password = viewController.passwordText(),
           let repeatPassword = viewController.repeatPasswordText(),
           password == repeatPassword {
            let request = AuthorizationRequest(email: email, password: password)
            self.sendCreateAccountRequest(request: request)
        }else {
            print("smth")
        }
    }
}

private extension CreateAccountPresenter {
    func sendCreateAccountRequest(request: AuthorizationRequest) {
        let json = request.encode()
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        
        if let url = URL(string:  "https://healthassistant-production.up.railway.app/api/v1.0/auth/register") {
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = "POST"
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            urlRequest.httpBody = jsonData

            URLSession.shared.dataTask(with: urlRequest) { data, response, error in
                guard let data = data, error == nil else {
                    print(error?.localizedDescription ?? "No data")
                    return
                }
                let decoder = JSONDecoder()
                let tokens = try? decoder.decode(Tokens.self, from: data)
                let httpResponse = response as! HTTPURLResponse
                print("SIGN IN STATUS : \(httpResponse.statusCode)")
                if (httpResponse.statusCode >= 200) && (httpResponse.statusCode < 300) && tokens != nil{
                    print( tokens!.accessToken)
                }else {
                    print("no")
                }
            }
            .resume()
        }
    }
}
