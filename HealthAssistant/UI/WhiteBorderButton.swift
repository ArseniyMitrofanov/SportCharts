//
//  WhiteBirderButton.swift
//  HealthAssistant
//
//  Created by Арсений on 22.03.24.
//

import Foundation
import UIKit

final class WhiteBorderButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        makeCustomAppearance()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        makeCustomAppearance()
    }
    
    private func makeCustomAppearance() {
        self.backgroundColor = .clear
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.borderWidth = 2
        self.layer.cornerRadius = 15
        self.clipsToBounds = true
        self.layer.masksToBounds = true
        self.setTitleColor(.white, for: .normal)
        self.setTitleColor(UIColor(white: 0.9, alpha: 0.5), for: .highlighted)
    }
}
