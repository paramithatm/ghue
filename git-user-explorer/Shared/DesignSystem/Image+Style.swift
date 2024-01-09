//
//  Image+Style.swift
//  git-user-explorer
//
//  Created by Paramitha on 08/01/24.
//

import Foundation
import SwiftUI

extension Image {
    func icon(_ scale: Scale) -> some View {
        self.imageScale(scale)
            .foregroundStyle(Color.paleBlue4)
    }
}
