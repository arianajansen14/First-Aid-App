//
//  MainTabView.swift
//  Revive
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {

            TrainingView()
                .tabItem {
                    Label("Training", systemImage: "figure.strengthtraining.traditional")
                }

            AssessmentView()
                .tabItem {
                    Label("Assessment", systemImage: "checkmark.circle")
                }

            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gearshape")
                }

            HelpView()
                .tabItem {
                    Label("Help", systemImage: "questionmark.circle")
                }
        }
    }
}

#Preview {
    MainTabView()
}
