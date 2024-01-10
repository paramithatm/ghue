//
//  UserDetailsModel.swift
//  git-user-explorer
//
//  Created by Paramitha on 05/01/24.
//

import Foundation

internal struct UserDetailsModel: Identifiable {
    internal var id: String { username }
    internal var username: String
    internal var fullName: String?
    internal var avatarUrl: String
    internal var followingCount: Int
    internal var followersCount: Int
}

extension UserDetailsModel: Decodable, Equatable {
    enum CodingKeys: String, CodingKey {
        case username = "login"
        case fullName = "name"
        case avatarUrl = "avatar_url"
        case followingCount = "following"
        case followersCount = "followers"
    }
    
}
