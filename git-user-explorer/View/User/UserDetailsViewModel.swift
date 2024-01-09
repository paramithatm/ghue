//
//  UserDetailsViewModel.swift
//  git-user-explorer
//
//  Created by Paramitha on 07/01/24.
//

//import Combine
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
        
        provider.request(.getUserDetails(id: id)) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(response):
                
                let user = try! response.map(UserDetailsModel.self)
                
                self.viewState = .showResult(user)
            case let .failure(error):
                self.viewState = .error(error)
            }
        }
        
    }
    
}
