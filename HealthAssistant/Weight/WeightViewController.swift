//
//  WeightViewController.swift
//  HealthAssistant
//
//  Created by Арсений on 21.02.24.
//

import Foundation
import UIKit
import DGCharts

protocol IWeightViewController: AnyObject {
    func showAddWheightScreen()
    func showSignIn()
    func drawChart(with values: [Double])
    func showNowDataStackView()
    func hideNowDataStackView()
    func setSelectedDateLabelText(_ text: String)
}

final class WeightViewController: UIViewController {
    var presenter: IWeightPreesenter?
    
    @IBOutlet weak var chartContainer: UIView!
    
    @IBOutlet weak var noDataStackView: UIStackView!
    
    @IBOutlet weak var selectedDateLabel: UILabel!
    
    private let chartView = Chart()
    
    
    override func viewDidAppear(_ animated: Bool) {
        self.presenter?.viewDidAppear()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        self.presenter?.viewDidLoad()
    }
    @IBAction func addWheightButtonTapped(_ sender: Any) {
        self.presenter?.addWheightButtonTapped()
    }
    
}

extension WeightViewController: IWeightViewController {
    func setSelectedDateLabelText(_ text: String) {
        self.selectedDateLabel.text = text
    }
    
    func showNowDataStackView() {
        DispatchQueue.main.async {[weak self] in
            guard let self = self else {return}
            self.noDataStackView.isHidden = false
            self.selectedDateLabel.isHidden = true
            self.chartContainer.isHidden = true
        }
    }
    
    func hideNowDataStackView() {
        DispatchQueue.main.async {[weak self] in
            guard let self = self else {return}
            self.noDataStackView.isHidden = true
            self.selectedDateLabel.isHidden = false
            self.chartContainer.isHidden = false
        }
    }
    
    func drawChart(with values: [Double]) {
        self.chartView.setupChart(with_: values)
    }
    
    func showSignIn() {
        self.navigationController?.viewControllers = [SignInModuleBuilder.setupModule()]
        AppFileManager.shared.deleteTokens()
        
    }
    
    func showAddWheightScreen() {
        self.present(AddWeightModuleBuilder.setupModule(), animated: true)
    }
}

extension WeightViewController: ChartViewDelegate {
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        let index = Int(entry.x)
        self.presenter?.didSelectValue(at: index)
    }
}

private extension WeightViewController {
    func setupUI() {
        setupChartView()
    }
    
    func setupChartView() {
        self.chartView.view.translatesAutoresizingMaskIntoConstraints = false
        chartContainer.addSubview(chartView.view)
        NSLayoutConstraint.activate([
            chartView.view.topAnchor.constraint(equalTo: chartContainer.topAnchor, constant: 5),
            chartView.view.bottomAnchor.constraint(equalTo: chartContainer.bottomAnchor, constant: -5),
            chartView.view.leadingAnchor.constraint(equalTo: chartContainer.leadingAnchor, constant: 5),
            chartView.view.trailingAnchor.constraint(equalTo: chartContainer.trailingAnchor, constant: -5)
        ])
        
        chartView.view.delegate = self
    }
}

