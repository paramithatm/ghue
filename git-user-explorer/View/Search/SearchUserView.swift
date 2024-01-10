//
//  SearchUserView.swift
//  git-user-explorer
//
//  Created by Paramitha on 08/01/24.
//

import Foundation
import SwiftUI

struct SearchUserView: View {
    @StateObject private var viewModel = SearchUserViewModel()

    var body: some View {
        
        Group {
            switch viewModel.viewState {
            case .initialState:
                EmptyView(title: "Who's on GitHub?", subtitle: "Search to find out", imageName: "icon_search")
            case .loading where viewModel.users.isEmpty:
                ProgressView()
            case .showResult, .loading:
                userList
                
            case let .error(message):
                Text(message)
            }
        }.searchable(text: $viewModel.searchKeyword, prompt: "Search users")
        
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
                    viewModel.loadMoreContentIfNeeded(currentItem: user)
                }
            
        }
    }
}
