import SwiftUI

struct SettingsView: View {

    @State private var path = NavigationPath()

    var body: some View {
        NavigationStack(path: $path) {

            ScrollView {
                VStack(alignment: .leading, spacing: 30) {

                    // TITLE
                    Text("Settings")
                        .font(.largeTitle.bold())

                    // DESCRIPTION BELOW TITLE
                    Text("Customise your training experience. Adjust appearance, accessibility and app preferences.")
                        .font(.title3)
                        .foregroundStyle(.secondary)

                    // =====================================================
                    // SETTINGS BUTTONS
                    // =====================================================
                    VStack(spacing: 20) {

                        settingsButton(
                            title: "Customisation",
                            subtitle: "Change colours, skins and appearance.",
                            icon: "paintpalette"
                        ) {
                            path.append("customisation")
                        }

                        settingsButton(
                            title: "Accessibility",
                            subtitle: "Reduce motion and adjust interaction comfort.",
                            icon: "figure"
                        ) {
                            path.append("accessibility")
                        }

                        settingsButton(
                            title: "App Info",
                            subtitle: "Learn more about Revive and the development team.",
                            icon: "info.circle"
                        ) {
                            path.append("appinfo")
                        }
                    }

                    // =====================================================
                    // DISCLAIMER SECTION (BOTTOM OF PAGE)
                    // =====================================================
                    VStack(alignment: .leading, spacing: 10) {

                        Text("ⓘ Some accessibility settings depend on your Vision Pro system preferences.")
                            .font(.subheadline)
                            .foregroundColor(.secondary)

                        Text("Revive automatically adapts to Reduce Motion, Increase Contrast and Transparency options where supported.")
                            .font(.footnote)
                            .foregroundColor(.secondary.opacity(0.8))
                            .fixedSize(horizontal: false, vertical: true)

                    }
                    .padding(.top, 30)
                    .frame(maxWidth: .infinity, alignment: .leading)

                    Spacer()
                }
                .padding(40)
                .glassBackgroundEffect()
            }

            // NAVIGATION DESTINATIONS
            .navigationDestination(for: String.self) { value in
                switch value {
                case "customisation": CustomisationView()
                case "accessibility": AccessibilitySettingsView()
                case "appinfo": AppInfoView()
                default: Text("Unknown Page")
                }
            }
        }
    }

    // =====================================================
    // FULL-WIDTH TILE BUTTON COMPONENT
    // =====================================================
    private func settingsButton(title: String,
                                subtitle: String,
                                icon: String,
                                action: @escaping () -> Void) -> some View {

        Button(action: action) {
            HStack(spacing: 16) {

                Image(systemName: icon)
                    .font(.title2)
                    .frame(width: 30)

                VStack(alignment: .leading, spacing: 4) {
                    Text(title)
                        .font(.headline)

                    Text(subtitle)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }

                Spacer()

                Image(systemName: "chevron.right")
                    .foregroundColor(.gray)
            }
            .padding(16)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(.ultraThinMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 20))
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    SettingsView()
}
