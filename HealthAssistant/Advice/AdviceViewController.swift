//
//  NutritionViewController.swift
//  HealthAssistant
//
//  Created by Арсений on 21.04.24.
//

import Foundation
import UIKit

protocol IAdviceViewController: AnyObject {
    func setTitleText(_ text: String)
}

final class AdviceViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    var presenter: IAdvicePresenter?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter?.viewDidLoad()
    }
}

extension AdviceViewController: IAdviceViewController {
    func setTitleText(_ text: String) {
        self.titleLabel.text = text
    }
    
    
}
