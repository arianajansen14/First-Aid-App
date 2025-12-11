//
//  HomeTabView.swift
//  try2
//
//  Created by ariana jansen on 28/11/2025.
//

import SwiftUI

struct HomeTabView: View {
    var body: some View {
        TabView {

            TrainingView()
                .tabItem {
                    Label("Training", systemImage: "figure.walk")
                }

            AssessmentView()
                .tabItem {
                    Label("Assessment", systemImage: "checkmark.circle")
                }

            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }

            HelpView()
                .tabItem {
                    Label("Help", systemImage: "questionmark.circle")
                }
        }
    }
}

#Preview {
    HomeTabView()
}
