//
//  RefreshTokenManager.swift
//  HealthAssistant
//
//  Created by Арсений on 19.04.24.
//

import Foundation

final class RefreshTokenManager {
    
    static let shared = RefreshTokenManager()
    private init(){
    }
    
    func updateTokens(with refresh: String, complition: @escaping (Bool) -> Void) {
        if let url = URL(string:  "https://healthassistant-production.up.railway.app/api/v1.0/auth/refreshToken") {
            let json: [String: Any] = ["token": refresh]
            let jsonData = try? JSONSerialization.data(withJSONObject: json)
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = "POST"
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            urlRequest.httpBody = jsonData
            
            URLSession.shared.dataTask(with: urlRequest) {[weak self] data, response, error in
                guard let self = self else {return}
                guard let data = data, error == nil else {
                    print(error?.localizedDescription ?? "No data")
                    return
                }
                let tokens = try? JSONDecoder().decode(Tokens.self, from: data)
                let httpResponse = response as! HTTPURLResponse
                print("SIGN IN STATUS : \(httpResponse.statusCode)")
                if (httpResponse.statusCode >= 200) && (httpResponse.statusCode < 300) && tokens != nil{
                    print("Success")
                    AppFileManager.shared.saveTokens(tokens: tokens!)
                    DispatchQueue.main.async {
                        complition(true)
                    }
                }else {
                    print("Failure")
                    DispatchQueue.main.async {
                        complition(false)
                    }
                }
            }
            .resume()
        }
    }
}
