//
//  MockGitNetworkProvider.swift
//  git-user-explorerTests
//
//  Created by Paramitha on 11/01/24.
//

import Combine
@testable import git_user_explorer

class MockNetworkProvider: GitNetworkProviderProtocol {
    
    internal var getUserDetailsResult: ((String) -> Future<UserDetailsModel, Error>)!
    internal var getRepoListResult: ((String, Int) -> Future<[RepoBasicModel], Error>)!
    internal var searchUsersResult: ((String, Int) -> Future<[UserBasicModel], Error>)!
    
    func getUserDetails(id: String) -> Future<UserDetailsModel, Error> {
        getUserDetailsResult(id)
    }
    
    func getRepoList(id: String, page: Int) -> Future<[RepoBasicModel], Error> {
        getRepoListResult(id, page)
    }
    
    func searchUsers(keyword: String, page: Int) -> Future<[UserBasicModel], Error> {
        searchUsersResult(keyword, page)
    }
}
