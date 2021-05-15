import SwiftUI

struct SettingRow: View {
    let phaseLabel: String
    @Binding var phaseDuration: Int

    var body: some View {
        HStack(alignment: .center) {
            VStack(alignment: .leading) {
                Text(phaseLabel)
                Text("\(phaseDuration) seconds")
            }
            Spacer()
            Stepper("\(phaseLabel): \(phaseDuration) seconds", value: $phaseDuration, in: 0...1000)
                .labelsHidden()
        }
    }
}

struct SettingRow_Previews: PreviewProvider {
    static var previews: some View {
        SettingRow(phaseLabel: "Pause after breath out", phaseDuration: .constant(10))
    }
}
