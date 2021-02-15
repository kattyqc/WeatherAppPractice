//
//  CountriesViewController.swift
//  WeatherAppPractice
//
//  Created by Katty Quintero on 11/06/2019.
//  Copyright © 2019 Katty Quintero. All rights reserved.
//

import UIKit
import FlagKit

protocol SelectedCountryDelegate {
    func newCountrySelected (name: String)
}

struct Country {
    let name: String
    let isoCode: String
}

class CountriesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
   
    var countryDelegate: SelectedCountryDelegate?
    var countries = [Country]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    for code in NSLocale.isoCountryCodes as [String] {
        let id = NSLocale.localeIdentifier(fromComponents: [NSLocale.Key.countryCode.rawValue: code])
        let name = NSLocale(localeIdentifier: "en_UK").displayName(forKey: NSLocale.Key.identifier, value: id) ?? "Country not found for code: \(code)"
            countries.append(Country(name: name, isoCode: code))
        }
        //A traves de este for obtenemos todos los nombres de los paises...
        print(countries)
    }
    
    //MARK: - DataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CountriesDetailTableViewCell
        let country = countries[indexPath.row]
        cell.nameCountryLabel.text = country.name
        cell.flagImage(from: country.isoCode)
        
        cell.backgroundColor = UIColor.darkGray
        return cell
    }
    //MARK: - Delegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCountry = storyboard?.instantiateViewController(withIdentifier: "CitySelected") as! WeatherViewController
        let newCity = countries[indexPath.row]
        countryDelegate?.newCountrySelected(name: newCity.name)
        
       dismiss(animated: true, completion: nil)
    }
    
    @IBAction func closedScreem(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
    
}
