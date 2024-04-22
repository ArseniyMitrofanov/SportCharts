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
        if let tokens = AppFileManager.shared.getTokens() {
            RefreshTokenManager.shared.updateTokens(with: tokens.token) { result in
                if result {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute:  { [weak self] in
                        guard let self = self else {return}
                        self.viewController.presentTabbar()
                    })
                }else {
                    AppFileManager.shared.deleteTokens()
                    AppFileManager.shared.deleteWeightArray()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute:  { [weak self] in
                        guard let self = self else {return}
                        self.viewController.presentSignIn()
                    })
                }
            }
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute:  { [weak self] in
                guard let self = self else {return}
                self.viewController.presentSignIn()
            })
        }
    }
}

private extension SplashPresenter {
    
}
