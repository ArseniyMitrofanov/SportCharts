//
//  NutritionViewController.swift
//  HealthAssistant
//
//  Created by Арсений on 21.04.24.
//

import Foundation
import UIKit

protocol IAdviceViewController: AnyObject {
    func setTitleText(_ text: String)
    func reloadTableView()
}

final class AdviceViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    var presenter: IAdvicePresenter?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter?.viewDidLoad()
        self.setupTableView()
    }
}

extension AdviceViewController: IAdviceViewController {
    func reloadTableView() {
        self.tableView.reloadData()
    }
    
    func setTitleText(_ text: String) {
        self.titleLabel.text = text
    }
}

extension AdviceViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter?.getCellCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AdviceTableViewCell", for: indexPath)
        if let cell = cell as? AdviceTableViewCell {
            cell.configure(with: presenter?.getText(for: indexPath) ?? "error: advicePresenter is nil!")
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.presenter?.didSelectCell(at: indexPath)
    }
    
    
    func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UINib(nibName: "AdviceTableViewCell", bundle: nil), forCellReuseIdentifier: "AdviceTableViewCell")
    }
}
