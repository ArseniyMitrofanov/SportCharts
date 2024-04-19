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
    func setDateLabelText(_ text: String)
}

final class AddWeightViewController: UIViewController {
    var presenter: IAddWeightPresenter?
    
    @IBOutlet weak var pickerView: UIPickerView!
    
    @IBOutlet weak var addbutton: UIButton!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var backButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter?.viewDidLoad()
        self.setupUI()
    }
    @IBAction func backButtonTouhUpInside(_ sender: Any) {
        self.presenter?.backButtonTouhUpInside()
    }
}

extension AddWeightViewController: IAddWeightViewController {
    func setDateLabelText(_ text: String) {
        self.dateLabel.text = text
    }
    
    func selfDismiss() {
        self.dismiss(animated: true)
    }
}

extension AddWeightViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 701
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(row)
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.presenter?.pickerViewDidSelectRow(at: row)
    }
    
}

private extension AddWeightViewController {
    func setupUI() {
        self.backButton.setTitle("", for: .normal)
        self.setupAddButton()
        self.pickerView.delegate = self
        self.pickerView.dataSource = self
    }
    
    func setupAddButton() {
        self.addbutton.layer.cornerRadius = 15
        self.addbutton.clipsToBounds = true
        self.addbutton.layer.masksToBounds = true
    }
}
