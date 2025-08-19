import Foundation
import Combine

final class TickTimer: ObservableObject {
    @Published var state = TimerState()
    @Published var endedEarly = false       

    private var timer: AnyCancellable?
    private let tickInterval: TimeInterval = 0.1

    func start() {
        endedEarly = false                     // ← reset reason
        state.phase = .running
        state.startDate = Date()
        state.endDate = Date().addingTimeInterval(state.duration)
        tick()

        timer?.cancel()
        timer = Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in self?.tick() }
    }

    func stop() {
        timer?.cancel()
        endedEarly = true                      // ← mark as early stop
        state.phase = .finished
        state.remaining = 0
    }

    func reset() {
        timer?.cancel()
        state = TimerState()
        endedEarly = false
    }

    private func tick() {
            guard let end = state.endDate else { return }
            state.remaining = max(0, end.timeIntervalSince(Date()))
            if state.remaining <= 0 {
                timer?.cancel()
                endedEarly = false
                state.phase = .finished
            }
    }
}
