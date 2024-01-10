//
//  RepositoryListViewModel.swift
//  git-user-explorer
//
//  Created by Paramitha on 07/01/24.
//

import Combine
import Moya
import SwiftUI

enum RepositoryListViewState: Equatable {
    case initialState
    case loading
    case showResult
    case error(String)
}

class RepositoryListViewModel: ObservableObject {
    @Published var viewState: RepositoryListViewState = .initialState
    @Published private(set)var repos: [RepoBasicModel] = []
    
    @Published var currentPage = 1
    
    var id: String
    private let provider: MoyaProvider<GitNetworkTarget>
    private var cancellables = Set<AnyCancellable>()

    init(id: String,
         viewState: RepositoryListViewState = .initialState,
         provider: MoyaProvider<GitNetworkTarget> = MoyaProvider<GitNetworkTarget>()) {
        self.id = id
        self.viewState = viewState
        self.provider = provider
    }
    
    func fetchRepositoryList() {
        viewState = .loading
        
        let request = Future<[RepoBasicModel], Error> { [weak self] promise in
            guard let self = self else { return }
            self.provider.request(.getRepoList(id: self.id, page: self.currentPage)) { result in
                switch result {
                case let .success(response):
                    do {
                        let repos = try response.map([RepoBasicModel].self)
                        
                        // filter out forked repos as per requirement
                        let filteredRepos = repos.filter { !$0.isForked }
                        promise(.success(filteredRepos))
                    } catch let error {
                        promise(.failure(error))
                    }
                case let .failure(error):
                    promise(.failure(error))
                }
            }
        }
        
        request
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                if case let .failure(error) = completion {
                    self?.viewState = .error(error.localizedDescription)
                }
            }, receiveValue: { [weak self] repos in
                self?.repos += repos
                self?.viewState = .showResult
            })
            .store(in: &cancellables)
    }
    
    func loadMoreContentIfNeeded(currentItem repo: RepoBasicModel?) {
        guard let repo = repo, viewState != .loading else {
            return
        }
        if viewState == .showResult,
           let lastItem = repos.last,
           lastItem == repo {
            currentPage += 1
            fetchRepositoryList()
        }
    }
}
