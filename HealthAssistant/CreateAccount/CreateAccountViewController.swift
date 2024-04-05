//
//  CreateAccountViewController.swift
//  HealthAssistant
//
//  Created by Арсений on 3.04.24.
//

import Foundation
import UIKit

protocol ICreateAccountViewController: AnyObject {
    func selfDismiss()
}

final class CreateAccountViewController: UIViewController {
    
    var presenter: ICreateAccountPresenter?
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func backButtonTouchupInside(){
        self.presenter?.backButtonTouchupInside()
    }
}

extension CreateAccountViewController: ICreateAccountViewController {
    func selfDismiss() {
        self.navigationController?.popViewController(animated: true)
    }
}

