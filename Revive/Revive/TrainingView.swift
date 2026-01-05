//
//  TrainingView.swift
//  Revive
//
//  Created by ariana jansen on 05/01/2026.
//


import SwiftUI

struct TrainingView: View {
    @State private var startedTraining = false   // we check if the user tapped Start
    
    var body: some View {
        VStack(alignment: .leading, spacing: 30) {
            
            Text("Training")
                .font(.largeTitle.bold())
            
            Text("Press Start Training to load the training environment. You will select what you want to learn by tapping parts of the model.")
                .font(.title3)
                .foregroundStyle(.secondary)
                .fixedSize(horizontal: false, vertical: true)
            
            Button(action: {
                startedTraining = true
                // Later: open immersive selector window here
            }) {
                Text("Start Training")
                    .font(.title2.bold())
                    .padding(.horizontal, 30)
                    .padding(.vertical, 12)
            }
            .buttonStyle(.borderedProminent)
            .controlSize(.large)
            
            if startedTraining {
                trainingPlaceholder
            }
            
            Spacer()
        }
        .padding(50)
        .glassBackgroundEffect()
    }
    
    // Temporary placeholder until we build AR selection
    private var trainingPlaceholder: some View {
        VStack(alignment: .leading, spacing: 15) {
            Divider().padding(.vertical, 10)
            
            Text("Training will begin soon")
                .font(.title2.bold())
            
            Text("After selecting a body part on the model (CPR, Airway, or Recovery Position), your instructions will appear here.")
                .foregroundStyle(.secondary)
        }
        .padding(.top, 20)
    }
}

#Preview { TrainingView() }
