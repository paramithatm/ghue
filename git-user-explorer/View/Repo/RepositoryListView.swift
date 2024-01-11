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
                EmptyView()
            case .loading where viewModel.repos.isEmpty:
                ProgressView()
            case let .error(message):
                EmptyView(title: "Sorry, there's a problem", subtitle: message)
            case .showResult, .loading:
                List(viewModel.repos) { repo in
                    NavigationLink(destination: WebView(urlString: repo.repoUrl)) {
                        RepositoryCellView(repo: repo)
                    }
                    .onAppear {
                        viewModel.loadMoreContentIfNeeded(currentItem: repo)
                    }
                }
            }
        }
        .onAppear {
            viewModel.fetchRepositoryList()
        }
    }
}
