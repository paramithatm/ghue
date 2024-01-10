//
//  SearchUserView.swift
//  git-user-explorer
//
//  Created by Paramitha on 08/01/24.
//

import Foundation
import SwiftUI

// Main view
struct SearchUserView: View {
    @StateObject private var viewModel = SearchUserViewModel()

    var body: some View {
        
        Group {
            switch viewModel.viewState {
            case .initialState:
                EmptyView()
            case .loading:
                ProgressView()
            case let .showResult(response):
                List(response) { user in
                    NavigationLink(
                        destination: UserDetailsView(id: user.username)) {
                                UserCellView(
                                    name: user.username,
                                    avatarUrl: user.avatarUrl ?? ""
                                )
                            }
                }
            case let .error(message):
                Text(message)
            }
        }.searchable(text: $viewModel.searchText, prompt: "Search Users")
        
    }
}
