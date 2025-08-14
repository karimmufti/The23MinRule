//
//  TimerRing.swift
//  The23MinRule
//
//  Created by Karim Mufti on 8/13/25.
//

import Foundation
import SwiftUI

struct TimerRing: View {
    var progress: Double
    var size: CGFloat = 260

    var body: some View {
        ZStack {
            Circle()
                .stroke(Color.appPrimaryLo.opacity(0.25), lineWidth: 18)

            Circle()
                .trim(from: 0, to: progress)
                .stroke(
                    AngularGradient(gradient: Gradient(colors: [.appPrimaryHi, .appPrimary, .appPrimaryLo, .appPrimaryHi]),
                                    center: .center),
                    style: StrokeStyle(lineWidth: 18, lineCap: .round)
                )
                .rotationEffect(.degrees(-90))
                .shadow(color: Color.appPrimary.opacity(0.6), radius: 10)
                .shadow(color: Color.appPrimaryHi.opacity(0.55), radius: 25)
                .animation(.easeInOut(duration: 0.2), value: progress)
        }
        .frame(width: size, height: size)
    }
}
