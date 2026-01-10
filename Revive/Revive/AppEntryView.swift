//
//  AppEntryView.swift
//  Revive
//
//  Created by ariana jansen on 06/01/2026.
//


import SwiftUI

struct AppEntryView: View {

    @State private var hasEnteredApp = false

    var body: some View {
        if hasEnteredApp {
            MainTabView()   // your current main UI
        } else {
            LandingPageView(hasEnteredApp: $hasEnteredApp)
        }
    }
}

#Preview {
    AppEntryView()
}
