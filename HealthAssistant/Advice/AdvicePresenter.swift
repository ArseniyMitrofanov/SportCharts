//
//  NutritionPresenter.swift
//  HealthAssistant
//
//  Created by Арсений on 22.04.24.
//

import Foundation

enum AdviceType {
    case nutrition
    case exercise
}

protocol IAdvicePresenter {
    func viewDidLoad()
    func getText(for indexPath: IndexPath) -> String
    func didSelectCell(at indexPath: IndexPath)
    func getCellCount() -> Int
}

final class AdvicePresenter: IAdvicePresenter {
    private unowned var viewController: IAdviceViewController
    private var type: AdviceType
    private var arrayModel: [Advice] = []
    init(viewController: IAdviceViewController, type: AdviceType) {
        self.viewController = viewController
        self.type = type
    }
    
    func viewDidLoad() {
        let text = self.type == .nutrition ? "Рецепты" : "Программы тренировок"
        self.viewController.setTitleText(text)
        fetchAdvice(type: self.type)
    }
    
    func getText(for indexPath: IndexPath) -> String {
        if indexPath.row < arrayModel.count {
            return arrayModel[indexPath.row].title
        }else {return "error"}
    }
    
    func getCellCount() -> Int {
        return arrayModel.count
    }
    
    func didSelectCell(at indexPath: IndexPath) {
        if indexPath.row < arrayModel.count {
            let model = arrayModel[indexPath.row]
            self.viewController.showDetailScreen(type: self.type, model: model)
            FirebaseManager.logEvent("adviceSelected", parameters: ["title": model.title])
        }
    }
}

private extension AdvicePresenter {
    func fetchAdvice(type: AdviceType) {
        let text = self.type == .nutrition ? "NUTRITION" : "EXERCISE"
        if let url = URL(string:  "https://healthassistant-production.up.railway.app/api/v1.0/advices?category=" + text) {
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = "GET"
            
            URLSession.shared.dataTask(with: urlRequest) {[weak self] data, response, error in
                guard let self = self else {return}
                guard let data = data, error == nil else {
                    print(error?.localizedDescription ?? "No data")
                    return
                }
                if let jsonString = String(data: data, encoding: .utf8) {
                    print("Received JSON: \(jsonString)")
                }
                let adviceArray = try? JSONDecoder().decode([Advice].self, from: data)
                let httpResponse = response as! HTTPURLResponse
                print("STATUS : \(httpResponse.statusCode)")
                print("STATUS : \(httpResponse.statusCode)")
                if (httpResponse.statusCode >= 200) && (httpResponse.statusCode < 300) && adviceArray != nil {
                    print("Success")
                    self.arrayModel = adviceArray!
                    DispatchQueue.main.async {
                        self.viewController.reloadTableView()
                    }
                }else {
                    print("Failure")
                }
                
            }
            .resume()
        }
    }
}
