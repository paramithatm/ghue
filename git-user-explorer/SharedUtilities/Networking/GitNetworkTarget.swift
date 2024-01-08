//
//  GitNetworkTarget.swift
//  git-user-explorer
//
//  Created by Paramitha on 05/01/24.
//

import Moya

enum GitNetworkTarget {
    case getUserList(current: Int, pagination: Int)
    case getUserDetails(id: String)
    case getRepoList(id: String)
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
        case let .getUserDetails(id):
            return "/users/\(id)"
        case let .getRepoList(id):
            return "/users/\(id)/repos"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getUserList, .getUserDetails, .getRepoList:
            return .get
        }
    }
    
    var parameters: [String: Any] {
        switch self {
        
        case let .getUserList(current, pagination):
            [
                    "per_page": "15",
                    "page": pagination,
                    "since": current
            ]
        case .getUserDetails:
            [:]
        case .getRepoList:
            [:]
        }
    }
    
    var task: Moya.Task {
        return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
    }
    
    var headers: [String : String]? {
        var defaultHeader: [String: String] = ["Accept": "application/vnd.github+json"]
        if let token = value(forKey: "ghToken") {
            defaultHeader["Authorization"] = "Bearer \(token)"
        }

        return defaultHeader
    }
    
    
}
