//
//  SettingsViewController.swift
//  HealthAssistant
//
//  Created by Арсений on 21.02.24.
//

import Foundation
import UIKit
import MessageUI

protocol ISettingsViewController: AnyObject {
    func showSignInScreen()
    func presentEmailAlert()
}

final class SettingsViewController: UIViewController {
    var presenter: ISettingsPresenter?
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }
}

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        SettingsContentModel.array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsTableViewCell", for: indexPath)
        if let cell = cell as? SettingsTableViewCell {
            cell.configure(with: presenter?.getModel(for: indexPath) ?? .init(title: "error: settingsPresenter is nil!"))
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.presenter?.didSelectCell(at: indexPath)
    }
}

extension SettingsViewController: ISettingsViewController {
    func showSignInScreen() {
        self.navigationController?.viewControllers = [SignInModuleBuilder.setupModule()]
    }
    
    func presentEmailAlert() {
        let recipient: String = "arseniy.mitrafanau@gmail.com"
        let messageBody: String = ""
       
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients([recipient])
            mail.setMessageBody(messageBody, isHTML: true)
            present(mail, animated: true)
        } else {
            let alert = UIAlertController(title: "", message: "Напишите нам на почту:" + "\n\(recipient)", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ок", style: .default))
            present(alert, animated: true)
        }
    }
}

extension SettingsViewController: MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
}

private extension SettingsViewController {
    func setupUI() {
        self.setupTableView()
    }
    
    func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UINib(nibName: "SettingsTableViewCell", bundle: nil), forCellReuseIdentifier: "SettingsTableViewCell")
    }
}

