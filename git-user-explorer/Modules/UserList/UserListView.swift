//
//  UserListView.swift
//  git-user-explorer
//
//  Created by Paramitha on 04/01/24.
//

import Foundation
import SwiftUI

struct UserListView: View {
    
    @StateObject var viewModel = UserListViewModel()
    
    var body: some View {
        List {
            UserCellView(name: "Mitha")
            UserCellView(name: "Mitha")
            UserCellView(name: "Mitha")
            UserCellView(name: "Mitha")
            UserCellView(name: "Mitha")
        }
    }
}

#Preview {
    UserListView()
}
