//
//  Typography.swift
//  git-user-explorer
//
//  Created by Paramitha on 08/01/24.
//

import Foundation
import SwiftUI

extension Text {
    func title() -> some View {
        self.foregroundStyle(Color.darkBlue)
            .font(.headline)
    }
    
    func subtitle() -> some View {
        self.foregroundStyle(Color.lightBlue)
            .font(.callout)
    }
    
    func thinTitle() -> some View {
        self.foregroundStyle(Color.darkBlue)
            .font(.callout)
    }
    
    func thinSubtitle() -> some View {
        self.foregroundStyle(Color.justBlue)
            .font(.subheadline)
    }
    
    func small() -> some View {
        self.foregroundStyle(Color.lightBlue)
            .font(.footnote)
    }
}
