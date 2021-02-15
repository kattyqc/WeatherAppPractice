//
//  WeatherAppPracticeModel.swift
//  WeatherAppPractice
//
//  Created by Katty Quintero on 01/05/2019.
//  Copyright © 2019 Katty Quintero. All rights reserved.
//

import Foundation

class WeatherAppPracticeModel {
    
    var temperature: Int
    var tempMin: Int
    var tempMax: Int
    var nameCity: String
    var weather: String
    
    init(temperature: Int, tempMin: Int, tempMax: Int, nameCity: String, weather: String) {
        self.temperature = temperature
        self.tempMin = tempMin
        self.tempMax = tempMax
        self.nameCity = nameCity
        self.weather = weather
    }
}
