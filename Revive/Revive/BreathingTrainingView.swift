//
//  BreathingTrainingView.swift
//  Revive
//

import SwiftUI

struct BreathingTrainingView: View {

    @State private var currentIndex = 0

    private let steps: [TrainingStep] = [

        TrainingStep(
            title: "Check Responsiveness",
            description: "Gently tap the shoulders and speak loudly: 'Can you hear me?' Look for any movement or reaction.",
            sceneName: nil,
            customView: AnyView(trainingIllustration("breathing_step1"))
        ),

        TrainingStep(
            title: "Open the Airway",
            description: "Tilt the head back by placing one hand on the forehead and two fingers under the chin. Lift gently to open the airway.",
            sceneName: nil,
            customView: AnyView(trainingIllustration("breathing_step2"))
        ),

        TrainingStep(
            title: "Look, Listen, and Feel",
            description: """
Look for normal chest rise.
Listen for breathing sounds near the mouth and nose.
Feel for breath on your cheek.
Do this for no more than 10 seconds.
""",
            sceneName: nil,
            customView: AnyView(trainingIllustration("breathing_step3"))
        ),

        TrainingStep(
            title: "Assess Breathing",
            description: """
If they are not breathing, gasping, or breathing abnormally,
this is NOT normal breathing.
Begin CPR immediately.
""",
            sceneName: nil,
            customView: nil
        ),

        TrainingStep(
            title: "If Breathing Normally",
            description: """
If the person IS breathing normally but unresponsive,
keep monitoring them and prepare for the Recovery Position.
""",
            sceneName: nil,
            customView: nil
        )
    ]

    var body: some View {

        TrainingStepView(
            step: steps[currentIndex],
            onNext: advanceStep
        )
        .navigationTitle("Breathing Assessment")
        .navigationBarTitleDisplayMode(.inline)
    }

    // MARK: - Step Logic
    private func advanceStep() {
        if currentIndex < steps.count - 1 {
            currentIndex += 1
        }
    }
}


/// Glass tile image helper
private func trainingIllustration(_ name: String) -> some View {
    Image(name)
        .resizable()
        .scaledToFit()
        .frame(maxHeight: 240)
        .padding(25)
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 22))
        .padding(.horizontal)
}
