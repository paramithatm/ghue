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
    func getRepoList(id: String, page: Int) -> Future<[RepoBasicModel], Error>
    func searchUsers(keyword: String, page: Int) -> Future<[UserBasicModel], Error>
}

class GitNetworkProvider: GitNetworkProviderProtocol {
    private let provider = MoyaProvider<GitNetworkTarget>()
    
    private func performRequest<T: Decodable>(target: GitNetworkTarget, map: @escaping (Response) throws -> T) -> Future<T, Error> {
        Future<T, Error> { [provider] promise in
            provider.request(target) { result in
                switch result {
                case let .success(response):
                    do {
                        let processedResult = try map(response)
                        promise(.success(processedResult))
                    } catch let error {
                        promise(.failure(error))
                    }
                case let .failure(error):
                    promise(.failure(error))
                }
            }
        }
    }
    
    func getUserDetails(id: String) -> Future<UserDetailsModel, Error> {
        performRequest(target: .getUserDetails(id: id)) {
            try $0.map(UserDetailsModel.self)
        }
    }
    
    func getRepoList(id: String, page: Int) -> Future<[RepoBasicModel], Error> {
        performRequest(target: .getRepoList(id: id, page: page)) {
            try $0.map([RepoBasicModel].self).filter { !$0.isForked } // filter out forked repos
        }
    }

    func searchUsers(keyword: String, page: Int) -> Future<[UserBasicModel], Error> {
        performRequest(target: .searchUsers(keyword: keyword, page: page)) { response in
            let searchResult = try response.map(SearchResponseModel.self)
            
            return searchResult.items
        }
    }
}
