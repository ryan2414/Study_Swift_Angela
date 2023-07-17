//
//  WetherManager.swift
//  Clima
//
//  Created by 이승재 on 2023/07/15.
//  Copyright © 2023 App Brewery. All rights reserved.
//

import Foundation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError(error: Error)
}

struct WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=\(Bundle.main.openWeatherAPIKey)&units=metric"
    
    var delegate: WeatherManagerDelegate?
    
    func fetchWether(cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        
        performRequest(with: urlString)
    }
    
    func fetchWether(lat: Int, lon: Int) {
        let urlString = "\(weatherURL)&lat=\(lat)&lon=\(lon)"
        
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            
            session.dataTask(with: url) { data, response, error in
                guard error == nil else {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                
                if let safeData = data {
                    if let weather = self.parseJSON(safeData) {
                        self.delegate?.didUpdateWeather(self, weather: weather)
                    }
                }
            }.resume()
        }
    }
    
    func parseJSON(_ weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let name = decodedData.name
            
            let weather = WeatherModel(conditionId: id, cityName: name, temperature: temp)
            
            return weather
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
         
    }
    
}
