//
//  RepositoryListView.swift
//  git-user-explorer
//
//  Created by Paramitha on 05/01/24.
//

import Foundation
import SwiftUI

struct RepositoryListView: View {
    
    @StateObject var viewModel: RepositoryListViewModel
    
    init(id: String) {
        _viewModel = StateObject(wrappedValue: RepositoryListViewModel(id: id))
    }
    
    var body: some View {
        Group {
            switch viewModel.viewState {
            case .initialState:
                Text("wkwk")
            case .loading:
                ProgressView()
            case let .error(error):
                Text(error.localizedDescription)
            case let .showResult(repos):
                NavigationView {
                    List(repos) { repo in
                        NavigationLink(destination: WebView(urlString: repo.repoUrl).toolbar(.hidden)) {
                            RepositoryCellView(repo: repo)
                        }
                    }
                }
            }
        }.onAppear {
            viewModel.fetchRepositoryList()
        }
    }
}

//#Preview {
//    RepositoryListView()
//}
