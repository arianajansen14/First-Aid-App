import SwiftUI

struct SettingsView: View {

    @State private var path = NavigationPath()

    var body: some View {
        NavigationStack(path: $path) {

            VStack(alignment: .leading, spacing: 30) {

                Text("Settings")
                    .font(.largeTitle.bold())

                Divider()

                // BUTTON LIST
                VStack(alignment: .leading, spacing: 20) {

                    Button {
                        path.append("customisation")
                    } label: {
                        settingsRow(title: "Customisation", icon: "paintpalette")
                    }

                    Button {
                        path.append("accessibility")
                    } label: {
                        settingsRow(title: "Accessibility", icon: "figure")
                    }

                    Button {
                        path.append("audio")
                    } label: {
                        settingsRow(title: "Audio & Haptics", icon: "waveform")
                    }

                    Button {
                        path.append("appinfo")
                    } label: {
                        settingsRow(title: "App Info", icon: "info.circle")
                    }
                }

                Spacer()

            }
            .padding(40)
            .glassBackgroundEffect()

            // DESTINATIONS
            .navigationDestination(for: String.self) { value in
                switch value {

                case "customisation":
                    CustomisationView()

                case "accessibility":
                    Text("Accessibility Settings")
                        .font(.title)

                case "audio":
                    Text("Audio & Haptics Settings")
                        .font(.title)

                case "appinfo":
                    Text("App Info")
                        .font(.title)

                default:
                    Text("Unknown Page")
                }
            }
        }
    }

    // MARK: - Row Style
    private func settingsRow(title: String, icon: String) -> some View {
        HStack {
            Image(systemName: icon)
            Text(title)
                .font(.headline)
            Spacer()
            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
        }
        .padding(12)
        .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 12))
    }
}

#Preview {
    SettingsView()
}
