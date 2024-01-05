//
//  RepositoryCellView.swift
//  git-user-explorer
//
//  Created by Paramitha on 05/01/24.
//

import Foundation
import SwiftUI

struct RepositoryCellView: View {
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundStyle(.tint)
                Text("nh-line-bot")
            }
            Text("Description yadda yadda yadda")
            HStack {
                HStack {
                    Image(systemName: "book")
                        .imageScale(.large)
                        .foregroundStyle(.tint)
                    Text("Swift")
                }
                
                HStack {
                    Image(systemName: "star")
                        .imageScale(.large)
                        .foregroundStyle(.tint)
                    Text("1.2k")
                }
                
                HStack {
                    Image(systemName: "globe")
                        .imageScale(.large)
                        .foregroundStyle(.tint)
                    Text("200")
                }
            }
        }
    }
}

#Preview {
    RepositoryCellView()
}

