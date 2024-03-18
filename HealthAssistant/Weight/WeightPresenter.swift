//
//  WeightPresenter.swift
//  HealthAssistant
//
//  Created by Арсений on 21.02.24.
//

import Foundation

protocol IWeightPreesenter {
    
}

final class WeightPresenter: IWeightPreesenter {
    
    private unowned var viewController: IWeightViewController
    
    init(viewController: IWeightViewController) {
        self.viewController = viewController
    }
}
