//
//  UserDetailsModel+Template.swift
//  git-user-explorerTests
//
//  Created by Paramitha on 11/01/24.
//

@testable import git_user_explorer

extension UserDetailsModel {
    internal static let validTemplate = UserDetailsModel(
        username: "someone",
        fullName: "just someone",
        avatarUrl: "https://google.com/",
        followingCount: 1,
        followersCount: 2
    )
}
