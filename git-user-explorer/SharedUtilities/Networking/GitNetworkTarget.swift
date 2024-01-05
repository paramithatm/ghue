//
//  GitNetworkTarget.swift
//  git-user-explorer
//
//  Created by Paramitha on 05/01/24.
//

import Moya

enum GitNetworkTarget {
    case getUserList
}

extension GitNetworkTarget: TargetType {
    var baseURL: URL {
        guard let url = URL(string: "https://api.github.com") else {
            fatalError("Error: Invalid URL")
        }
        return url
    }
    
    var path: String {
        switch self {
        case .getUserList:
            return "/users"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getUserList:
            return .get
        }
    }
    
    var task: Moya.Task {
        return .requestPlain
    }
    
    var headers: [String : String]? {
        return [:]
    }
    
    
}
