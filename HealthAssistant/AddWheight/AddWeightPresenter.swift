//
//  AddWheightPresenter.swift
//  HealthAssistant
//
//  Created by Арсений on 15.04.24.
//

import Foundation

protocol IAddWeightPreesenter {
    func addButtonTapped()
    func backButtonTouhUpInside()
}

final class AddWeightPresenter: IAddWeightPreesenter {
    
    private unowned var viewController: IAddWeightViewController
    
    init(viewController: IAddWeightViewController) {
        self.viewController = viewController
    }
    
    func addButtonTapped() {
        
    }
    
    func backButtonTouhUpInside() {
        self.viewController.selfDismiss()
    }
}

