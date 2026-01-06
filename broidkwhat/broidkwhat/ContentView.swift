//
//  ContentView.swift
//  broidkwhat
//
//  Created by Da jia Ly on 16/12/2025.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct ContentView: View {
    @State private var colors: [Color] = [.red, .orange, .yellow, .green, .blue]
    @State private var selectedIndex: Int = 0

    var body: some View {
        HStack(spacing: 0) {

            // LEFT SIDE – controls
            VStack(alignment: .leading, spacing: 20) {
                Text("Create your own Genni")
                    .font(.system(size: 30))
                    .bold()

                Text("Pick your colours")
                    .font(.headline)

                // 5 ColorPickers (edit the palette)
                HStack(spacing: 12) {
                    ForEach(colors.indices, id: \.self) { i in
                        ColorPicker("", selection: $colors[i])
                            .labelsHidden()
                    }
                }

                Text("Choose one to apply")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)

                // 5 Swatches (tap to apply)
                HStack(spacing: 12) {
                    ForEach(colors.indices, id: \.self) { i in
                        RoundedRectangle(cornerRadius: 10)
                            .fill(colors[i])
                            .frame(width: 40, height: 40)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(.white, lineWidth: selectedIndex == i ? 3 : 0)
                            )
                            .onTapGesture {
                                selectedIndex = i
                            }
                    }
                }

                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .padding(30)
            .background(.thickMaterial)

            // RIGHT SIDE – preview
            VStack {
                Spacer()

                RoundedRectangle(cornerRadius: 24)
                    .fill(colors[selectedIndex]) // ✅ rectangle updates to chosen swatch
                    .frame(width: 250, height: 350)

                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding(30)
            .background(.ultraThinMaterial)
            .overlay(Color.black.opacity(0.25))
        }
    }
}

