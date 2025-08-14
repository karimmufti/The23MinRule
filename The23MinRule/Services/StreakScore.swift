//
//  StreakScore.swift
//  The23MinRule
//
//  Created by Karim Mufti on 8/14/25.
//

import Foundation
import Combine

final class StreakStore: ObservableObject {
    private let key = "streak_days_v1" // UserDefaults key
    private let cal = Calendar.current

    // yyyy-MM-dd for stable, timezone-safe day keys
    private static let df: DateFormatter = {
        let d = DateFormatter()
        d.calendar = Calendar.current
        d.timeZone = .current
        d.dateFormat = "yyyy-MM-dd"
        return d
    }()

    @Published private(set) var days: Set<String>

    init() {
        if let arr = UserDefaults.standard.array(forKey: key) as? [String] {
            self.days = Set(arr)
        } else {
            self.days = []
        }
    }

    // MARK: - Public API

    func markTodayComplete() {
        mark(date: Date())
    }

    func unmarkToday() {
        unmark(date: Date())
    }

    func toggle(_ date: Date) {
        let k = keyFor(date)
        if days.contains(k) { days.remove(k) } else { days.insert(k) }
        persist()
    }

    func mark(date: Date) {
        days.insert(keyFor(date))
        persist()
    }

    func unmark(date: Date) {
        days.remove(keyFor(date))
        persist()
    }

    func isCompleted(_ date: Date) -> Bool {
        days.contains(keyFor(date))
    }

    /// Count of consecutive completed days ending **today**
    var currentStreak: Int {
        var count = 0
        var d = cal.startOfDay(for: Date())
        while isCompleted(d) {
            count += 1
            d = cal.date(byAdding: .day, value: -1, to: d)!
        }
        return count
    }

    // MARK: - Helpers

    private func keyFor(_ date: Date) -> String {
        StreakStore.df.string(from: cal.startOfDay(for: date))
    }

    private func persist() {
        UserDefaults.standard.set(Array(days), forKey: key)
    }
}
