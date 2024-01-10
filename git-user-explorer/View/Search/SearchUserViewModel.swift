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

    private let provider: MoyaProvider<GitNetworkTarget>
    
    
    init(provider: MoyaProvider<GitNetworkTarget> = MoyaProvider<GitNetworkTarget>()) {
        self.provider = provider
        
        $searchKeyword
            .removeDuplicates()
            .debounce(for: 0.8, scheduler: RunLoop.main)
            .sink(receiveValue: fetchSearchResult(keyword:))
            .store(in: &cancellables)
    }

    private var cancellables: Set<AnyCancellable> = []

    
    func fetchSearchResult(keyword: String) {
        let trimmedKeyword = keyword.trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard !trimmedKeyword.isEmpty else {
            viewState = .initialState
            users = []
            return
        }
        
        if trimmedKeyword != lastSearchKeyword || currentPage == 1 {
            users = []  // Reset users if the keyword has changed or it's a new search
            currentPage = 1    // Reset currentPage to the first page
            lastSearchKeyword = trimmedKeyword
        }
        
        viewState = .loading
        
        provider.request(.searchUsers(keyword: trimmedKeyword, page: currentPage)) { [weak self] result in
                guard let self = self else { return }

                switch result {
                case let .success(response):
                    do {
                        let searchResult = try response.map(SearchResponseModel.self)
                        self.users += searchResult.items
                        viewState = .showResult
                    } catch {
                        self.viewState = .error(error.localizedDescription)
                    }
                case let .failure(error):
                    self.viewState = .error(error.localizedDescription)
                }
            }
        
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
