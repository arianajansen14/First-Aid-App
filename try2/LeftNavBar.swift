//
//  LeftNavBar.swift
//  try2
//
//  Created by ariana jansen on 04/12/2025.
//

import SwiftUI

/// A persistent left-side navigation column.
/// Always visible except when the initial home window is open.
struct LeftNavBar: View {

    /// Which section of the app is currently active?
    @Binding var selectedSection: AppSection

    var body: some View {
        VStack(alignment: .leading, spacing: 24) {

            // MARK: - ReGen: Training & Assessment
            Button {
                selectedSection = .training
            } label: {
                Label("Training", systemImage: "figure.stand")
            }

            Button {
                selectedSection = .assessment
            } label: {
                Label("Assessment", systemImage: "checkmark.seal")
            }

            Divider().padding(.vertical, 4)

            // MARK: - Achievements
            Button {
                selectedSection = .achievements
            } label: {
                Label("Achievements", systemImage: "book.closed.fill")
            }

            // MARK: - Settings
            Button {
                selectedSection = .settings
            } label: {
                Label("Settings", systemImage: "gear")
            }

            // MARK: - Help / Tutorial
            Button {
                selectedSection = .help
            } label: {
                Label("Help", systemImage: "questionmark.circle")
            }

            Spacer()

            // MARK: - Save & Quit
            Button(role: .destructive) {
                quitApp()
            } label: {
                Label("Save & Quit", systemImage: "power")
            }
        }
        .padding(.top, 40)
        .padding(.horizontal, 12)
        .frame(width: 200)
        .glassBackgroundEffect()
    }
}

// MARK: - Helpers

/// Fake quit function — visionOS apps cannot programmatically close,
/// so this simulates "saving and returning home".
func quitApp() {
    print("Saving progress and exiting…")
}

/// All top-level sections the app can switch between.
enum AppSection {
    case home
    case training
    case assessment
    case achievements
    case settings
    case help
}
