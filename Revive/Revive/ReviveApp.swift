//
//  ReviveApp.swift
//  Revive
//

import SwiftUI

@main
struct ReviveApp: App {

    @State private var appModel = AppModel()

    var body: some Scene {

        // ------------------------------
        // MAIN APP WINDOW
        // ------------------------------
        WindowGroup {
            AppEntryView()
                .environment(appModel)
        }

        // REAL VISION PRO → VOLUMETRIC MODEL WINDOW
        // SIMULATOR → 2D FALLBACK WINDOW
        #if targetEnvironment(simulator)
        // SIMULATOR FALLBACK WINDOW
        WindowGroup(id: appModel.modelWindowID) {
            AssessmentModelFallbackView()
                .environment(appModel)
        }
        .defaultSize(width: 500, height: 500)
        .windowStyle(.plain)

        #else
        // REAL DEVICE VOLUMETRIC WINDOW
        WindowGroup(id: appModel.modelWindowID) {
            AssessmentModelView()
                .environment(appModel)
        }
        .defaultSize(width: 0.35, height: 0.35)
        .windowStyle(.volumetric)
        #endif
    }
}
