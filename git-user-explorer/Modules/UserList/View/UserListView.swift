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
        Group {
            switch viewModel.viewState {
            case .initialState:
                Text("Baru pertama")
            case .loading:
                ProgressView()
            case .showResult(let string):
                List {
                    UserCellView(name: string)
                    UserCellView(name: "Mitha")
                    UserCellView(name: "Mitha")
                    UserCellView(name: "Mitha")
                    UserCellView(name: "Mitha")
                    UserCellView(name: "Mitha")
                }
            case .error(let error):
                Text(error.localizedDescription)
            }
        }.onAppear {
            viewModel.fetchUserList()
        }
    }
}

#Preview {
    UserListView()
}
