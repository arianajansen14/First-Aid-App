//
//  TrainingView.swift
//  try2
//
//  Created by ariana jansen on 28/11/2025.
//


import SwiftUI

struct TrainingView: View {

    @Environment(\.openImmersiveSpace) private var openImmersiveSpace
    @State private var showTrainingSelect = false

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            
            Text("Training")
                .font(.largeTitle)
                .bold()

            Text("AR Training")
                .font(.title3)
                .foregroundStyle(.secondary)

            Spacer().frame(height: 20)

            Button("Start Training") {
                showTrainingSelect = true
                Task {
                    _ = await openImmersiveSpace(id: "Immersive")
                }
            }
            .buttonStyle(.borderedProminent)

            if showTrainingSelect {
                VStack(alignment: .leading, spacing: 12) {
                    Text("Select Training Module")
                        .font(.headline)

                    Button("CPR") {
                        // placeholder for CPR action
                    }

                    Button("Burn Treatment") {
                        // placeholder for Burn action
                    }

                    Button("Recovery Position") {
                        // placeholder for Recovery action
                    }
                }
                .padding()
                .background(.ultraThinMaterial)
                .cornerRadius(12)
            }

            Spacer()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
    }
}
