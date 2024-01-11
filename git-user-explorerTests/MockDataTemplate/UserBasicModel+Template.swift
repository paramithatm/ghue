//
//  UserBasicModel+Template.swift
//  git-user-explorerTests
//
//  Created by Paramitha on 11/01/24.
//

@testable import git_user_explorer

extension UserBasicModel {
    internal static let validTemplate1 = UserBasicModel(username: "someone", avatarUrl: "https://google.com")
    internal static let validTemplate2 = UserBasicModel(username: "someoneelse", avatarUrl: "https://google.com")
}
