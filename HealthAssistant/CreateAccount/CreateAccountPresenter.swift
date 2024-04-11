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

}
