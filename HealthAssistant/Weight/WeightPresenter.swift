//
//  WeightPresenter.swift
//  HealthAssistant
//
//  Created by Арсений on 21.02.24.
//

import Foundation

protocol IWeightPreesenter {
    func addWheightButtonTapped()
}

final class WeightPresenter: IWeightPreesenter {
    
    private unowned var viewController: IWeightViewController
    
    init(viewController: IWeightViewController) {
        self.viewController = viewController
    }
    
    func addWheightButtonTapped() {
        self.viewController.showAddWheightScreen()
    }
}
