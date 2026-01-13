//
//  TrainingStepView.swift
//  Revive
//

import SwiftUI
import RealityKit
import RealityKitContent

// TRAINING STEP MODEL
struct TrainingStep: Identifiable {
    let id = UUID()
    let title: String
    let description: String
    let sceneName: String?
    let tintEnabled: Bool = true   // If you want tint by default
}

// MAIN TRAINING STEP VIEW
struct TrainingStepView: View {

    let step: TrainingStep
    let onNext: () -> Void

    var body: some View {
        VStack(spacing: 40) {

            // TITLE
            Text(step.title)
                .font(.largeTitle.bold())
                .multilineTextAlignment(.center)

            // DESCRIPTION
            Text(step.description)
                .font(.title3)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal)

            // SCENE DISPLAY
            if let sceneName = step.sceneName {
                TrainingSceneView(sceneName: sceneName,
                                  tintEnabled: step.tintEnabled)
                    .frame(height: 400)
                    .padding()
            }

            Spacer()

            // NEXT BUTTON
            Button("Next") {
                onNext()
            }
            .buttonStyle(.borderedProminent)
            .controlSize(.large)
        }
        .padding(40)
    }
}
