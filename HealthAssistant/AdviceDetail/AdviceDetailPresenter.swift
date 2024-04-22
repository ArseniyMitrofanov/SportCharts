//
//  AdviceDetailPresenter.swift
//  HealthAssistant
//
//  Created by Арсений on 22.04.24.
//

import Foundation

protocol IAdviceDetailPresenter {
    func viewDidload()
}

final class AdviceDetailPresenter: IAdviceDetailPresenter {
    private unowned var viewController: IAdviceDetailViewController
    private var type: AdviceType
    private var model: Advice
    
    init(viewController: IAdviceDetailViewController, type: AdviceType, model: Advice) {
        self.viewController = viewController
        self.type = type
        self.model = model
    }
    
    func viewDidload() {
        self.viewController.configure(with: model, type: type)
    }
}
