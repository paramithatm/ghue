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
            HStack(spacing: 16) {
                AsyncImage(url: URL(string: avatarUrl+"&s=300")) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 50)
                        .cornerRadius(25)
                }
            placeholder: {
                    ProgressView()
                        .frame(width: 50, height: 50)
                }

                Text(name)
                    .title()
                Spacer(minLength: 16)
            }
        }
    }
}
