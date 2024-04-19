//
//  AddWheightPresenter.swift
//  HealthAssistant
//
//  Created by Арсений on 15.04.24.
//

import Foundation

protocol IAddWeightPresenter {
    func viewDidLoad()
    func addButtonTapped()
    func backButtonTouhUpInside()
    func pickerViewDidSelectRow(at row: Int)
}

final class AddWeightPresenter: IAddWeightPresenter {
    
    private unowned var viewController: IAddWeightViewController
    private var selectedWeightValue = 0
    private var currentDateString = ""
    init(viewController: IAddWeightViewController) {
        self.viewController = viewController
    }
    
    func addButtonTapped() {
        
    }
    
    func backButtonTouhUpInside() {
        self.viewController.selfDismiss()
    }
    
    func pickerViewDidSelectRow(at row: Int) {
        self.selectedWeightValue = row
    }
    
    func viewDidLoad() {
        let dateText = "Сегодня: " + self.getCurrentDateTime()
        self.viewController.setDateLabelText(dateText)
    }
}

private extension AddWeightPresenter {
    func getCurrentDateTime() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy-HH:mm"
        self.currentDateString = formatter.string(from: Date())
        return self.currentDateString
    }
}

