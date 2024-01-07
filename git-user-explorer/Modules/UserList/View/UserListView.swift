//
//  UserListView.swift
//  git-user-explorer
//
//  Created by Paramitha on 04/01/24.
//

import Foundation
import SwiftUI

struct UserListView: View {
    
    @StateObject var viewModel = UserListViewModel()
    
    var body: some View {
        Group {
            switch viewModel.viewState {
            case .initialState:
                Text("wkwk")
            case .loading:
                ProgressView()
            case let .showResult(response):
                NavigationView {
                    List(response) { user in
                        NavigationLink(destination: UserDetailsView()) {
                            UserCellView(
                                name: user.username,
                                avatarUrl: user.avatarUrl ?? ""
                            )
                        }
                    }
                }
            case .error(let error):
                Text(error.localizedDescription)
            }
        }.onAppear {
            viewModel.fetchUserList()
        }
    }
}

//#Preview {
//    UserListView()
//}
