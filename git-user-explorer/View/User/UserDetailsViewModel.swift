//
//  UserDetailsViewModel.swift
//  git-user-explorer
//
//  Created by Paramitha on 07/01/24.
//

import Combine
import Moya
import SwiftUI

enum UserDetailsViewState: Equatable {
    case initialState
    case loading
    case showResult(UserDetailsModel)
    case error(String)
}

class UserDetailsViewModel: ObservableObject {
    @Published var viewState: UserDetailsViewState = .initialState
    
    var id: String
    private var cancellables = Set<AnyCancellable>()
    private let networkProvider: GitNetworkProviderProtocol
    
    init(id: String,
         viewState: UserDetailsViewState = .initialState,
         networkProvider: GitNetworkProviderProtocol = GitNetworkProvider()
    ) {
        self.id = id
        self.viewState = viewState
        self.networkProvider = networkProvider
    }
    
    func fetchUserDetails() {
        viewState = .loading
        
        networkProvider.getUserDetails(id: id)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                if case let .failure(error) = completion {
                    self?.viewState = .error(error.localizedDescription)
                }
            }, receiveValue: { [weak self] user in
                self?.viewState = .showResult(user)
            })
            .store(in: &cancellables)
    }
}
