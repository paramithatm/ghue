//
//  UserBasicModel.swift
//  git-user-explorer
//
//  Created by Paramitha on 05/01/24.
//

import Foundation

internal struct UserBasicModel: Identifiable {
    internal var id: String { username }
    internal var username: String
    internal var avatarUrl: String
}

extension UserBasicModel: Decodable, Equatable {
    enum CodingKeys: String, CodingKey {
        case username = "login"
        case avatarUrl = "avatar_url"
    }
}
