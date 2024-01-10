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
            case .loading where viewModel.users.isEmpty:
                ProgressView()
            case .showResult, .loading:
                userList
                
            case let .error(message):
                Text(message)
            }
        }.searchable(text: $viewModel.searchKeyword, prompt: "Search Users")
        
    }
    
    private var userList: some View {
        List(viewModel.users) { user in
            NavigationLink(
                destination: UserDetailsView(id: user.username)) {
                    UserCellView(
                        name: user.username,
                        avatarUrl: user.avatarUrl ?? ""
                    )
                }
                .onAppear {
                    // Load more content when the last item appears
                    if user == viewModel.users.last {
                        viewModel.loadMoreContentIfNeeded(currentItem: user)
                    }
                }
            
        }
    }
}
