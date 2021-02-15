//
//  ViewControllerExtension.swift
//  WeatherAppPractice
//
//  Created by Katty Quintero on 02/05/2019.
//  Copyright © 2019 Katty Quintero. All rights reserved.
//

import UIKit

var vSpinner : UIView?
extension UIViewController {
    
    
    public func showSimpleAlert(title: String, message: String) {
        
        let alertController = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction.init(title: "OK", style: .default, handler: nil)
        
        alertController.addAction(okAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func noValidCityAlert() {
        self.showSimpleAlert(title: "Alert", message: "City Invalid or is Empty")
    }
    
    func noValidText() {
        self.showSimpleAlert(title: "Alert", message: "Does not accept characters other than alphabet")
    }
    
    func showSpinner(onView : UIView) {
        let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let ai = UIActivityIndicatorView.init(style: .whiteLarge)
        ai.startAnimating()
        ai.center = spinnerView.center
        
        DispatchQueue.main.async {
            spinnerView.addSubview(ai)
            onView.addSubview(spinnerView)
        }
        vSpinner = spinnerView
    }
    
    func removeSpinner() {
        DispatchQueue.main.async {
            vSpinner?.removeFromSuperview()
            vSpinner = nil
        }
    }
}
