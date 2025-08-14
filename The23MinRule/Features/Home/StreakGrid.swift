import SwiftUI

struct StreakGrid: View {
    @ObservedObject var store: StreakStore

    // tuning
    var weeks: Int = 16            // more columns (adds to the left)
    var cell: CGFloat = 14         // bigger boxes
    var spacing: CGFloat = 3
    var scrollable: Bool = true    // keep true so you can pan for older weeks
    var interactive: Bool = false  // off by default (prevents tapping)

    private let cal = Calendar.current

    var body: some View {
        let start = gridStartDate(weeksBack: weeks)

        Group {
            if scrollable {
                ScrollView(.horizontal, showsIndicators: false) {
                    gridStack(start: start)
                        .padding(.vertical, 6)
                }
            } else {
                gridStack(start: start)
            }
        }
    }

    // MARK: - Layout

    @ViewBuilder
    private func gridStack(start: Date) -> some View {
        HStack(alignment: .top, spacing: spacing) {
            // left → right: oldest → newest (so adding weeks extends left side)
            ForEach(0..<weeks, id: \.self) { w in
                VStack(spacing: spacing) {
                    ForEach(0..<7, id: \.self) { r in
                        let date = cal.date(byAdding: .day, value: w * 7 + r, to: start)!
                        DayCell(date: date, isOn: store.isCompleted(date))
                    }
                }
            }
        }
    }

    private func gridStartDate(weeksBack: Int) -> Date {
        let today = Date()
        let startOfThisWeek = cal.dateInterval(of: .weekOfYear, for: today)!.start
        // go back (weeks-1) weeks so the final column is the current week
        return cal.date(byAdding: .weekOfYear, value: -(weeksBack - 1), to: startOfThisWeek)!
    }

    // MARK: - Cell

    @ViewBuilder
    private func DayCell(date: Date, isOn: Bool) -> some View {
        let startOfCell = cal.startOfDay(for: date)
        let startOfToday = cal.startOfDay(for: Date())
        let canTap = interactive && startOfCell <= startOfToday

        // base square (unchecked = dark background, no outline)
        let base = RoundedRectangle(cornerRadius: 3, style: .continuous)
            .fill(isOn ? Color.appPrimary : Color.appBg)
            .frame(width: cell, height: cell)
            .accessibilityLabel(Text(date.formatted(date: .abbreviated, time: .omitted)))
            .accessibilityValue(Text(isOn ? "Completed" : "Not completed"))

        // build the visual (glow only when on) — use if/else so types match
        let visual: some View = Group {
            if isOn {
                base.glow(color: .appPrimary, radius: 3, intensity: 0.9)
            } else {
                base
            }
        }

        // optionally add interaction (only for today or past)
        if canTap {
            visual
                .contentShape(Rectangle())
                .onTapGesture { store.toggle(date) }
        } else {
            visual
        }
    }
}
