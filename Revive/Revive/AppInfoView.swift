import SwiftUI

struct AppInfoView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 10) {

                // =====================================================
                // LOGO
                // (Replace this with your final asset later)
                // =====================================================
                RoundedRectangle(cornerRadius: 20)
                    .fill(.ultraThinMaterial)
                    .frame(width: 120, height: 120)
                    .overlay(
                        Text("🩺")
                            .font(.system(size: 55))
                    )
                    .padding(.top, 0)

                // =====================================================
                // TITLE + VERSION
                // =====================================================
                VStack(spacing: 6) {
                    Text("Revive")
                        .font(.largeTitle.bold())

                    Text(appVersionString)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }

                Divider().padding(.horizontal)

                // =====================================================
                // ABOUT SECTION
                // =====================================================
                VStack(alignment: .leading, spacing: 12) {

                    Text("About Revive")
                        .font(.title2.bold())

                    Text("""
Revive is a prototype first-aid training experience created for the UAL × Apple Development Program 2025–26.

This app demonstrates:
• Interactive CPR and first-aid walkthroughs  
• Customisable training models  
• Accessibility-first design  

Revive is not a medical device and should not replace formal first-aid certification.
""")
                        .font(.callout)
                        .foregroundColor(.primary)
                }
                .padding(.horizontal)

                // =====================================================
                // CREDITS SECTION
                // =====================================================
                VStack(alignment: .leading, spacing: 10) {

                    Text("Credits")
                        .font(.title2.bold())

                    Text("""
Designed and developed by Ariana Jansen, Dajia Ly, and McKennzie Hamilton.

Created as part of the Apple Development Program.
""")
                        .font(.callout)
                        .foregroundColor(.secondary)
                }
                .padding(.horizontal)

                Spacer(minLength: 60)
            }
            // Makes layout look centered and clean
            .frame(maxWidth: 600)
        }
        .navigationTitle("App Info")
        .navigationBarTitleDisplayMode(.inline)
    }

    // Reads your app version automatically
    private var appVersionString: String {
        let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0"
        let build = Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? "1"
        return "Version \(version) (Build \(build))"
    }
}

#Preview {
    NavigationStack {
        AppInfoView()
    }
}
