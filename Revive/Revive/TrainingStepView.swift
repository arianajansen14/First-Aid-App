//
//  TrainingStepView.swift
//  Revive
//

import SwiftUI

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

            // OPTIONAL RealityKit Scene
            if let sceneName = step.sceneName {
                TrainingSceneView(
                    sceneName: sceneName,
                    tintEnabled: true   // <--- FIXED
                )
                .frame(height: 400)
                .padding()
            }

            // OPTIONAL SwiftUI Custom View
            if let customView = step.customView {
                customView
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
