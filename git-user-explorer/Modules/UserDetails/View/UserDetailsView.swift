//
//  UserDetailsView.swift
//  git-user-explorer
//
//  Created by Paramitha on 04/01/24.
//

import Foundation
import SwiftUI

struct UserDetailsView: View {
    
    @StateObject var viewModel = UserDetailsViewModel(id: "")
    
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
                VStack(alignment: .leading) {
                    
                    // profile card
                    HStack {
                        AsyncImage(url: URL(string: user.avatarUrl)) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 80)
                                .cornerRadius(40)
                        } placeholder: {
                            ProgressView()
                                .frame(width: 80, height: 80)
                        }
                        
                        
                        VStack(alignment: .leading) {
                            Text(user.fullName)
                            Text(user.username)
                        }
                    }
                    
                    // repo number - following - followers
                    HStack {
                        VStack {
                            Text("\(user.publicRepoCount)")
                            Text("Repositories")
                        }
                        
                        VStack {
                            Text("\(user.followingCount)")
                            Text("Following")
                        }
                        
                        VStack {
                            Text("\(user.followersCount)")
                            Text("Followers")
                        }
                    }
                    
                    // repo list
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
