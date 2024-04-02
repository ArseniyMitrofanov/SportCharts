//
//  SplashPresener.swift
//  HealthAssistant
//
//  Created by Арсений on 28.03.24.
//

import Foundation

protocol ISplashPresenter {
    func viewDidLoad()
}

final class SplashPresenter: ISplashPresenter {
    private unowned var viewController: ISplashViewController
    
    init(viewController: ISplashViewController) {
        self.viewController = viewController
    }
    
    func viewDidLoad() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute:  { [weak self] in
            guard let self = self else {return}
            self.viewController.presentSignIn()
        })
    }
}

private extension SplashPresenter {
    
}
