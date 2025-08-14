// Features/Home/StatCards.swift
import SwiftUI

struct StreakCard: View {
    @ObservedObject var store: StreakStore

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            // Left: label + number, pinned to top
            VStack(alignment: .leading, spacing: 6) {
                Text("Day Streak")
                    .font(FontToken.label)
                    .foregroundColor(.appMuted)

                HStack(alignment: .firstTextBaseline, spacing: 8) {
                    Text("\(store.currentStreak)")
                        .font(.system(size: 80, weight: .semibold, design: .rounded))
                    Text("days").foregroundColor(.appMuted)
                }
            }
            .alignmentGuide(.top) { d in d[.top] }   // keep this stack’s top flush

            Spacer(minLength: 12)

            // Right: compact grid, no scroll (so no vertical padding), fewer weeks
            StreakGrid(store: store,
                       weeks: 12,        // ⬅️ fewer columns (reduces width from the left)
                       cell: 14,
                       spacing: 3,
                       scrollable: false,  // ⬅️ no extra vertical padding
                       interactive: false)
                .alignmentGuide(.top) { d in d[.top] } // align grid’s top to the HStack top
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .cardStyle()
    }
}
