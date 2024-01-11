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
    private let networkProvider: GitNetworkProviderProtocol
    private var cancellables = Set<AnyCancellable>()

    init(id: String,
         networkProvider: GitNetworkProviderProtocol = GitNetworkProvider()) {
        self.id = id
        self.networkProvider = networkProvider
    }
    
    func fetchRepositoryList() {
        viewState = .loading
        
        networkProvider.getRepoList(id: id, page: currentPage)
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
