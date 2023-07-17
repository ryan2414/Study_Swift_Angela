//
//  Bundle.swift
//  ByteCoin
//
//  Created by 이승재 on 2023/07/17.
//  Copyright © 2023 The App Brewery. All rights reserved.
//

import Foundation

extension Bundle {
    
    var apiKey: String {
        // forResource에다 plist 파일 이름을 입력해주세요.
        guard let filePath = Bundle.main.path(forResource: "ApiKey", ofType: "plist"),
              let plistDict = NSDictionary(contentsOfFile: filePath) else {
            fatalError("Couldn't find file 'SecureAPIKeys.plist'.")
        }
        
        // plist 안쪽에 사용할 Key값을 입력해주세요.
        guard let value = plistDict.object(forKey: "API_KEY") as? String else {
            fatalError("Couldn't find key 'API_Key' in 'SecureAPIKeys.plist'.")
        }
        
        // 또는 키 값을 통해 직접적으로 불러줄 수도 있어요.
        // guard let value = plistDict["API_KEY"] as? String else {
        //     fatalError("Couldn't find key 'API_Key' in 'SecureAPIKeys.plist'.")
        // }
        
        return value
    }
}
