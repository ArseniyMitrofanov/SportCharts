//
//  AddWheightPresenter.swift
//  HealthAssistant
//
//  Created by Арсений on 15.04.24.
//

import Foundation

protocol IAddWeightPresenter {
    func viewDidLoad()
    func addButtonTapped()
    func backButtonTouhUpInside()
    func pickerViewDidSelectRow(at row: Int)
}

final class AddWeightPresenter: IAddWeightPresenter {
    
    private unowned var viewController: IAddWeightViewController
    private var selectedWeightValue = 0
    private var currentDateString = ""
    init(viewController: IAddWeightViewController) {
        self.viewController = viewController
    }
    
    func addButtonTapped() {
        FirebaseManager.logEvent("addWeightAddTapped", parameters: ["weight": self.selectedWeightValue])
        self.sendNewWeight()
        self.viewController.selfDismiss()
    }
    
    func backButtonTouhUpInside() {
        FirebaseManager.logEvent("addWeightBackTapped")
        self.viewController.selfDismiss()
    }
    
    func pickerViewDidSelectRow(at row: Int) {
        self.selectedWeightValue = row
    }
    
    func viewDidLoad() {
        let dateText = "Сегодня: " + self.getCurrentDateTime()
        self.viewController.setDateLabelText(dateText)
    }
}

private extension AddWeightPresenter {
    func getCurrentDateTime() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy-HH:mm"
        self.currentDateString = formatter.string(from: Date())
        return self.currentDateString
    }
    
    func sendNewWeight() {
        let weight = WeightModel(weight: self.selectedWeightValue, dateTime: self.currentDateString)
        if let url = URL(string:  "https://healthassistant-production.up.railway.app/api/v1.0/weight"),
           let tokens = AppFileManager.shared.getTokens() {
            let json: [String: Any] = ["weight": weight.weight, "dateTime": weight.dateTime ]
            let jsonData = try? JSONSerialization.data(withJSONObject: json)
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = "POST"
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            urlRequest.httpBody = jsonData
            urlRequest.setValue( "Bearer \(tokens.accessToken)", forHTTPHeaderField: "Authorization")
            
            URLSession.shared.dataTask(with: urlRequest) {[weak self] data, response, error in
                guard let self = self else {return}
                guard let _ = data, error == nil else {
                    print(error?.localizedDescription ?? "No data")
                    return
                }
                let httpResponse = response as! HTTPURLResponse
                print("STATUS : \(httpResponse.statusCode)")
                if (httpResponse.statusCode >= 200) && (httpResponse.statusCode < 300) {
                    print("Success")
                    var arrayWeight = AppFileManager.shared.getWeightArray()
                    arrayWeight.append(weight)
                    if arrayWeight.count > 30 {
                        arrayWeight.removeFirst()
                    }
                    AppFileManager.shared.saveNewWeightArray(arrayWeight)
                }else if httpResponse.statusCode == 403 {
                    RefreshTokenManager.shared.updateTokens(with: tokens.token) { result in
                        if result {
                            self.sendNewWeight()
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



