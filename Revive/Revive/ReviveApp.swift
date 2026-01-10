//
//  ReviveApp.swift
//  Revive
//

import SwiftUI

@main
struct ReviveApp: App {

    @State private var appModel = AppModel()

    var body: some Scene {

        // MAIN APP WINDOW
        WindowGroup {
            AppEntryView()
                .environment(appModel)
        }

        // SEPARATE VOLUME WINDOW
        WindowGroup(id: appModel.modelWindowID) {
            AssessmentModelView()
                .environment(appModel)
        }
        .defaultSize(width: 0.35, height: 0.35)
        .windowStyle(.volumetric)
    }
}
