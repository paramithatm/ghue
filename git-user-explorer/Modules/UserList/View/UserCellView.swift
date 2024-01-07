//
//  UserCellView.swift
//  git-user-explorer
//
//  Created by Paramitha on 05/01/24.
//

import Foundation
import SwiftUI

struct UserCellView: View {
    
    var name: String
    var avatarUrl: String
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(spacing: 8) {
                AsyncImage(url: URL(string: avatarUrl)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 50)
                        .cornerRadius(25)
                } placeholder: {
                    ProgressView()
                        .frame(width: 50, height: 50)
                }

                    
                Text(name)
                    .foregroundStyle(Color.paleBlue2)
                Spacer(minLength: 16)
                HStack {
                    Image(systemName: "plus")
                        .imageScale(.large)
                        .foregroundStyle(.tint)
                }
            }
        }
    }
}

//#Preview {
//    UserCellView(name: "Woohoo", avatarUrl: "")
//}
