//
//  UserDefaultsManager.swift
//  HealthAssistant
//
//  Created by Арсений on 15.04.24.
//

import Foundation

final class AppFileManager {
    static let shared = AppFileManager()
    private init() {}
    
    private let weightArrayFileUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("weightArray.json")
    
    func saveTokens(tokens: Tokens) {
        UserDefaults.standard.setValue(tokens.accessToken, forKey: "accessToken")
        UserDefaults.standard.setValue(tokens.token, forKey: "refreshToken")
    }
    
    func deleteTokens() {
        UserDefaults.standard.setValue(nil, forKey: "accessToken")
        UserDefaults.standard.setValue(nil, forKey: "refreshToken")
    }
    
    func getTokens() -> Tokens? {
        if let accessToken = UserDefaults.standard.string(forKey: "accessToken"),
           let refreshToken = UserDefaults.standard.string(forKey: "refreshToken") {
            return Tokens(accessToken: accessToken, token: refreshToken)
        }
        return nil
    }
    
    func saveNewWeightArray(_ array: [WeightModel]) {
        do{
            let json = try JSONEncoder().encode(array)
            try json.write(to: weightArrayFileUrl)
        }catch {
            print(error.localizedDescription)
        }
    }
    
    func getWeightArray() -> [WeightModel] {
        var weightArray: [WeightModel] = []
        do{
            weightArray = try JSONDecoder().decode([WeightModel].self, from:FileManager.default.contents(atPath: weightArrayFileUrl.path) ?? .init())
        }catch{
            weightArray = []
        }
        return weightArray
    }
    
    func deleteWeightArray() {
        var array: [WeightModel] = []
        do{
            let json = try JSONEncoder().encode(array)
            try json.write(to: weightArrayFileUrl)
        }catch {
            print(error.localizedDescription)
        }
    }
}
