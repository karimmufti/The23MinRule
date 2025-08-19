//
//  TimerStats.swift
//  The23MinRule
//
//  Created by Karim Mufti on 8/13/25.
//

import Foundation
import Foundation

enum TimerPhase { case idle, running, finished }

struct TimerState {
    var duration: TimeInterval = 10
    var startDate: Date? = nil
    var endDate: Date? = nil
    var remaining: TimeInterval = 10
    var phase: TimerPhase = .idle

    var progress: Double {
        guard duration > 0 else { return 0 }
        return max(0, min(1, 1.0 - remaining / duration))
    }

    var formattedRemaining: String {
        // show 00:00 only when remaining == 0
        let totalSeconds = max(0, Int(ceil(remaining)))
        let m = totalSeconds / 60
        let s = totalSeconds % 60
        return String(format: "%02d:%02d", m, s)

    }
}
