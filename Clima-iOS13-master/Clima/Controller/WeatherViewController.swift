//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController {

    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    
    @IBOutlet weak var searchTextField: UITextField!
    
    var weatherManager = WeatherManager()
    let locationManager = CLLocationManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        //locationManager.startUpdatingLocation() // 지속적인 위치 업데이트
        
        
        searchTextField.delegate = self
        weatherManager.delegate = self
    }

    @IBAction func searchPressed(_ sender: UIButton) {
        searchTextField.endEditing(true)
        
    }
    
    @IBAction func updateButtonPressed(_ sender: UIButton) {
        locationManager.requestLocation()
    }
}

extension WeatherViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        } else {
            textField.placeholder = "Type something"
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if let city = searchTextField.text {
            weatherManager.fetchWether(cityName: city)
        }
        
        searchTextField.text = ""
        
    }
}

extension WeatherViewController: WeatherManagerDelegate {
    func didFailWithError(error: Error) {
        print(error)
        
    }
    
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {
        DispatchQueue.main.async {
            self.temperatureLabel.text = weather.temperatureString
            self.cityLabel.text = weather.cityName
            self.conditionImageView.image = UIImage(systemName: weather.conditionName)
        }
        
        
    }
    
}


extension WeatherViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude

            weatherManager.fetchWether(lat: Int(lat), lon: Int(lon))
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
