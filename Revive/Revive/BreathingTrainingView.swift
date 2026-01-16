//
//  BreathingTrainingView.swift
//  Revive
//

import SwiftUI

struct BreathingTrainingView: View {

    @State private var currentIndex = 0

    // MARK: - Breathing steps
    private let breathingSteps: [TrainingStep] = [

        TrainingStep(
            title: "Open Airway",
            description: "Tilt the head back and lift the chin.",
            sceneName: nil,
            customView: nil
        ),

        TrainingStep(
            title: "Check for Normal Breathing",
            description: "Look, listen, and feel for breathing for up to 10 seconds.",
            sceneName: nil,
            customView: nil
        )
    ]

    // MARK: - BODY
    var body: some View {
        TrainingStepView(
            step: breathingSteps[currentIndex],

            // 🔴 NO IMMERSIVE MODE FOR BREATHING
            immersiveOpen: false,
            onToggleImmersive: {},

            onNext: advanceStep
        )
        .navigationTitle("Breathing Check")
        .navigationBarTitleDisplayMode(.inline)
    }

    // MARK: - Step advance
    private func advanceStep() {
        if currentIndex < breathingSteps.count - 1 {
            currentIndex += 1
        }
    }
}
