import AppIntents
import ActivityKit

@available(iOS 17.0, *)
struct StartTimerIntent: AppIntent {
    static var title: LocalizedStringResource = "Start 23-Min Timer"
    static var description = IntentDescription("Starts the 23-minute timer and shows a Live Activity.")
    static var openAppWhenRun: Bool = false

    func perform() async throws -> some IntentResult & ProvidesDialog {
        // 1) OS allows Live Activities?
        let auth = ActivityAuthorizationInfo()
        guard auth.areActivitiesEnabled else {
            return .result(dialog: IntentDialog(
                "Live Activities are disabled. Turn them on in Settings → Face ID & Passcode → Live Activities, and in Settings → The23MinRule → Live Activities."
            ))
        }

        // 2) Start the activity (10s for testing)
        let start = Date()
        let end   = start.addingTimeInterval(10)

        let state   = TimerAttributes.ContentState(startDate: start, endDate: end)
        let content = ActivityContent(state: state, staleDate: end)

        do {
            _ = try Activity<TimerAttributes>.request(
                attributes: TimerAttributes(),
                content: content,
                pushType: nil
            )
            return .result(dialog: IntentDialog("Timer started. Lock the screen to see it."))
        } catch {
            return .result(dialog: IntentDialog("Couldn’t start: \(error.localizedDescription)"))
        }
    }
}

@available(iOS 17.0, *)
struct StopTimerIntent: AppIntent {
    static var title: LocalizedStringResource = "Stop Timer"
    static var openAppWhenRun: Bool = false

    func perform() async throws -> some IntentResult & ProvidesDialog {
        for activity in Activity<TimerAttributes>.activities {
            await activity.end(nil, dismissalPolicy: .immediate)
        }
        return .result(dialog: IntentDialog("Timer stopped."))
    }
}
