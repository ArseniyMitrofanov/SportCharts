//
//  AdviceTableViewCell.swift
//  HealthAssistant
//
//  Created by Арсений on 22.04.24.
//

import UIKit

class AdviceTableViewCell: UITableViewCell {
    
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

    func configure(with text: String) {
        self.titleLabel.text = text
    }

}
