//
//  AssessmentView.swift
//  try2
//

import SwiftUI

extension Notification.Name {
    static let startAssessmentImmersive = Notification.Name("startAssessmentImmersive")
}

struct AssessmentView: View {

    @Environment(\.openWindow) private var openWindow

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {

            Text("Assessment")
                .font(.largeTitle)
                .bold()

            Text("Interact with the 3D model inside a floating assessment window.")
                .font(.title3)
                .foregroundStyle(.secondary)

            Spacer().frame(height: 30)

            Button("Start Assessment") {
                // Close this 2D window and launch immersive assessment
                NotificationCenter.default.post(name: Notification.Name("startAssessmentImmersive"), object: nil)
            }
            .buttonStyle(.borderedProminent)

            Spacer()
        }
        .padding()
    }
}

#Preview {
    AssessmentView()
}
