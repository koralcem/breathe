import SwiftUI

struct SettingsView: View {
    @State private var breathInDuration = 4
    @State private var pauseAfterBreathInDuration = 1
    @State private var breathOutDuration = 5
    @State private var pauseAfterBreathOutDuration = 1
    // TODO: Make these app storage

    var body: some View {
        List {
            SettingRow(phaseLabel: "Breath in", phaseDuration: $breathInDuration)
            SettingRow(phaseLabel: "Pause after breath in", phaseDuration: $pauseAfterBreathInDuration)
            SettingRow(phaseLabel: "Breath out", phaseDuration: $breathOutDuration)
            SettingRow(phaseLabel: "Pause after breath out", phaseDuration: $pauseAfterBreathOutDuration)
        }
        .navigationTitle("Settings")
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
