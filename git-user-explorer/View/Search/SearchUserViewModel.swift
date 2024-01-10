//
//  SearchUserViewModel.swift
//  git-user-explorer
//
//  Created by Paramitha on 08/01/24.
//

import Combine
import Foundation
import Moya

enum SearchUserViewState: Equatable {
    case initialState
    case loading
    case showResult
    case error(String)
}

class SearchUserViewModel: ObservableObject {
    
    @Published var searchKeyword = ""
    private var lastSearchKeyword = ""

    @Published var currentPage = 1
    
    @Published private(set)var users: [UserBasicModel] = []
    
    @Published var viewState: SearchUserViewState = .initialState

    private let networkProvider: GitNetworkProviderProtocol
    private var cancellables: Set<AnyCancellable> = []
    
    init(networkProvider: GitNetworkProviderProtocol = GitNetworkProvider()) {
        self.networkProvider = networkProvider
        
        $searchKeyword
            .removeDuplicates()
            .debounce(for: 0.8, scheduler: RunLoop.main)
            .sink(receiveValue: fetchSearchResult(keyword:))
            .store(in: &cancellables)
    }

    
    func fetchSearchResult(keyword: String) {
        let trimmedKeyword = keyword.trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard !trimmedKeyword.isEmpty else {
            viewState = .initialState
            users = []
            currentPage = 1
            return
        }
        
        if trimmedKeyword != lastSearchKeyword || currentPage == 1 {
            users = []
            currentPage = 1
            lastSearchKeyword = trimmedKeyword
        }
        
        viewState = .loading
        
        networkProvider.searchUsers(keyword: keyword, page: currentPage)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                if case let .failure(error) = completion {
                    self?.viewState = .error(error.localizedDescription)
                }
            }, receiveValue: { [weak self] users in
                self?.users += users
                self?.viewState = .showResult
            }).store(in: &cancellables)
    }
    
    func loadMoreContentIfNeeded(currentItem user: UserBasicModel?) {
        guard let user = user, viewState != .loading else {
            return
        }
        if viewState == .showResult,
           let lastUser = users.last,
           lastUser == user {
            currentPage += 1
            fetchSearchResult(keyword: searchKeyword)
        }
    }
}
