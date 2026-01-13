//
//  CPRTrainingView.swift
//  Revive
//

import SwiftUI

struct CPRTrainingView: View {

    @State private var currentIndex = 0

    private let cprSteps: [TrainingStep] = [

        TrainingStep(
            title: "Locate the Casualty",
            description: "Look around the area and find the person who needs help. Make sure the location is safe for you before approaching.",
            sceneName: nil,
            customView: nil
        ),

        TrainingStep(
            title: "Check Responsiveness",
            description: "Kneel beside the person. Tap their shoulders firmly and speak loudly: 'Can you hear me?' Look for any movement or reaction.",
            sceneName: nil,
            customView: nil
        ),

        TrainingStep(
            title: "Assess Breathing",
            description: "Look at the chest to see if it rises and falls. Listen for normal breathing. If the person is not breathing or breathing abnormally (gasping), begin CPR immediately.",
            sceneName: "TrainingScene",
            customView: nil
        ),

        TrainingStep(
            title: "Call Emergency Services",
            description: "Call 999, or ask someone nearby to call. Put the phone on speaker so you can keep your hands free.",
            sceneName: nil,
            customView: nil
        ),

        TrainingStep(
            title: "Hand Positioning",
            description: "Place the heel of your hand in the centre of the chest. Put your other hand on top and interlock your fingers. Keep your arms straight.",
            sceneName: "cprhands",
            customView: nil
        ),

        TrainingStep(
            title: "Compression Depth & Rhythm",
            description: "Push hard and fast — 5–6 cm deep at a rate of 100–120 compressions per minute.",
            sceneName: "cprhelp",
            customView: nil
        )
    ]

    var body: some View {
        TrainingStepView(step: cprSteps[currentIndex], onNext: advanceStep)
            .navigationTitle("CPR Training")
            .navigationBarTitleDisplayMode(.inline)
    }

    private func advanceStep() {
        if currentIndex < cprSteps.count - 1 {
            currentIndex += 1
        }
    }
}
