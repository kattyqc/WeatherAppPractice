//
//  ParseJson.swift
//  WeatherAppPractice
//
//  Created by Katty Quintero on 02/05/2019.
//  Copyright © 2019 Katty Quintero. All rights reserved.
//

import Foundation
import SwiftyJSON

class ParseJson {
    
    func ParseData(withValue value: Data) -> WeatherAppPracticeModel {
        
        //Weather type
        let json = JSON(value)
        let dicc = json["weather"].array
        let firstIndexDicc = dicc?[0]
        let weather = firstIndexDicc?["main"].string
        
        //Temperature
        let temp = json["main"].dictionary
        let dateTemp = temp?["temp"]?.double
        let tempCelcius = converKelvinToCelcius(number: dateTemp ?? 0.0)
        
        //temperature Minime
        let tempMin = json["main"].dictionary
        let dateTempMin = tempMin?["temp_min"]?.double
        let tempMinCelcius = converKelvinToCelcius(number: dateTempMin ?? 0.0)
        
        //temperature Maxime
        let tempMax = json["main"].dictionary
        let dateTempMax = tempMax?["temp_max"]?.double
        let tempMaxCelcius = converKelvinToCelcius(number: dateTempMax ?? 0.0)
        
        //Name City
        let nameCity = json["name"].string
        
        let model = WeatherAppPracticeModel(temperature: tempCelcius, tempMin: tempMinCelcius, tempMax: tempMaxCelcius, nameCity: nameCity ?? "", weather: weather ?? "")
        
             return model
    
    }
    
    //funcion para convertir de grados kelvin en celcius y aproximar el numero resultante
    func converKelvinToCelcius(number: Double) -> Int {
        
        let celcius      =  number - 273.15
        let celciusRound = celcius.rounded()
        print(Int(celciusRound))
        return Int(celciusRound)
        
    }
}
