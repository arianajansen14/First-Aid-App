//
//  AssessmentModelFallbackView.swift
//  Revive
//
//  Created by ariana jansen on 10/01/2026.
//


//
//  AssessmentModelFallbackView.swift
//  Revive
//

import SwiftUI

struct AssessmentModelFallbackView: View {
    @Environment(AppModel.self) private var appModel

    var body: some View {
        VStack(spacing: 20) {

            Text("Model Preview (Simulator)")
                .font(.title.bold())

            Text("Volumetric windows are not supported in the simulator.")
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)

            RoundedRectangle(cornerRadius: 20)
                .fill(Color.gray.opacity(0.15))
                .frame(width: 300, height: 300)
                .overlay(
                    Text("3D Model\nUnavailable\nIn Simulator")
                        .multilineTextAlignment(.center)
                        .foregroundColor(.secondary)
                )

            Spacer()

            Button("Close Window") {
                appModel.isModelVisible = false
            }
            .buttonStyle(.borderedProminent)
        }
        .padding(40)
    }
}