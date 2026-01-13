import SwiftUI

// MARK: - DATA MODEL

struct TrainingStep: Identifiable {
    let id = UUID()
    let title: String
    let description: String
    let customView: AnyView?
}

// MARK: - TRAINING STEP VIEW (Swipe + Prev/Next + Finish)

struct TrainingStepView: View {

    let steps: [TrainingStep]

    @Environment(\.dismiss) private var dismiss
    @State private var currentIndex = 0
    @GestureState private var dragOffset: CGFloat = 0

    var body: some View {
        VStack(spacing: 30) {

            // TITLE
            Text(steps[currentIndex].title)
                .font(.largeTitle.bold())
                .multilineTextAlignment(.center)

            // DESCRIPTION
            Text(steps[currentIndex].description)
                .font(.title3)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 20)

            // OPTIONAL CUSTOM VIEW (for animation tiles later)
            if let custom = steps[currentIndex].customView {
                custom
                    .frame(maxWidth: .infinity, maxHeight: 250)
                    .padding(.vertical, 20)
            }

            Spacer()

            // PAGE DOTS
            HStack(spacing: 8) {
                ForEach(0..<steps.count, id: \.self) { idx in
                    Circle()
                        .frame(width: 10, height: 10)
                        .foregroundColor(idx == currentIndex ? .primary : .gray.opacity(0.3))
                }
            }

            // PREV / NEXT BUTTONS
            HStack(spacing: 20) {

                // PREVIOUS
                Button(action: goBack) {
                    Text("Previous")
                        .padding(.horizontal, 20)
                        .padding(.vertical, 12)
                }
                .buttonStyle(.bordered)
                .disabled(currentIndex == 0)

                Spacer()

                // NEXT OR FINISH
                Button(action: goForward) {
                    Text(currentIndex == steps.count - 1 ? "Finish" : "Next")
                        .font(.title2.bold())
                        .padding(.horizontal, 30)
                        .padding(.vertical, 12)
                }
                .buttonStyle(.borderedProminent)
            }
        }
        .padding(40)
        .glassBackgroundEffect()
        .gesture(dragGesture)
    }

    // MARK: - Logic

    private var dragGesture: some Gesture {
        DragGesture()
            .updating($dragOffset) { value, state, _ in
                state = value.translation.width
            }
            .onEnded { value in
                if value.translation.width < -80 { goForward() }
                if value.translation.width > 80 { goBack() }
            }
    }

    private func goForward() {
        if currentIndex < steps.count - 1 {
            currentIndex += 1
        } else {
            dismiss() // FINISH returns to Training page
        }
    }

    private func goBack() {
        if currentIndex > 0 {
            currentIndex -= 1
        }
    }
}
