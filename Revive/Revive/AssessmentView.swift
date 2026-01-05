//
//  AssessmentView.swift
//  Revive
//
//  Created by ariana jansen on 05/01/2026.
//


import SwiftUI

struct AssessmentView: View {
    @State private var startedAssessment = false

    var body: some View {
        VStack(alignment: .leading, spacing: 30) {

            Text("Assessment")
                .font(.largeTitle.bold())

            Text("Press Start Assessment to begin. You will answer questions related to CPR, burns, and the recovery position. Your score will appear at the end.")
                .font(.title3)
                .foregroundStyle(.secondary)
                .fixedSize(horizontal: false, vertical: true)

            Button(action: {
                startedAssessment = true
                // Later: load the assessment module selection window
            }) {
                Text("Start Assessment")
                    .font(.title2.bold())
                    .padding(.horizontal, 30)
                    .padding(.vertical, 12)
            }
            .buttonStyle(.borderedProminent)
            .controlSize(.large)

            if startedAssessment {
                assessmentPlaceholder
            }

            Spacer()
        }
        .padding(50)
        .glassBackgroundEffect()
    }

    // Temporary placeholder until we add swiping question pages
    private var assessmentPlaceholder: some View {
        VStack(alignment: .leading, spacing: 15) {
            Divider().padding(.vertical, 10)

            Text("Choose a topic to begin")
                .font(.title2.bold())

            Text("Once a topic is selected (CPR, burns, or recovery position), you will move through a series of questions.")
                .foregroundStyle(.secondary)
        }
        .padding(.top, 20)
    }
}

#Preview { AssessmentView() }
