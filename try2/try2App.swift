//
//  try2App.swift
//  try2
//
//  Created by ariana jansen on 28/11/2025.
//

import SwiftUI

@main
struct try2App: App {

    var body: some Scene {

        // MAIN WINDOW WITH TABS
        WindowGroup(id: "main") {
            ContentView()
        }
        .windowStyle(.plain)


        // TRAINING — immersive mannequin with training sequences
        ImmersiveSpace(id: "Immersive") {
            TrainingImmersiveView()
        }
        .immersionStyle(selection: .constant(.mixed), in: .mixed)


        // ASSESSMENT — immersive mannequin for zone selection
        ImmersiveSpace(id: "assessmentImmersive") {
            AssessmentImmersiveView()
        }
        .immersionStyle(selection: .constant(.mixed), in: .mixed)

    }
}
