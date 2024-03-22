//
//  SettingsPresenter.swift
//  HealthAssistant
//
//  Created by Арсений on 21.02.24.
//

import Foundation

protocol ISettingsPresenter {
    func didSelectCell(at indexPath: IndexPath)
    func getModel(for indexPath: IndexPath) -> SettingsContentModel
}

final class SettingsPresenter: ISettingsPresenter {
    private unowned var viewController: ISettingsViewController
    
    init(viewController: ISettingsViewController) {
        self.viewController = viewController
    }
    
    func getModel(for indexPath: IndexPath) -> SettingsContentModel {
        return indexPath.row <= SettingsContentModel.array.count ? SettingsContentModel.array[indexPath.row] : .init(title: "error: settings index out of range")
    }
    
    func didSelectCell(at indexPath: IndexPath) {
        print(indexPath.row)
    }
}
