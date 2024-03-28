//
//  SplashViewController.swift
//  HealthAssistant
//
//  Created by Арсений on 28.03.24.
//

import Foundation
import UIKit

protocol ISplashViewController: AnyObject {
    
}

final class SplashViewController: UIViewController {
    var presenter: ISplashPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }
}

extension SplashViewController: ISplashViewController {
    
}

private extension SplashViewController {
    func setupUI()  {
        
    }
}
