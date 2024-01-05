//
//  RepositoryListView.swift
//  git-user-explorer
//
//  Created by Paramitha on 05/01/24.
//

import Foundation
import SwiftUI

struct RepositoryListView: View {
    
    var body: some View {
        List {
            RepositoryCellView()
            RepositoryCellView()
            RepositoryCellView()
        }
    }
}

#Preview {
    RepositoryListView()
}
