//
//  AddWheightButtonTapped.swift
//  HealthAssistant
//
//  Created by Арсений on 15.04.24.
//

import Foundation
import UIKit

protocol IAddWeightViewController: AnyObject {
    func selfDismiss()
}

final class AddWeightViewController: UIViewController {
    var presenter: IAddWeightPreesenter?
    
    @IBOutlet weak var backButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }
    @IBAction func backButtonTouhUpInside(_ sender: Any) {
        self.presenter?.backButtonTouhUpInside()
    }
}

extension AddWeightViewController: IAddWeightViewController {
    func selfDismiss() {
        self.dismiss(animated: true)
    }
}

private extension AddWeightViewController {
    func setupUI() {
        self.backButton.setTitle("", for: .normal)
    }
}
