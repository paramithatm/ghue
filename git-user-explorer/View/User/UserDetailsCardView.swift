//
//  UserDetailsCardView.swift
//  git-user-explorer
//
//  Created by Paramitha on 07/01/24.
//

import Foundation
import SwiftUI

struct UserDetailsCardView: View {
    
    var user: UserDetailsModel
    
    var body: some View {
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
                        .title()
                    Text(user.username)
                        .subtitle()
                }
            }
            
            // repo number - following - followers
            HStack {
                VStack {
                    Text("\(user.publicRepoCount)")
                        .title()
                    Text("Repositories")
                        .subtitle()
                }
                Spacer()
                VStack {
                    Text("\(user.followingCount)")
                        .title()
                    Text("Following")
                        .subtitle()
                }
                Spacer()
                VStack {
                    Text("\(user.followersCount)")
                        .title()
                    Text("Followers")
                        .subtitle()
                }
            }
        }.padding(16)
    }
    
}

#Preview {
    UserDetailsCardView(user: UserDetailsModel(username: "paramithatm", fullName: "Paramitha", avatarUrl: "https://avatars.githubusercontent.com/u/24902812?s=100", followingCount: 100, followersCount: 20, publicRepoCount: 69))
}
