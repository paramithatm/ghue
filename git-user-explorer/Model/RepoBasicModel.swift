//
//  RepoBasicModel.swift
//  git-user-explorer
//
//  Created by Paramitha on 05/01/24.
//

import Foundation

internal struct RepoBasicModel: Identifiable {
    internal var id: String { fullName }
    
    internal var fullName: String
    internal var description: String?
    internal var language: String?
    internal var starsCount: Int
    internal var repoUrl: String
    internal var isForked: Bool
}

extension RepoBasicModel: Decodable, Equatable {
    enum CodingKeys: String, CodingKey {
        case fullName = "name"
        case description
        case language = "language"
        case starsCount = "stargazers_count"
        case repoUrl = "html_url"
        case isForked = "fork"
    }
}
