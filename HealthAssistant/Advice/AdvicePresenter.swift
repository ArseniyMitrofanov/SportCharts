//
//  NutritionPresenter.swift
//  HealthAssistant
//
//  Created by Арсений on 22.04.24.
//

import Foundation

enum AdviceType {
    case nutrition
    case exercise
}

protocol IAdvicePresenter {
    func viewDidLoad()
}

final class AdvicePresenter: IAdvicePresenter {
    private unowned var viewController: IAdviceViewController
    private var type: AdviceType
    
    init(viewController: IAdviceViewController, type: AdviceType) {
        self.viewController = viewController
        self.type = type
    }
    
    func viewDidLoad() {
        let text = self.type == .nutrition ? "Рецепты" : "Программы тренировок"
        self.viewController.setTitleText(text)
    }
}

