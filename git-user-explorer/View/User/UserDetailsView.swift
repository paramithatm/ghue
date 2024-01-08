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
    
    init(id: String) {
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
                Text(error.localizedDescription)
            case let .showResult(user):
                VStack {
                    UserDetailsCardView(user: user)
                    RepositoryListView(id: user.id)
                    Spacer()
                }
                
            }
        }.onAppear {
            viewModel.fetchUserDetails()
        }
    }
}

//#Preview {
//    UserDetailsView()
//}
