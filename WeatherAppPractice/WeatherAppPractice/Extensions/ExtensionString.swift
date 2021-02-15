//
//  ExtensionString.swift
//  WeatherAppPractice
//
//  Created by Katty Quintero on 06/05/2019.
//  Copyright © 2019 Katty Quintero. All rights reserved.
//

import Foundation

extension String {
    
    func isValidCity() -> Bool {
        let cityReg  = "[A-Za-z]{0,20}"
        let nameCity = NSPredicate(format: "SELF MATCHES %@", cityReg)
        return nameCity.evaluate(with:self)
    }
}
