import SwiftUI

struct CircleIndicatorView: View {
    @AppStorage(AppStorageKeys.expandDurationKey) private var expandDuration: TimeInterval = DefaultTiming.expandDuration
    @AppStorage(AppStorageKeys.fullPauseDurationKey) private var fullPauseDuration: TimeInterval = DefaultTiming.fullPauseDuration
    @AppStorage(AppStorageKeys.shrinkDurationKey) private var shrinkDuration: TimeInterval = DefaultTiming.shrinkDuration
    @AppStorage(AppStorageKeys.emptyPauseDurationKey) private var emptyPauseDuration: TimeInterval = DefaultTiming.emptyPauseDuration

    @AppStorage(AppStorageKeys.showIntroText) private var showIntroText = true

    private var totalCycleTime: TimeInterval {
        expandDuration + fullPauseDuration + shrinkDuration + emptyPauseDuration
    }

    var body: some View {
        NavigationStack {
            TimelineView(.animation) { context in
                let elapsedTime = context.date.timeIntervalSinceReferenceDate
                let timeInCycle = elapsedTime.truncatingRemainder(dividingBy: totalCycleTime)

                ZStack {
                    Circle()
                        .stroke(.blue, lineWidth: 2)

                    Circle()
                        .fill(.blue)
                        .scaleEffect(scale(for: timeInCycle))
                }
                .toolbar {
                    ToolbarItem(placement: .primaryAction) {
                        NavigationLink("Timings") {
                            SettingsView()
                        }
                    }
                }
                .sheet(isPresented: $showIntroText) {
                    Text("Breathe in as the circle expands, and out as it shrinks.")
                        .padding()
                        .presentationDetents([.medium])
                }
            }
            .padding()
        }
    }

    // Calculate the scale to use on the circle for a given time in the cycle
    private func scale(for timeInCycle: TimeInterval) -> CGFloat {
        let minScale = 0.0
        let maxScale = 1.0

        // If we're expanding...
        if timeInCycle < expandDuration {
            // figure out how far along the expansion we are
            let expansionProgress = timeInCycle / expandDuration
            // interpolate from min towards max scale by that amount
            return minScale + (maxScale - minScale) * expansionProgress
        }

        // If we're paused when full
        if timeInCycle < expandDuration + fullPauseDuration {
            return maxScale // just use max scale
        }

        // If we're shrinking
        if timeInCycle < expandDuration + fullPauseDuration + shrinkDuration {
            // figure out how far along the shrinking we are
            let timeInShrinkingPhase = timeInCycle - (expandDuration + fullPauseDuration)
            let shrinkProgress = timeInShrinkingPhase / shrinkDuration
            // interpolated from max towards min by that amount
            return maxScale - (maxScale - minScale) * shrinkProgress
        }

        // If we end up here, we must in the pause when empty
        return minScale
    }
}

#Preview {
    CircleIndicatorView()
}
