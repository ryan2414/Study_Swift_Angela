//
//  CoinData.swift
//  ByteCoin
//
//  Created by 이승재 on 2023/07/17.
//  Copyright © 2023 The App Brewery. All rights reserved.
//

import Foundation

struct CoinData: Decodable { // Json Data로 변환할 일이 없으므로 Codable 사용 X
    let rate: Double
}
