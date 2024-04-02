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
        switch indexPath.row {
        case 0: print("0")
        case 1: print("1")
        case 2: print("2")
        case 3: self.signOut()
        default: print("error: index out of range")
            self.signOut()
        }
    }
}

private extension SettingsPresenter {
    func signOut() {
        self.viewController.showSignInScreen()
    }
}
