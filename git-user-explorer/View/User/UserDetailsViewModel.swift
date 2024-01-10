//
//  UserDetailsViewModel.swift
//  git-user-explorer
//
//  Created by Paramitha on 07/01/24.
//

import Combine
import Moya
import SwiftUI

enum UserDetailsViewState {
    case initialState
    case loading
    case showResult(UserDetailsModel)
    case error(Error)
}

class UserDetailsViewModel: ObservableObject {
    @Published var viewState: UserDetailsViewState = .initialState
    
    var id: String
    private var cancellables = Set<AnyCancellable>()
    private let provider: MoyaProvider<GitNetworkTarget>
    
    init(id: String,
         viewState: UserDetailsViewState = .initialState,
         provider: MoyaProvider<GitNetworkTarget> = MoyaProvider<GitNetworkTarget>()
    ) {
        self.id = id
        self.viewState = viewState
        self.provider = provider
    }
    
    func fetchUserDetails() {
        viewState = .loading
        
        let request = Future<UserDetailsModel, Error> { [weak self] promise in
            guard let self = self else { return }
            self.provider.request(.getUserDetails(id: self.id)) { result in
                switch result {
                case let .success(response):
                    do {
                        let user = try response.map(UserDetailsModel.self)
                        promise(.success(user))
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
                    self?.viewState = .error(error)
                }
            }, receiveValue: { [weak self] user in
                self?.viewState = .showResult(user)
            })
            .store(in: &cancellables)
        
    }
    
}
