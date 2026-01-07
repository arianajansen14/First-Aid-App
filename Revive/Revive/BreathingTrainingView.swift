//
//  BreathingTrainingView.swift
//  Revive
//

import SwiftUI

struct BreathingTrainingView: View {

    private let breathingSteps: [TrainingStep] = [

        TrainingStep(
            title: "Check Responsiveness",
            description: "Gently tap the shoulders and speak loudly: 'Can you hear me?' Look for any movement or reaction.",
            customView:
                AnyView(
                    trainingIllustration("breathing_step1")
                )
        ),

        TrainingStep(
            title: "Open the Airway",
            description: "Tilt the head back by placing one hand on the forehead and two fingers under the chin. Lift gently to open the airway.",
            customView:
                AnyView(
                    trainingIllustration("breathing_step2")
                )
        ),

        TrainingStep(
            title: "Look, Listen, and Feel",
            description: """
Look for normal chest rise.
Listen for breathing sounds near the mouth and nose.
Feel for breath on your cheek.
Do this for no more than 10 seconds.
""",
            customView:
                AnyView(
                    trainingIllustration("breathing_step3")
                )
        ),

        TrainingStep(
            title: "Assess Breathing",
            description: """
If they are not breathing, gasping, or breathing abnormally,
this is NOT normal breathing.
Begin CPR immediately.
""",
            customView: nil
        ),

        TrainingStep(
            title: "If Breathing Normally",
            description: """
If the person IS breathing normally but unresponsive,
keep monitoring them and prepare for the Recovery Position.
""",
            customView: nil
        )
    ]

    var body: some View {
        TrainingStepView(steps: breathingSteps)
            .navigationTitle("Breathing Assessment")
            .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        BreathingTrainingView()
    }
}

/// Glass-tile illustration helper
private func trainingIllustration(_ name: String) -> some View {
    Image(name)
        .resizable()
        .scaledToFit()
        .frame(maxHeight: 240)
        .padding(25)
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 22))
        .padding(.horizontal)
}
