import SwiftUI

enum BreathState {
    case breathingIn
    case pauseAfterBreathIn
    case breathingOut
    case pauseAfterBreathOut

    init() {
        self = .breathingIn
    }

    func next() -> BreathState {
        switch self {
        case .breathingIn:
            return .pauseAfterBreathIn
        case .pauseAfterBreathIn:
            return .breathingOut
        case .breathingOut:
            return .pauseAfterBreathOut
        case .pauseAfterBreathOut:
            return .breathingIn
        }
    }
}

struct ContentView: View {
    @State private var breathState = BreathState()

    var body: some View {
        Circle()
        // if state is in or after in, scale large
        // if state is out or after out, scale small

        // somehow apply animation during in and out, but not during others
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
