//
//  WeightViewController.swift
//  HealthAssistant
//
//  Created by Арсений on 21.02.24.
//

import Foundation
import UIKit

protocol IWeightViewController: AnyObject {
    func showAddWheightScreen()
}

final class WeightViewController: UIViewController {
    var presenter: IWeightPreesenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    @IBAction func addWheightButtonTapped(_ sender: Any) {
        self.presenter?.addWheightButtonTapped()
    }
    
}

extension WeightViewController: IWeightViewController {
    func showAddWheightScreen() {
        self.present(AddWeightModuleBuilder.setupModule(), animated: true)
    }
}

private extension WeightViewController {
    func setupUI() {
        
    }
}

