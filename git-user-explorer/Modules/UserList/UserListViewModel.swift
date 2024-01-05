//
//  UserListViewModel.swift
//  git-user-explorer
//
//  Created by Paramitha on 04/01/24.
//

import Combine
import Moya
import SwiftUI

enum ViewState {
    case initialState
    case loading
    case showResult([UserBasicModel])
    case error(Error)
}

class UserListViewModel: ObservableObject {
    
    @Published var viewState: ViewState = .initialState
    
    private let provider: MoyaProvider<GitNetworkTarget>
    
    init(viewState: ViewState = .initialState, provider: MoyaProvider<GitNetworkTarget> = MoyaProvider<GitNetworkTarget>()) {
        self.viewState = viewState
        self.provider = provider
    }
    
    func fetchUserList() {
        viewState = .loading
        
        provider.request(.getUserList) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(response):
                
                let users = try! response.map([UserBasicModel].self)
                
                self.viewState = .showResult(users)
            case let .failure(error):
                self.viewState = .error(error)
            }
        }
        
    }
    
}
