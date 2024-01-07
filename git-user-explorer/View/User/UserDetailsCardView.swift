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
        }
    }
    
}
