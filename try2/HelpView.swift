//
//  HelpView.swift
//  try2
//
//  Created by ariana jansen on 28/11/2025.
//

import SwiftUI
import AVKit

struct HelpView: View {

    @Environment(\.openWindow) private var openWindow
    @Environment(\.dismissWindow) private var dismissWindow

    @State private var showTutorial = false

    var body: some View {
        VStack(spacing: 32) {

            Text("Help & Tutorials")
                .font(.largeTitle)
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading)

            Text("Watch a short guide on how to use the app.")
                .foregroundStyle(.secondary)
                .frame(maxWidth: .infinity, alignment: .leading)

            Button {
                // Close the help window
                dismissWindow(id: "help")

                // Open tutorial window
                openWindow(id: "tutorialWindow")

            } label: {
                Label("Play Tutorial", systemImage: "play.circle.fill")
                    .font(.title2)
                    .padding(.vertical, 12)
                    .padding(.horizontal, 20)
                    .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 20))
                    .shadow(radius: 3)
            }

            Spacer()
        }
        .padding(40)
    }
}

struct TutorialVideoWindow: View {

    @Environment(\.openWindow) private var openWindow
    @Environment(\.dismissWindow) private var dismissWindow

    private var player: AVPlayer {
        let url = Bundle.main.url(forResource: "tutorial", withExtension: "mp4")!
        return AVPlayer(url: url)
    }

    var body: some View {
        ZStack {

            // Darken background slightly behind video window
            Color.black.opacity(0.35)
                .ignoresSafeArea()

            RoundedRectangle(cornerRadius: 32)
                .fill(.ultraThinMaterial)
                .shadow(radius: 10)

            VStack(spacing: 20) {

                // NOW PLAYING BAR
                HStack {
                    Image(systemName: "play.circle.fill")
                    Text("Now Playing: Tutorial")
                        .font(.headline)
                }
                .padding(.top, 16)

                VideoPlayer(player: player)
                    .frame(height: 420)
                    .clipShape(RoundedRectangle(cornerRadius: 24))

                Button("Close") {
                    // Close tutorial window
                    dismissWindow(id: "tutorialWindow")

                    // Reopen help window
                    openWindow(id: "help")
                }
                .font(.title3)
                .padding(.vertical, 10)
                .padding(.horizontal, 20)
                .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 20))
            }
            .padding()
        }
        .padding()
    }
}
