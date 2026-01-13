//
//  TrainingStepView.swift
//  Revive
//

import SwiftUI

struct TrainingStepView: View {

    let step: TrainingStep
    let onNext: () -> Void

    var body: some View {
        ScrollView {     // ← Prevents stretching on tall visionOS windows
            VStack(spacing: 30) {

                // TITLE
                Text(step.title)
                    .font(.largeTitle.bold())
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: 600)   // ← Keeps it centered and narrow

                // DESCRIPTION
                Text(step.description)
                    .font(.title3)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: 600)   // ← Prevents long text from stretching
                    .padding(.horizontal)

                // 3D SCENE (Optional)
                let sceneToLoad = step.sceneName ?? "TrainingScene"

                TrainingSceneView(
                    sceneName: sceneToLoad,
                    tintEnabled: sceneToLoad == "TrainingScene"
                )
                .frame(width: 500, height: 350)   // ← FIXED SIZE so it doesn’t overshoot
                .glassBackgroundEffect()          // ← Makes it look like a nice tile
                .clipShape(RoundedRectangle(cornerRadius: 25))
                .padding(.top, 10)

                // CUSTOM ILLUSTRATION (Optional)
                if let customView = step.customView {
                    customView
                        .frame(maxWidth: 500)     // keeps images centered
                }

                // NEXT BUTTON
                Button(action: onNext) {
                    Text("Next")
                        .font(.title2.bold())
                        .padding(.horizontal, 40)
                        .padding(.vertical, 12)
                }
                .buttonStyle(.borderedProminent)
                .controlSize(.large)
                .padding(.top, 20)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 40)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
