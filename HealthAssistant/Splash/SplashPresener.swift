//
//  SplashPresener.swift
//  HealthAssistant
//
//  Created by Арсений on 28.03.24.
//

import Foundation

protocol ISplashPresenter {
    
}

final class SplashPresenter: ISplashPresenter {
    private unowned var viewController: ISplashViewController
    
    init(viewController: ISplashViewController) {
        self.viewController = viewController
    }
}
