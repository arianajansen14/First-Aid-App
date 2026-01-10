import SwiftUI

struct ToggleImmersiveSpaceButton: View {

    @Environment(\.dismissImmersiveSpace) private var dismissImmersiveSpace
    @Environment(\.openImmersiveSpace) private var openImmersiveSpace

    var body: some View {
        Button {
            Task { @MainActor in
                await toggleImmersive()
            }
        } label: {
            Text("Start CPR AR Mode")
                .font(.headline)
        }
        .buttonStyle(.borderedProminent)
    }

    @MainActor
    private func toggleImmersive() async {
        let result = await openImmersiveSpace(id: "ImmersiveSpace")
        if result != .opened {
            print("⚠️ Failed to open immersive space")
        }
    }
}
