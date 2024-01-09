//
//  SearchUserView.swift
//  git-user-explorer
//
//  Created by Paramitha on 08/01/24.
//

import Foundation
import SwiftUI

// Main view
struct SearchView: View {
    @StateObject private var viewModel = SearchViewModel()

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
                }.navigationTitle("GitHub User Explorer")
            case let .error(message):
                Text(message)
            }
        }.searchable(text: $viewModel.searchText, prompt: "Search Users")
        
    }
}
