//
//  TickTimer.swift
//  The23MinRule
//
//  Created by Karim Mufti on 8/13/25.
//

import Foundation
import Foundation
import Combine

final class TickTimer: ObservableObject {
    @Published var state = TimerState()
    private var timer: AnyCancellable?

    func start() {
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
        state.phase = .finished
        state.remaining = 0
    }

    func reset() {
        timer?.cancel()
        state = TimerState()
    }

    private func tick() {
        guard let end = state.endDate else { return }
        state.remaining = max(0, end.timeIntervalSince(Date()))
        if state.remaining <= 0 {
            timer?.cancel()
            state.phase = .finished
        }
    }
}
