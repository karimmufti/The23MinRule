//
//  TimerActivity+Attributes.swift
//  The23MinRule
//
//  Created by Karim Mufti on 8/18/25.
//

import Foundation
import ActivityKit

/// Live Activity attributes for the 23-minute timer.
struct TimerAttributes: ActivityAttributes {

    /// Dynamic data that can change while the activity runs.
    public struct ContentState: Codable, Hashable {
        /// When the timer started.
        var startDate: Date
        /// When it should end (startDate + duration).
        var endDate: Date
        /// Optional flag if it ended early; not required for the initial MVP.
        var endedEarly: Bool = false
    }

    // Static attributes (rarely needed for this use-case).
    // You can add things like a title or id here later if you want.
}
