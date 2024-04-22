//
//  SettingsPresenter.swift
//  HealthAssistant
//
//  Created by Арсений on 21.02.24.
//

import Foundation
import StoreKit

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
        case 0: self.rateUs()
        case 1: self.privacyPolicy()
        case 2: self.viewController.presentEmailAlert()
        case 3: self.signOut()
        default: print("error: index out of range")
            self.signOut()
        }
    }
}

private extension SettingsPresenter {
    func signOut() {
        AppFileManager.shared.deleteTokens()
        AppFileManager.shared.deleteWeightArray()
        self.viewController.showSignInScreen()
    }
    
    func rateUs() {
        if #available(iOS 14.0, *) {
                 if let windowScene = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene {
                     SKStoreReviewController.requestReview(in: windowScene)
                 }
             } else {
                 SKStoreReviewController.requestReview()
             }
    }
    
    func privacyPolicy() {
        if let url = URL(string: "https://www.unisender.com/ru/blog/politika-konfidencialnosti-na-sajte-dlya-chego-nuzhna-i-kak-sdelat/") {
            UIApplication.shared.open(url)
        }
    }
    
    
}
