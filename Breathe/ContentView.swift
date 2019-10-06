import SwiftUI

struct BreathTimingSettings {
    var breathIn = 4
    var pauseAfterBreathIn = 0
    var breathOut = 5
    var pauseAfterBreathOut = 0
}

struct ContentView: View {
    @State var settings: BreathTimingSettings

    var body: some View {
        NavigationView {
            VStack {
                Text("Breath in: \(settings.breathIn)")
                Text("Pause after breath in: \(settings.pauseAfterBreathIn)")
                Text("Breath out: \(settings.breathOut)")
                Text("Pause after breath out: \(settings.pauseAfterBreathOut)")
            }.navigationBarItems(trailing:
                NavigationLink("Timings", destination: TimingsView(settings: $settings))
            )
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(settings: BreathTimingSettings())
    }
}

struct TimingsView: View {
    @Binding var settings: BreathTimingSettings

    var body: some View {
        VStack {
            Stepper(value: $settings.breathIn, in: 1...10) {
                Text("Breath in: \(settings.breathIn) seconds")
            }
            Stepper(value: $settings.pauseAfterBreathIn, in: 0...10) {
                Text("Pause after breath in: \(settings.pauseAfterBreathIn) seconds")
            }
            Stepper(value: $settings.breathOut, in: 1...10) {
                Text("Breath out: \(settings.breathOut) seconds")
            }
            Stepper(value: $settings.pauseAfterBreathOut, in: 0...10) {
                Text("Pause after breath out: \(settings.pauseAfterBreathOut) seconds")
            }
        }
    }
}
