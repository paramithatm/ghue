//
//  GitNetworkTarget.swift
//  git-user-explorer
//
//  Created by Paramitha on 05/01/24.
//

import Moya

enum GitNetworkTarget {
    case getUserDetails(id: String)
    case getRepoList(id: String)
    case searchUsers(keyword: String, page: Int)
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
        case let .getUserDetails(id):
            return "/users/\(id)"
        case let .getRepoList(id):
            return "/users/\(id)/repos"
        case .searchUsers:
            return "/search/users"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getUserDetails, .getRepoList, .searchUsers:
            return .get
        }
    }
    
    var parameters: [String: Any] {
        switch self {
        case let .searchUsers(keyword, page):
            [
                "q": keyword,
                "per_page": 1000,
                "page": page
            ]
        case .getUserDetails, .getRepoList:
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
