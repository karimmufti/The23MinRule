//
//  Glow.swift
//  The23MinRule
//
//  Created by Karim Mufti on 8/14/25.
//

import Foundation
import SwiftUI

struct Glow: ViewModifier {
    var color: Color
    var baseRadius: CGFloat = 8
    var intensity: Double = 0.5   // 0–1

    func body(content: Content) -> some View {
        content
            .shadow(color: color.opacity(intensity), radius: baseRadius)
            .shadow(color: color.opacity(intensity * 0.7), radius: baseRadius * 2)
    }
}

extension View {
    func glow(color: Color, radius: CGFloat = 8, intensity: Double = 0.5) -> some View {
        modifier(Glow(color: color, baseRadius: radius, intensity: intensity))
    }
}
