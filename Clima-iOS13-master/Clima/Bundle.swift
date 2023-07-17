//
//  Bundle.swift
//  Clima
//
//  Created by 이승재 on 2023/07/17.
//  Copyright © 2023 App Brewery. All rights reserved.
//

import Foundation

extension Bundle {
    var openWeatherAPIKey: String {
        get {
            guard let filePath = Bundle.main.path(forResource: "ApiKey", ofType: "plist") else {
                fatalError("Couldn't find file 'SecretKey.plist'.")
            }
            let plist = NSDictionary(contentsOfFile: filePath)
            
            guard let value = plist?.object(forKey: "OPENWEATHERMAP_KEY") as? String else {
                fatalError("Couldn't find key 'OPENWEATHERMAP_KEY' in 'SecretKey.plist'.")
            }
            return value
        }
    }
}
