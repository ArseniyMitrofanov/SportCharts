//
//  SettingsViewController.swift
//  HealthAssistant
//
//  Created by Арсений on 21.02.24.
//

import Foundation
import UIKit

protocol ISettingsViewController: AnyObject {
    
}

final class SettingsViewController: UIViewController {
    var presenter: ISettingsPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

extension SettingsViewController: ISettingsViewController {
    
}

private extension SettingsViewController {
    func setupUI() {
        
    }
}

