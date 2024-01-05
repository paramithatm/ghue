//
//  UserDetailsView.swift
//  git-user-explorer
//
//  Created by Paramitha on 04/01/24.
//

import Foundation
import SwiftUI

struct UserDetailsView: View {
    
    
    var body: some View {
        VStack(alignment: .leading) {
            
            // profile card
            HStack {
                Image(systemName: "globe")
                    .frame(width: 100, height: 100)
                    .foregroundStyle(.tint)
                    .background(Color.paleBlue0)
                VStack(alignment: .leading) {
                    Text("Paramitha")
                    Text("mithatm")
                }
            }
            
            // repo number - following - followers
            HStack {
                VStack {
                    Text("100")
                    Text("Repositories")
                }
                
                VStack {
                    Text("100")
                    Text("Following")
                }
                
                VStack {
                    Text("100")
                    Text("Followers")
                }
            }
            
            // repo list
        }
    }
}

#Preview {
    UserDetailsView()
}
