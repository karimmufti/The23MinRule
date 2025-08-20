//
//  StreakStore.swift
//  The23MinRule
//
//  Created by Karim Mufti on 8/14/25.
//  Updated: counts through yesterday if today isn’t completed.
//

import Foundation
import Combine

final class StreakStore: ObservableObject {
    private let key = "streak_days_v1"              // UserDefaults key
    private let cal = Calendar.current

    // yyyy-MM-dd for stable, timezone-safe day keys
    private static let df: DateFormatter = {
        let d = DateFormatter()
        d.calendar = Calendar.current
        d.timeZone = .current
        d.dateFormat = "yyyy-MM-dd"
        return d
    }()

    // Persisted set of completed day keys (e.g., "2025-08-19")
    @Published private(set) var days: Set<String>

    // MARK: - Init

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
        if days.contains(k) {
            days.remove(k)
        } else {
            days.insert(k)
        }
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

    /// Count of consecutive completed days ending **today if completed**, otherwise **yesterday**.
    var currentStreak: Int { currentStreak(asOf: Date()) }

    /// Call this on launch / foreground / day-change to force views to recompute.
    func refresh() {
        // No state change occurs when a new day starts, so poke observers.
        objectWillChange.send()
    }

    // MARK: - Helpers

    private func currentStreak(asOf now: Date) -> Int {
        var cursor = cal.startOfDay(for: now)

        // If today isn't completed yet, start counting from yesterday.
        if !isCompleted(cursor) {
            cursor = cal.date(byAdding: .day, value: -1, to: cursor)!
        }

        var count = 0
        while isCompleted(cursor) {
            count += 1
            cursor = cal.date(byAdding: .day, value: -1, to: cursor)!
        }
        return count
    }

    private func keyFor(_ date: Date) -> String {
        StreakStore.df.string(from: cal.startOfDay(for: date))
    }

    private func persist() {
        UserDefaults.standard.set(Array(days), forKey: key)
    }
}

