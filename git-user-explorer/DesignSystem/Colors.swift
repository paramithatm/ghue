//
//  Colors.swift
//  git-user-explorer
//
//  Created by Paramitha on 04/01/24.
//

import Foundation
import SwiftUI

extension Color {
    /// Helper method to generate color from hex string
    init(hex: String) {
            let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
            var int = UInt64()
            Scanner(string: hex).scanHexInt64(&int)
            let a, r, g, b: UInt64
            switch hex.count {
            case 3: // RGB (12-bit)
                (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
            case 6: // RGB (24-bit)
                (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
            case 8: // ARGB (32-bit)
                (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
            default:
                (a, r, g, b) = (255, 0, 0, 0)
            }
            self.init(.sRGB, red: Double(r) / 255, green: Double(g) / 255, blue:  Double(b) / 255, opacity: Double(a) / 255)
        }
    
    /// https://mantine.dev/colors-generator/?color=5474B4
    static let paleBlue0 = Color(hex: "#eef3ff")
    static let paleBlue1 = Color(hex: "#dce4f5")
    static let paleBlue2 = Color(hex: "#b9c7e2")
    static let paleBlue3 = Color(hex: "#94a8d0")
    static let paleBlue4 = Color(hex: "#748dc1")
    static let paleBlue5 = Color(hex: "#5f7cb8")
    static let paleBlue6 = Color(hex: "#5474b4")
    static let paleBlue7 = Color(hex: "#44639f")
    static let paleBlue8 = Color(hex: "#39588f")
    static let paleBlue9 = Color(hex: "#2d4b81")
}
