//
//  SearchResponseModel+Template.swift
//  git-user-explorerTests
//
//  Created by Paramitha on 11/01/24.
//

@testable import git_user_explorer

extension SearchResponseModel {
    internal static let validTemplate = SearchResponseModel(items: [UserBasicModel.validTemplate1, UserBasicModel.validTemplate2, UserBasicModel.validTemplate3])
    internal static let emptyTemplate = SearchResponseModel(items: [])
}
