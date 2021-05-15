import SwiftUI

struct BreathingView: View {
    var body: some View {
        NavigationView {
            Circle()
                .toolbar {
                    NavigationLink("Settings", destination: SettingsView())
                }
        }
    }
}

struct BreathingView_Previews: PreviewProvider {
    static var previews: some View {
        BreathingView()
    }
}
