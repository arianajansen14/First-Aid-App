//
//  LandingPageView.swift
//  Revive
//
//  Created by ariana jansen on 06/01/2026.
//


import SwiftUI

struct LandingPageView: View {

    @Binding var hasEnteredApp: Bool

    var body: some View {
        VStack(alignment: .center, spacing: 30) {

            Spacer()

            // LOGO
            RoundedRectangle(cornerRadius: 26)
                .fill(.thinMaterial)
                .frame(width: 140, height: 140)
                .overlay(
                    Text("🩺")
                        .font(.system(size: 70))
                )

            // TEXT BLOCK
            VStack(spacing: 8) {
                Text("Revive")
                    .font(.system(size: 48, weight: .bold))

                Text("Interactive First-Aid Training App")
                    .font(.title3)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
            }

            Spacer()

            // CONTINUE BUTTON
            Button {
                withAnimation(.easeInOut(duration: 0.4)) {
                    hasEnteredApp = true
                }
            } label: {
                Text("Continue")
                    .font(.title2.bold())
                    .padding(.horizontal, 50)
                    .padding(.vertical, 16)
            }
            .buttonStyle(.borderedProminent)
            .controlSize(.large)

            Spacer(minLength: 60)
        }
        .padding(.horizontal, 60)
        .padding(.top, 80)
        .navigationBarHidden(true)    // ← ensures full tile look
    }
}
