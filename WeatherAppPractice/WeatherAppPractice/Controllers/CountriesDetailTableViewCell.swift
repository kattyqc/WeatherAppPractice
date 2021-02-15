//
//  CountriesDetailTableViewCell.swift
//  WeatherAppPractice
//
//  Created by Katty Quintero on 11/06/2019.
//  Copyright © 2019 Katty Quintero. All rights reserved.
//

import UIKit
import FlagKit

class CountriesDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var nameCountryLabel: UILabel!
    @IBOutlet weak var imgViewFlag: UIImageView!
    
    func flagImage(from countryCode: String) {
        
        let flag = Flag(countryCode: countryCode)
        let image = flag?.originalImage
        imgViewFlag.image = image
        imgViewFlag.layer.cornerRadius = 10
    }
}
