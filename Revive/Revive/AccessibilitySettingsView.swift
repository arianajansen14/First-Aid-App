//
//  AccessibilitySettingsView.swift
//

import SwiftUI

struct AccessibilitySettingsView: View {

    @State private var reduceMotion = false
    @State private var highContrast = false
    @State private var simplifiedTraining = false

    var body: some View {
        VStack(alignment: .leading, spacing: 30) {

            Text("Accessibility")
                .font(.largeTitle.bold())

            Divider()

            // ============================================================
            // APP ACCESSIBILITY OPTIONS
            // ============================================================
            VStack(alignment: .leading, spacing: 24) {

                // -------------------------
                // REDUCE MOTION
                // -------------------------
                Toggle("Reduce Motion (in-app)", isOn: $reduceMotion)

                if reduceMotion {
                    VStack(alignment: .leading, spacing: 8) {

                        Text("Reduced Motion Enabled")
                            .font(.headline)
                            .foregroundColor(.primary)

                        Text("""
                The model becomes stationary inside a small volume window you can rotate and zoom.

                • No walking or physical positioning required  
                • Hover highlights and movement-based actions disabled  
                • All training steps remain available  
                • Designed for comfort and low-motion accessibility
                """)
                            .font(.caption)
                            .foregroundColor(.secondary)
                            .fixedSize(horizontal: false, vertical: true)

                    }
                    .padding(12)
                    .background(
                        RoundedRectangle(cornerRadius: 14)
                            .fill(.thinMaterial)
                    )
                    .padding(.leading, 4)
                    .transition(.opacity)
                }
                // -------------------------
                // HIGH CONTRAST MODE
                // -------------------------
                Toggle("High Contrast UI", isOn: $highContrast)

                // -------------------------
                // SIMPLIFIED TRAINING
                // -------------------------
                Toggle("Simplified Training Mode", isOn: $simplifiedTraining)

            }

            Divider().padding(.vertical, 10)

            // ============================================================
            // PREVIEW TEXT BLOCK
            // ============================================================
            VStack(alignment: .leading, spacing: 12) {

                Text("Preview")
                    .font(.headline)

                Text("""
This is how your interface text will appear with your current accessibility settings applied.
""")
                .font(.body)
                .foregroundColor(.primary)

                RoundedRectangle(cornerRadius: 12)
                    .fill(.thinMaterial)
                    .frame(height: 100)
                    .overlay(
                        Text(previewText)
                            .font(highContrast ? .headline : .body)
                            .foregroundColor(highContrast ? .white : .primary)
                            .padding()
                    )
            }

            Spacer()
        }
        .padding(40)
        .glassBackgroundEffect()
    }

    // MARK: - Preview Text Logic
    private var previewText: String {
        if reduceMotion {
            return "Training will be stationary with reduced animations."
        } else if highContrast {
            return "High contrast mode increases UI clarity."
        } else if simplifiedTraining {
            return "Training steps will be shown in simplified mode."
        } else {
            return "Standard text preview."
        }
    }
}

#Preview {
    AccessibilitySettingsView()
}
