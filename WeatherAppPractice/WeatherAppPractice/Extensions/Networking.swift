//
//  Networking.swift
//  WeatherAppPractice
//
//  Created by Katty Quintero on 01/05/2019.
//  Copyright © 2019 Katty Quintero. All rights reserved.
//

import Foundation
import Alamofire

class Networking {
    
    func getData(cityName: String, completion: @escaping (Data) -> Void) {
        
        let baseUrl         = "https://api.openweathermap.org"
        let weatherEndPoind = "/data/2.5/weather?q="
        let appId           = "&appid=b7b6e3c44711921854f06672853c3e53"
        let newString       = cityName.replacingOccurrences(of: " ", with: "%20")
        
        let url = ("\(baseUrl)\(weatherEndPoind)\(newString)\(appId)")
        
        Alamofire.request(url).responseData { response in
            
           // if let urlResponse = response.response, urlResponse.statusCode != 404 {
                switch response.result {
                case .success(let value):
                    print("value is: \(String(data: value, encoding: .utf8))")
                    completion(value)
                case .failure(let error):
                    print("❌ request failed with error -> \(error)\n description \(error.localizedDescription)")
                }
           // } else {
          //      fatalError("atatus code 404 invalid token")
                print("STATUS CODE 🔥🔥🔥🔥🔥🔥🔥🔥 \(response.response?.statusCode ?? 0)\n")
                print(" \(response)")
           // }
        }
    }
}
