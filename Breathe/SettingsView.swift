import SwiftUI

struct SettingsView: View {
    @AppStorage(AppStorageKeys.expandDurationKey) private var expandDuration: TimeInterval = DefaultTiming.expandDuration
    @AppStorage(AppStorageKeys.fullPauseDurationKey) private var fullPauseDuration: TimeInterval = DefaultTiming.fullPauseDuration
    @AppStorage(AppStorageKeys.shrinkDurationKey) private var shrinkDuration: TimeInterval = DefaultTiming.shrinkDuration
    @AppStorage(AppStorageKeys.emptyPauseDurationKey) private var emptyPauseDuration: TimeInterval = DefaultTiming.emptyPauseDuration

    var body: some View {
        VStack(spacing: 40) {
            TimingSlider(label: "Breath in", duration: $expandDuration)

            TimingSlider(label: "Pause after breath in", duration: $fullPauseDuration)

            TimingSlider(label: "Breathe out", duration: $shrinkDuration)

            TimingSlider(label: "Pause after breath out", duration: $emptyPauseDuration)
        }
        .padding()
    }
}

struct TimingSlider: View {
    let label: String
    @Binding var duration: TimeInterval

    var body: some View {
        VStack {
            HStack {
                Text(label)

                Spacer()

                Text("^[\(Int(duration)) second](inflect: true)")
            }

            Slider(
                value: $duration,
                in: DefaultTiming.minDuration...DefaultTiming.maxDuration,
                step: 1,
                label: { Text("\(label) duration") },
                minimumValueLabel: { Text("\(Int(DefaultTiming.minDuration))") },
                maximumValueLabel: { Text("\(Int(DefaultTiming.maxDuration))") },
            )
        }
    }
}

#Preview {
    SettingsView()
}
