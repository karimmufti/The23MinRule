//
//  DesignTokens.swift
//  The23MinRule
//
//  Created by Karim Mufti on 8/13/25.
//

import Foundation
import SwiftUI

enum FontToken {
    static let bigNumber = Font.system(size: 60, weight: .bold,   design: .default)
    static let title     = Font.system(size: 22, weight: .semibold, design: .rounded)
    static let body      = Font.system(size: 16, weight: .regular, design: .rounded)
    static let label     = Font.system(size: 13, weight: .medium, design: .rounded)
}

extension Color {
    static let appBg        = Color(red: 0.05, green: 0.04, blue: 0.04)   // #0D0A0A
    static let appSurface   = Color(red: 0.08, green: 0.06, blue: 0.07)   // #151013
    static let appCard      = Color(red: 0.11, green: 0.08, blue: 0.09)   // #1B1518
    static let appPrimary   = Color(red: 0.88, green: 0.19, blue: 0.19)   // #E03131
    static let appPrimaryHi = Color(red: 1.0,  green: 0.23, blue: 0.19)   // #FF3B30
    static let appPrimaryLo = Color(red: 0.69, green: 0.0,  blue: 0.13)   // #B00020
    static let appText      = Color(red: 0.93, green: 0.93, blue: 0.93)   // #EDECEC
    static let appMuted     = Color(red: 0.60, green: 0.54, blue: 0.56)   // #9A898F
    static let appSuccess   = Color(red: 0.20, green: 0.78, blue: 0.35)   // #34C759
    static let appWarning   = Color(red: 1.0,  green: 0.80, blue: 0.0)    // #FFCC00
}

extension View {
    func cardStyle() -> some View {
        self
            .padding(16)
            .background(Color.appCard)
            .cornerRadius(22)
            .shadow(color: .black.opacity(0.35), radius: 20, x: 0, y: 10)
            .overlay(
                RoundedRectangle(cornerRadius: 22)
                    .stroke(Color.white.opacity(0.05), lineWidth: 1)
            )
    }
}
