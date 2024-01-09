//
//  Secret.swift
//  git-user-explorer
//
//  Created by Paramitha on 08/01/24.
//

import Foundation

// To access secret value from Config.plist file
func value(forKey key: String) -> String? {
    guard let filePath = Bundle.main.path(forResource: "Config", ofType: "plist") else {
        return nil
    }

    let plist = NSDictionary(contentsOfFile: filePath)

    let value = plist?.object(forKey: key) as? String
    return value
}
