//
//  CommonError.swift
//  git-user-explorer
//
//  Created by Paramitha on 11/01/24.
//

import Foundation

enum CommonError: Error, Equatable {
    case serverError
    
    var errorDescription: String {
        switch self {
        case .serverError:
            "An server error occured."
        }
    }
}
