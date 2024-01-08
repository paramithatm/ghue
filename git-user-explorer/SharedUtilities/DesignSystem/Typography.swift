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
        self.foregroundStyle(Color.paleBlue8)
            .font(.headline)
    }
    
    func subtitle() -> some View {
        self.foregroundStyle(Color.paleBlue3)
            .font(.callout)
    }
    
    func thinTitle() -> some View {
        self.foregroundStyle(Color.paleBlue8)
            .font(.callout)
    }
    
    func thinSubtitle() -> some View {
        self.foregroundStyle(Color.paleBlue5)
            .font(.subheadline)
    }
    
    func small() -> some View {
        self.foregroundStyle(Color.paleBlue3)
            .font(.footnote)
    }
}
