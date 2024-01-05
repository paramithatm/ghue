//
//  UserDetailsModel.swift
//  git-user-explorer
//
//  Created by Paramitha on 05/01/24.
//

import Foundation

internal struct UserDetailsModel: Decodable {
    internal var username: String
    internal var fullName: String
    internal var avatarUrl: URL?
    internal var followingCount: Int
    internal var followersCount: Int
}
