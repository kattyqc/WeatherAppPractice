//
//  WeatherAppPracticeViewController.swift
//  WeatherAppPractice
//
//  Created by Katty Quintero on 01/05/2019.
//  Copyright © 2019 Katty Quintero. All rights reserved.
//

import UIKit
import SwiftyJSON
import CoreLocation

enum TypeWeather: String {
    case clear = "Clear"
    case haze = "Haze"
    case clouds = "Clouds"
    case rain = "Rain"
    case fog = "Fog"
}

class WeatherViewController: UIViewController, CityNameDelegate, SelectedCountryDelegate, CLLocationManagerDelegate {
   
    func newCountrySelected(name: String) {
        getData(city: name)
    }
    
    func newcity(city: String) {
        getData(city: city)
    }

    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var arrowUp: UIImageView!
    @IBOutlet weak var tempMaxLabel: UILabel!
    @IBOutlet weak var arrowDown: UIImageView!
    @IBOutlet weak var tempMinLabel: UILabel!
    
    var climate: WeatherAppPracticeModel?
    let manager = CLLocationManager()
    let degreeSymbol = "º"
    let image = "merida"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData(city: "london")
        self.showSpinner(onView: self.view)
        self.manager.requestAlwaysAuthorization()
        self.manager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        manager.startUpdatingLocation()
       
        }
    }

    func getData(city: String) {
        
        Networking().getData(cityName: city, completion: { response in
          
            self.climate = ParseJson().ParseData(withValue: response)
            guard let weatherClimate = self.climate else { return }
            self.cityNameLabel.text = weatherClimate.nameCity
            let temperatureNew = String(weatherClimate.temperature)
            let tempMinNew = String(weatherClimate.tempMin)
            let tempMaxNew = String(weatherClimate.tempMax)
            self.temperatureLabel.text = ("\(temperatureNew)\(self.degreeSymbol)")
            self.tempMinLabel.text = tempMinNew
            self.tempMaxLabel.text = tempMaxNew
            self.weatherLabel.text = weatherClimate.weather
            
            switch weatherClimate.weather {
            case TypeWeather.rain.rawValue:
                self.imgView.image = UIImage(named: "Rain")
            case TypeWeather.clear.rawValue:
                self.imgView.image = UIImage(named: "clear")
            case TypeWeather.clouds.rawValue:
                self.imgView.image = UIImage(named: "cloudy")
            case TypeWeather.haze.rawValue:
                self.imgView.image = UIImage(named: "haze")
            case TypeWeather.fog.rawValue:
                self.imgView.image = UIImage(named: "neblina")
            default:
                self.imgView.image = UIImage(named: "merida")
            }
            self.removeSpinner()
        })
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "NameCity" {
            let navigation = segue.destination as! UINavigationController
            let vc = navigation.topViewController as! SelectedCityNameViewController
            vc.delegate = self
//        } else if segue.identifier == "ListCountry" {
//            let navigation = segue.destination
//            let listVC = navigation as! CountriesViewController
//            listVC.countryDelegate = self
        }
    }
    
     func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else {
            print("error")
            return }
        print("locations = \(locValue.latitude) \(locValue.longitude)")
        getCountry(from: manager)
    }
    
    private func getCountry(from managerLocation: CLLocationManager) {
        
        guard let location = managerLocation.location else { return }
        fetchCityAndCountry(from: location) { (city, country, error) in
            if error == nil {
                print(city, country)
                self.getData(city: city ?? "London")
            }
        }
    }
    func fetchCityAndCountry(from location: CLLocation, completion: @escaping (_ city: String?, _ country:  String?, _ error: Error?) -> ()) {
        CLGeocoder().reverseGeocodeLocation(location) { placemarks, error in
            completion(placemarks?.first?.locality,
                       placemarks?.first?.country,
                       error)
        }
    }
    
    @IBAction func openCountriesAction(_ sender: Any) {
        
        guard let countriesViewController = storyboard?.instantiateViewController(withIdentifier: "CountriesViewController") as? CountriesViewController else {
            print("CountriesViewController is nil")
         return
        }
        countriesViewController.countryDelegate = self
        
        let navigation = UINavigationController(rootViewController: countriesViewController)
        navigation.navigationBar.barTintColor = UIColor.black
        present(navigation, animated: true)
        
    }
}
