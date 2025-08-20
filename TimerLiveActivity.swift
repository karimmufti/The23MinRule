import ActivityKit
import WidgetKit
import SwiftUI

// This defines how your Live Activity looks on the Lock Screen and Dynamic Island.
struct TimerLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: TimerAttributes.self) { context in
            // LOCK SCREEN (expanded) — shows during the activity
            LockScreenTimerView(context: context)
        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded island (long-press)
                DynamicIslandExpandedRegion(.center) {
                    LockScreenTimerView(context: context)
                }
            } compactLeading: {
                // Left pill
                Text("23")
                    .font(.system(size: 12, weight: .bold))
            } compactTrailing: {
                // Right pill: countdown
                Text(context.state.endDate, style: .timer)
                    .font(.system(size: 12, weight: .bold, design: .monospaced))
            } minimal: {
                // Dot view
                Circle().fill(Color.appPrimary).frame(width: 10, height: 10)
            }
        }
    }
}

// Simple lock-screen layout with a ring + countdown text
private struct LockScreenTimerView: View {
    let context: ActivityViewContext<TimerAttributes>

    var body: some View {
        ZStack {
            // System-animated progress based on start/end dates
            ProgressView(timerInterval: context.state.startDate...context.state.endDate, countsDown: true)
                .tint(Color.appPrimary)
                .progressViewStyle(.circular)

            // Live, system-updating countdown
            Text(context.state.endDate, style: .timer)
                .font(.system(size: 22, weight: .heavy, design: .default))
                .monospacedDigit()
                .foregroundColor(.appText)
                .shadow(color: Color.appPrimary.opacity(0.25), radius: 4)
        }
        .padding(12)
        .background(Color.appSurface)
    }
}

// Add this widget to the bundle so it ships with your extension.
