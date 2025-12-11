//
//  ContentView.swift
//  try2
//
//  Created by ariana jansen on 28/11/2025.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.openWindow) private var openWindow
    @Environment(\.dismissWindow) private var dismissWindow

    var body: some View {
        HomeTabView()
            .padding(40)
            .glassBackgroundEffect()
            .onReceive(NotificationCenter.default.publisher(for: .openMainMenu)) { _ in
                // Close immersive training window if open
                dismissWindow(id: "training")
                // Close assessment window if open
                dismissWindow(id: "assessment")
                // Reopen main menu window
                openWindow(id: "mainMenu")
            }
            .onReceive(NotificationCenter.default.publisher(for: .openSettings)) { _ in
                // Close training + assessment windows
                dismissWindow(id: "training")
                dismissWindow(id: "assessment")
                // Open the main menu window in Settings mode
                openWindow(id: "mainMenuSettings")
            }
            .onReceive(NotificationCenter.default.publisher(for: .openHelp)) { _ in
                // Close training + assessment windows
                dismissWindow(id: "training")
                dismissWindow(id: "assessment")
                // Open the main menu window in Help mode
                openWindow(id: "mainMenuHelp")
            }
            .onReceive(NotificationCenter.default.publisher(for: .quitApp)) { _ in
                // Close all windows and return to VisionOS app grid
                dismissWindow(id: "training")
                dismissWindow(id: "assessment")
                dismissWindow(id: "mainMenu")
                // System quit request
                UIApplication.shared.perform(#selector(NSXPCConnection.suspend))
            }
    }
}

#Preview {
    ContentView()
}
