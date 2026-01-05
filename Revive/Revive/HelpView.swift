//
//  HelpView.swift
//  Revive
//
//  Created by ariana jansen on 05/01/2026.
//


import SwiftUI

struct HelpView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {

            Text("Help")
                .font(.largeTitle.bold())

            Text("Watch the tutorial or read instructions to learn how to use Revive.")
                .font(.title3)
                .foregroundStyle(.secondary)

            Button("Play Tutorial") {}
                .buttonStyle(.borderedProminent)
                .controlSize(.large)
                .padding(.top, 20)

            Spacer()
        }
        .padding(50)
        .glassBackgroundEffect()
    }
}

#Preview { HelpView() }
