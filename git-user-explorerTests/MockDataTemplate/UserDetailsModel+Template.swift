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
    
    internal static let emptyTemplate = UserDetailsModel(
        username: "",
        avatarUrl: "",
        followingCount: 0,
        followersCount: 0
    )
    
    internal static let emptyNameTemplate = UserDetailsModel(
        username: "noname",
        avatarUrl: "https://google.com/",
        followingCount: 1,
        followersCount: 2
    )
}
