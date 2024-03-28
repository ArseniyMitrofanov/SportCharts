//
//  SignInPresenter.swift
//  HealthAssistant
//
//  Created by Арсений on 28.03.24.
//

import Foundation

protocol ISignInPresenter {
    
}

final class SignInPresenter: ISignInPresenter {
    private unowned var viewController: ISignInViewController
    
    init(viewController: ISignInViewController) {
        self.viewController = viewController
    }
    
}
