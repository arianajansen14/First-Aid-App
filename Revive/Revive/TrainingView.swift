import SwiftUI

struct TrainingView: View {
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 30) {

                // TITLE
                Text("Training")
                    .font(.largeTitle.bold())

                // DESCRIPTION
                Text("""
Choose a training module to begin.
Each module provides step-by-step guidance for essential first-aid procedures.
""")
                .font(.title3)
                .foregroundStyle(.secondary)

                Divider().padding(.vertical, 10)

                // MODULE BUTTONS
                VStack(spacing: 20) {

                    NavigationLink {
                        CPRTrainingView()
                    } label: {
                        trainingButtonRow(
                            title: "CPR Training",
                            subtitle: "Learn life-saving compressions",
                            icon: "waveform.path.ecg"
                        )
                    }

                    NavigationLink {
                        BreathingTrainingView()
                    } label: {
                        trainingButtonRow(
                            title: "Breathing Assessment",
                            subtitle: "Check responsiveness and breathing",
                            icon: "lungs.fill"
                        )
                    }

                    NavigationLink {
                        RecoveryTrainingView()
                    } label: {
                        trainingButtonRow(
                            title: "Recovery Position",
                            subtitle: "Safely position a breathing person",
                            icon: "figure.stand"
                        )
                    }
                }

                Spacer()
            }
            //  THESE LINES make it FULL SCREEN in visionOS
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .padding(50)
            .glassBackgroundEffect()  // same style as Settings
        }
    }

    // MARK: - Button Row
    private func trainingButtonRow(title: String,
                                   subtitle: String,
                                   icon: String) -> some View {

        HStack(spacing: 16) {
            Image(systemName: icon)
                .font(.title)
                .foregroundColor(.white)

            VStack(alignment: .leading, spacing: 4) {
                Text(title).font(.headline)
                Text(subtitle)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }

            Spacer()

            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
        }
        .padding(20)
        .frame(maxWidth: .infinity)   // ← makes button fill horizontally
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}

#Preview {
    TrainingView()
}
