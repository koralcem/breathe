import Foundation

enum AppStorageKeys {
    static let expandDurationKey = "expandDurationKey"
    static let fullPauseDurationKey = "fullPauseDurationKey"
    static let shrinkDurationKey = "shrinkDurationKey"
    static let emptyPauseDurationKey = "emptyPauseDurationKey"
}

enum DefaultTiming {
    static let expandDuration: TimeInterval = 4
    static let fullPauseDuration: TimeInterval = 1
    static let shrinkDuration: TimeInterval = 6
    static let emptyPauseDuration: TimeInterval = 4

    static let minDuration: TimeInterval = 0
    static let maxDuration: TimeInterval = 10
}
