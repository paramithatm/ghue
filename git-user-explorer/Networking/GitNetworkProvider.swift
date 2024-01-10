//
//  GitNetworkProvider.swift
//  git-user-explorer
//
//  Created by Paramitha on 11/01/24.
//

import Combine
import Moya

protocol GitNetworkProviderProtocol {
    func getUserDetails(id: String) -> Future<UserDetailsModel, Error>
//    func getRepoList(id: String, page: Int) -> Future<[RepoBasicModel], Error>
//    func searchUsers(keyword: String, page: Int)
}

class GitNetworkProvider: GitNetworkProviderProtocol {
    private let provider = MoyaProvider<GitNetworkTarget>()
    
    func getUserDetails(id: String) -> Future<UserDetailsModel, Error> {
        Future<UserDetailsModel, Error> { [provider] promise in
            provider.request(.getUserDetails(id: id)) { result in
                switch result {
                case let .success(response):
                    do {
                        let userDetails = try response.map(UserDetailsModel.self)
                        promise(.success(userDetails))
                    } catch let error {
                        promise(.failure(error))
                    }
                case let .failure(error):
                    promise(.failure(error))
                }
            }
        }
    }
    
//    func getRepoList(id: String, page: Int) -> Future<[RepoBasicModel], Error> {
//
//    }
//    
//    func searchUsers(keyword: String, page: Int) {
//
//    }
    
    
}
