//
//  UserDetailsView.swift
//  git-user-explorer
//
//  Created by Paramitha on 04/01/24.
//

import Foundation
import SwiftUI

struct UserDetailsView: View {
    
    @StateObject var viewModel: UserDetailsViewModel
    var id: String
    
    init(id: String) {
        self.id = id
        _viewModel = StateObject(wrappedValue: UserDetailsViewModel(id: id))
    }
    
    var body: some View {
        Group {
            switch viewModel.viewState {
            case .initialState:
                Text("wkwk")
            case .loading:
                ProgressView()
            case .error(let error):
                Text(error)
            case let .showResult(user):
                VStack {
                    UserDetailsCardView(user: user)
                    RepositoryListView(id: user.id)
                    Spacer()
                }
            }
        }
        .navigationTitle(id)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            viewModel.fetchUserDetails()
        }
    }
}
