//
//  RecoveryTrainingView.swift
//  Revive
//

import SwiftUI

struct RecoveryTrainingView: View {

    @State private var currentIndex = 0

    // MARK: - Recovery Steps
    private let recoverySteps: [TrainingStep] = [

        TrainingStep(
            title: "Roll Into Recovery Position",
            description: "Pull the bent knee and roll the person toward you onto their side.",
            sceneName: nil,        // <- NO IMMERSIVE SCENE
            customView: nil
        ),

        TrainingStep(
            title: "Monitor Until Help Arrives",
            description: "Stay with them and check breathing regularly.",
            sceneName: nil,        // <- NO IMMERSIVE SCENE
            customView: nil
        )
    ]

    // MARK: - BODY
    var body: some View {
        TrainingStepView(
            step: recoverySteps[currentIndex],
            immersiveOpen: false,   // <- Not used for recovery
            onToggleImmersive: { },            // <- Empty action
            onNext: advanceStep
        )
        .navigationTitle("Recovery Position")
        .navigationBarTitleDisplayMode(.inline)
    }

    // MARK: - Step Advancement
    private func advanceStep() {
        if currentIndex < recoverySteps.count - 1 {
            currentIndex += 1
        }
    }
}
