//
//  RepositoryCellView.swift
//  git-user-explorer
//
//  Created by Paramitha on 05/01/24.
//

import Foundation
import SwiftUI

struct RepositoryCellView: View {
    var repo: RepoBasicModel
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "bookmark")
                    .imageScale(.large)
                    .foregroundStyle(.tint)
                Text(repo.fullName)
            }
            if let description = repo.description {
                Text(description)
            }
            HStack {
                HStack {
                    Image(systemName: "book")
                        .imageScale(.large)
                        .foregroundStyle(.tint)
                    Text(repo.language ?? "Unknown language")
                }
                
                HStack {
                    Image(systemName: "star")
                        .imageScale(.large)
                        .foregroundStyle(.tint)
                    Text("\(repo.starsCount)")
                }
            }
        }
    }
}

//#Preview {
//    RepositoryCellView()
//}
//
