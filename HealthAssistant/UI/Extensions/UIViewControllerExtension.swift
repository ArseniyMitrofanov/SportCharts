//
//  UIViewControllerExtension.swift
//  HealthAssistant
//
//  Created by Арсений on 11.04.24.
//

import Foundation
import UIKit

extension UIViewController {
    func presentNativeAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ок", style: .default))
        self.present(alert, animated: true)
    }
}
