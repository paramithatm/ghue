//
//  SearchResponseModel.swift
//  git-user-explorer
//
//  Created by Paramitha on 08/01/24.
//

import Foundation

// Define the structure that matches the JSON format
struct SearchResponseModel: Decodable {
    let items: [UserBasicModel]
}
