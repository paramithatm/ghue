//
//  ContentView.swift
//  git-user-explorer
//
//  Created by Paramitha on 04/01/24.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        NavigationView {
            SearchUserView()
        }.navigationTitle("GitHub User Explorer")
    }
}

#Preview {
    ContentView()
}
