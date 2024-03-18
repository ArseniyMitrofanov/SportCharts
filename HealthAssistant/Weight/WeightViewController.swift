//
//  WeightViewController.swift
//  HealthAssistant
//
//  Created by Арсений on 21.02.24.
//

import Foundation
import UIKit

protocol IWeightViewController: AnyObject {
    
}

final class WeightViewController: UIViewController {
    var presenter: IWeightPreesenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
}

extension WeightViewController: IWeightViewController {
    
}

private extension WeightViewController {
    func setupUI() {
        
    }
}

