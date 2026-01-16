//
//  CPRTrainingView.swift
//  Revive
//

import SwiftUI

struct CPRTrainingView: View {

    @Environment(AppModel.self) private var model

    @State private var currentIndex = 0
    @State private var immersiveOpen = false

    private let steps: [TrainingStep] = [

        // STEP 0
        TrainingStep(
            title: "Locate the Casualty",
            description: "Look around the area and make sure the environment is safe before approaching.",
            sceneName: "TrainingScene",
            customView: nil
        ),

        // STEP 1
        TrainingStep(
            title: "Check Responsiveness",
            description: "Tap their shoulders firmly and ask: “Can you hear me?”",
            sceneName: "TrainingScene",
            customView: nil
        ),

        // STEP 2
        TrainingStep(
            title: "Assess Breathing",
            description: "Look at the chest for movement. Listen and feel for breaths. If not breathing → begin CPR.",
            sceneName: "TrainingScene",
            customView: nil
        ),

        // STEP 3
        TrainingStep(
            title: "Call Emergency Services",
            description: "Call 999 or tell someone nearby to call.",
            sceneName: "TrainingScene",
            customView: nil
        ),

        // STEP 4
        TrainingStep(
            title: "Hand Positioning",
            description: "Place the heel of your hand in the centre of the chest.",
            sceneName: "cprhands",
            customView: nil
        ),

        // STEP 5
        TrainingStep(
            title: "Compression Depth & Rhythm",
            description: "Push 5–6 cm deep at 100–120 compressions per minute.",
            sceneName: "cprhelp",
            customView: nil
        )
    ]

    var body: some View {
        TrainingStepView(
            step: steps[currentIndex],
            immersiveOpen: immersiveOpen,
            onToggleImmersive: toggleImmersive,
            onNext: nextStep
        )
        .navigationTitle("CPR Training")
        .navigationBarTitleDisplayMode(.inline)
    }

    private func toggleImmersive() {
        // Close immersive if already open
        if immersiveOpen {
            model.closeImmersiveSpace()
            immersiveOpen = false
            return
        }

        // Open immersive
        model.loadScene(steps[currentIndex].sceneName!)
        model.openImmersiveSpace()
        immersiveOpen = true
    }

    private func nextStep() {
        if currentIndex < steps.count - 1 {
            currentIndex += 1

            // If immersive is open → update scene immediately
            if immersiveOpen {
                let nextScene = steps[currentIndex].sceneName!
                model.loadScene(nextScene)
            }
        }
    }
}
