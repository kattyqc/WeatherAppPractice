//
//  SelectedCityNameViewController.swift
//  WeatherAppPractice
//
//  Created by Katty Quintero on 06/05/2019.
//  Copyright © 2019 Katty Quintero. All rights reserved.
//

import UIKit

protocol CityNameDelegate {
    func newcity(city: String)
}

class SelectedCityNameViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var newCityTextField: UITextField!
    
    var delegate: CityNameDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        newCityTextField.delegate = self
    }
    //MARK: - IBAction
    @IBAction func cancelButton(_ sender: Any) {
        self.dismiss(animated: true,completion: nil) 
    }
    
    @IBAction func saveNewCity(_ sender: Any) {
        self.sendTextToAnotherView()
    }
    //MARK: - Functions
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        //funcion para quitar el teclado al tocar cualquier punto de la pantalla
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        sendTextToAnotherView()
        return true
    }
    
    func sendTextToAnotherView() {
        if !(newCityTextField.text?.isEmpty)! {
            guard let city = newCityTextField.text, city.isValidCity() else
            { noValidText()
                return }
            delegate?.newcity(city: city)
            self.dismiss(animated: true, completion: nil)
        } else {
            noValidCityAlert()
        }
    }
}
