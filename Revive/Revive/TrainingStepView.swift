//
//  TrainingStepView.swift
//  Revive
//

import SwiftUI

struct TrainingStepView: View {

    let step: TrainingStep
    let immersiveOpen: Bool
    let onToggleImmersive: () -> Void
    let onNext: () -> Void

    var body: some View {
        VStack(spacing: 30) {

            Text(step.title)
                .font(.largeTitle.bold())
                .multilineTextAlignment(.center)

            Text(step.description)
                .font(.title3)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal)

            Spacer()

            Button(immersiveOpen ? "Close Immersive Scene" : "Open Immersive Scene") {
                onToggleImmersive()
            }
            .buttonStyle(.borderedProminent)
            .controlSize(.large)

            Button("Next") {
                onNext()
            }
            .buttonStyle(.borderedProminent)
            .controlSize(.large)
        }
        .padding(40)
    }
}
