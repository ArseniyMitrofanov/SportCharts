//
//  AdviceDetailViewController.swift
//  HealthAssistant
//
//  Created by Арсений on 22.04.24.
//

import Foundation
import UIKit

protocol IAdviceDetailViewController: AnyObject {
    func configure(with model: Advice, type: AdviceType)
}

final class AdviceDetailViewController: UIViewController {
    var presenter: IAdviceDetailPresenter?
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter?.viewDidload()
    }
}

extension AdviceDetailViewController: IAdviceDetailViewController {
    func configure(with model: Advice, type: AdviceType) {
        self.textView.text = model.text
        self.titleLabel.text = model.title
        if type == .exercise {
            self.imageView.image = UIImage(named: "gantelina")
        }
    }
    
    
}
