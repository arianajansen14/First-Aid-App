//
//  RecoveryTrainingView.swift
//  Revive
//

import SwiftUI

struct RecoveryTrainingView: View {

    @State private var currentIndex = 0

    private let recoverySteps: [TrainingStep] = [

        TrainingStep(
            title: "Check for Response",
            description: """
Speak loudly:
• “Can you hear me?”
• “Open your eyes.”

Check for ANY response:
• Movement
• Facial reaction
• Attempt to speak
• Any purposeful movement

If unresponsive BUT breathing → continue.
If NOT breathing → start CPR immediately.
""",
            sceneName: nil,
            customView: nil
        ),

        TrainingStep(
            title: "Open the Airway",
            description: """
Place one hand on the forehead.
Place two fingers under the chin. Tilt the head back.

Check for normal breathing up to 10 seconds.
""",
            sceneName: nil,
            customView: nil
        ),

        TrainingStep(
            title: "Position the Arm Closest to You",
            description: "Place the nearest arm at a right angle with the palm facing upward.",
            sceneName: nil,
            customView: nil
        ),

        TrainingStep(
            title: "Bring the Far Arm Across the Chest",
            description: "Place the far hand against their cheek and hold it there.",
            sceneName: nil,
            customView: nil
        ),

        TrainingStep(
            title: "Bend the Far Knee",
            description: "Lift and bend the far knee so the foot is flat on the floor.",
            sceneName: nil,
            customView: nil
        ),

        TrainingStep(
            title: "Roll Into Recovery Position",
            description: "Pull the bent knee and roll the person toward you onto their side.",
            sceneName: nil,
            customView: nil
        ),

        TrainingStep(
            title: "Monitor Until Help Arrives",
            description: "Stay with them and check breathing regularly.",
            sceneName: nil,
            customView: nil
        )
    ]

    var body: some View {
        TrainingStepView(step: recoverySteps[currentIndex], onNext: advanceStep)
            .navigationTitle("Recovery Position")
            .navigationBarTitleDisplayMode(.inline)
    }

    private func advanceStep() {
        if currentIndex < recoverySteps.count - 1 {
            currentIndex += 1
        }
    }
}
