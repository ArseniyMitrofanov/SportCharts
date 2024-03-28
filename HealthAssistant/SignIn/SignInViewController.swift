//
//  File.swift
//  HealthAssistant
//
//  Created by Арсений on 28.03.24.
//

import Foundation
import UIKit

protocol ISignInViewController: AnyObject {
    
}

final class SignInViewController: UIViewController {
    var presenter: ISignInPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }
}

extension SignInViewController: ISignInViewController {
    
}

private extension SignInViewController {
    func setupUI() {
        
    }
}
