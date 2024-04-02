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
}

final class SignInPresenter: ISignInPresenter {
    private unowned var viewController: ISignInViewController
    
    init(viewController: ISignInViewController) {
        self.viewController = viewController
    }
    
    func signInButtonTouchUpInside() {
        self.viewController.showTabbar()
    }
    
    func createAccountTouchUpInside() {
        self.viewController.showCreateAccountScreen()
    }
    
}
