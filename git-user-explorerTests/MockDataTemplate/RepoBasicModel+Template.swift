//
//  RepoBasicModel+Template.swift
//  git-user-explorerTests
//
//  Created by Paramitha on 11/01/24.
//

@testable import git_user_explorer

extension RepoBasicModel {
    internal static let validTemplate = RepoBasicModel(name: "Repo-A", description: "sample code", language: "Swift", starsCount: 1, repoUrl: "https://google.com", isForked: false)
    internal static let noDescriptionTemplate = RepoBasicModel(name: "Repo-B", language: "Swift", starsCount: 1, repoUrl: "https://google.com", isForked: false)
    internal static let noLanguageTemplate = RepoBasicModel(name: "Repo-C", description: "sample code", starsCount: 1, repoUrl: "https://google.com", isForked: false)
}
