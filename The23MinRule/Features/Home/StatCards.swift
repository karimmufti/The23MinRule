//
//  StatCards.swift
//  The23MinRule
//
//  Created by Karim Mufti on 8/13/25.
//

import Foundation
import SwiftUI

struct StreakCard: View {
    var streak: Int

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Day Streak")
                .font(FontToken.label)
                .foregroundColor(.appMuted)
            HStack(alignment: .firstTextBaseline, spacing: 8) {
                Text("\(streak)")
                    .font(.system(size: 32, weight: .semibold, design: .rounded))
                Text("days").foregroundColor(.appMuted)
            }
        }
        .cardStyle()
    }
}

struct LastResultCard: View {
    var lastResult: String

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Last Session")
                .font(FontToken.label)
                .foregroundColor(.appMuted)
            Text(lastResult)
                .font(.system(size: 24, weight: .semibold, design: .rounded))
                .foregroundColor(lastResult == "Resisted" ? .appSuccess :
                                 (lastResult == "Relapsed" ? .appWarning : .appText))
        }
        .cardStyle()
    }
}
