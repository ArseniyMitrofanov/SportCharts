//
//  WeightPresenter.swift
//  HealthAssistant
//
//  Created by Арсений on 21.02.24.
//

import Foundation

protocol IWeightPreesenter {
    func addWheightButtonTapped()
    func viewDidLoad()
    func viewDidAppear()
    func didSelectValue(at index: Int)
    var arrayWeightModels: [WeightModel] {get}
    
}

final class WeightPresenter: IWeightPreesenter {
    
    
    var arrayWeightModels: [WeightModel] = []
    
    
    private unowned var viewController: IWeightViewController
    
    init(viewController: IWeightViewController) {
        self.viewController = viewController
    }
    
    
    func addWheightButtonTapped() {
        self.viewController.showAddWheightScreen()
    }
    
    func viewDidLoad() {
        self.fetchWeightArray()
    }
    
    func viewDidAppear() {
        self.drawChartFromFiles()
    }
    
    func didSelectValue(at index: Int) {
        if index < self.arrayWeightModels.count {
            let weightModel = self.arrayWeightModels[index]
            self.viewController.setSelectedDateLabelText("Измерено: \(weightModel.dateTime)\nВес: \(weightModel.weight) кг")
        }
    }
}

private extension WeightPresenter {
    
    func drawChartFromFiles() {
        self.arrayWeightModels = AppFileManager.shared.getWeightArray()
        self.checkForData()
        self.viewController.drawChart(with: self.arrayWeightModels.map({Double($0.weight)}))
    }
    
    func checkForData() {
        if self.arrayWeightModels.isEmpty {
            self.viewController.showNowDataStackView()
        }else {
            self.viewController.hideNowDataStackView()
        }
    }
    
    func fetchWeightArray() {
        if let url = URL(string:  "https://healthassistant-production.up.railway.app/api/v1.0/weight"),
           let tokens = AppFileManager.shared.getTokens() {
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = "GET"
            urlRequest.setValue( "Bearer \(tokens.accessToken)", forHTTPHeaderField: "Authorization")
            
            URLSession.shared.dataTask(with: urlRequest) {[weak self] data, response, error in
                guard let self = self else {return}
                guard let data = data, error == nil else {
                    print(error?.localizedDescription ?? "No data")
                    return
                }
                let weightArray = try? JSONDecoder().decode([WeightModel].self, from: data)
                let httpResponse = response as! HTTPURLResponse
                print("STATUS : \(httpResponse.statusCode)")
                if (httpResponse.statusCode >= 200) && (httpResponse.statusCode < 300) && weightArray != nil {
                    print("Success")
                    AppFileManager.shared.saveNewWeightArray(weightArray ?? [])
                    self.arrayWeightModels = weightArray ?? []
                    self.checkForData()
                    DispatchQueue.main.async {
                        self.viewController.drawChart(with: weightArray!.map({Double($0.weight)}))
                    }
                } else if httpResponse.statusCode == 403 {
                    RefreshTokenManager.shared.updateTokens(with: tokens.token) { result in
                        if result {
                            self.fetchWeightArray()
                        }else {
                            AppFileManager.shared.deleteTokens()
                            AppFileManager.shared.deleteWeightArray()
                            DispatchQueue.main.async {
                                self.viewController.showSignIn()
                            }
                        }
                    }
                }else {
                    print("Failure")
                }
            }
            .resume()
        }
    }
    
}
