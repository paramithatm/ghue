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
        VStack(alignment: .leading, spacing: 16) {
            
            // profile card
            HStack(spacing: 16) {
                AsyncImage(url: URL(string: user.avatarUrl+"&s=300")) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 64)
                        .cornerRadius(32)
                } placeholder: {
                    ProgressView()
                        .frame(width: 64, height: 64)
                }
                
                VStack(alignment: .leading) {
                    if let fullName = user.fullName {
                        Text(fullName)
                            .title()
                    }
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
