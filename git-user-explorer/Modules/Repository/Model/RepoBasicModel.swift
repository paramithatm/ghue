//
//  RepoBasicModel.swift
//  git-user-explorer
//
//  Created by Paramitha on 05/01/24.
//

import Foundation

internal struct RepoBasicModel {
    internal var shortName: String
    internal var fullname: String
    internal var description: String
    internal var language: String
    internal var stars: Int
    internal var repoUrl: URL?
}
