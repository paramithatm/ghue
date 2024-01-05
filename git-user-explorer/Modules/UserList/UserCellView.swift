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
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(spacing: 8) {
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundStyle(.tint)
                Text(name)
                    .foregroundStyle(Color.paleBlue2)
                Spacer(minLength: 16)
                HStack {
                    Image(systemName: "plus")
                        .imageScale(.large)
                        .foregroundStyle(.tint)
                    Image(systemName: "heart")
                        .imageScale(.large)
                        .foregroundStyle(.tint)
                }
            }
        }
    }
}

#Preview {
    UserCellView(name: "Woohoo")
}
