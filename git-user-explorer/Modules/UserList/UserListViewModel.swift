//
//  UserListViewModel.swift
//  git-user-explorer
//
//  Created by Paramitha on 04/01/24.
//

import Combine
import SwiftUI

enum ViewState {
    case initialState
    case loading
    case showResult(String)
    case error(Error)
}

class UserListViewModel: ObservableObject {
    @Published var viewState: ViewState = .initialState
    
}
