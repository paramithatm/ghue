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
                    .icon(.medium)
                Text(repo.name)
                    .thinTitle()
            }
            if let description = repo.description {
                Text(description)
                    .thinSubtitle()
            }
            HStack {
                if let language = repo.language {
                    HStack {
                        Image(systemName: "book")
                            .icon(.small)
                        Text(language)
                            .small()
                    }
                }
                HStack {
                    Image(systemName: "star")
                        .icon(.small)
                    Text("\(repo.starsCount)")
                        .small()
                }
            }
        }
    }
}
