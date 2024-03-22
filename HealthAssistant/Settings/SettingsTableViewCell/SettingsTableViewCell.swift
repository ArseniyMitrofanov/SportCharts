//
//  SettingsTableViewCell.swift
//  HealthAssistant
//
//  Created by Арсений on 22.03.24.
//

import UIKit

class SettingsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var customContentView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.customContentView.layer.borderColor = UIColor.white.cgColor
        self.customContentView.layer.borderWidth = 2
        self.customContentView.layer.cornerRadius = 15
        self.customContentView.clipsToBounds = true
        self.customContentView.layer.masksToBounds = true
        self.titleLabel.textColor = .white
    }
    
    func configure(with model: SettingsContentModel) {
        self.titleLabel.text = model.title
    }
    
    
}
