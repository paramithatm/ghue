//
//  RepositoryListViewModel.swift
//  git-user-explorer
//
//  Created by Paramitha on 07/01/24.
//

import Moya
import SwiftUI

enum RepositoryListViewState {
    case initialState
    case loading
    case showResult([RepoBasicModel])
    case error(Error)
}

class RepositoryListViewModel: ObservableObject {
    @Published var viewState: RepositoryListViewState = .initialState
    
    var id: String
    private let provider: MoyaProvider<GitNetworkTarget>
    
    init(id: String,
         viewState: RepositoryListViewState = .initialState,
         provider: MoyaProvider<GitNetworkTarget> = MoyaProvider<GitNetworkTarget>()) {
        self.id = id
        self.viewState = viewState
        self.provider = provider
    }
    
    func fetchRepositoryList() {
        viewState = .loading
        
        provider.request(.getRepoList(id: id)) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(response):
                
                let repos = try! response.map([RepoBasicModel].self)
                
                // filter out forked repos
                let filteredRepos = repos.filter { !$0.isForked }
                
                self.viewState = .showResult(filteredRepos)
            case let .failure(error):
                self.viewState = .error(error)
            }
        }
    }
}
