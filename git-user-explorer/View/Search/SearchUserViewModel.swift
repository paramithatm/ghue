//
//  SearchUserViewModel.swift
//  git-user-explorer
//
//  Created by Paramitha on 08/01/24.
//

import Combine
import Foundation
import Moya

enum SearchViewState {
    case initialState
    case loading
    case showResult([UserBasicModel])
    case error(String)
}

class SearchViewModel: ObservableObject {
    
    @Published var searchText = ""
    
    @Published var viewState: SearchViewState = .initialState
    private let provider: MoyaProvider<GitNetworkTarget>
    
    
    init(searchText: String = "", viewState: SearchViewState = .initialState, provider: MoyaProvider<GitNetworkTarget> = MoyaProvider<GitNetworkTarget>()) {
        self.searchText = searchText
        self.viewState = viewState
        self.provider = provider
        
        $searchText
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
            return
        }
        
        viewState = .loading
        
        provider.request(.searchUsers(keyword: trimmedKeyword)) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(response):
                let searchResult = try! response.map(SearchResponseModel.self)
                self.viewState = .showResult(searchResult.items)
            case let .failure(error):
                self.viewState = .error(error.localizedDescription)
            }
        }
    }
}
