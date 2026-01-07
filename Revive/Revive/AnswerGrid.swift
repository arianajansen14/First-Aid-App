import SwiftUI

struct AnswerGrid: View {

    let answers: [String]
    let selectedIndex: Int?
    let correctIndex: Int
    let onSelect: (Int) -> Void

    var body: some View {
        VStack(spacing: 20) {

            HStack(spacing: 20) {
                answerButton(index: 0)
                answerButton(index: 1)
            }

            HStack(spacing: 20) {
                answerButton(index: 2)
                answerButton(index: 3)
            }
        }
    }

    private func answerButton(index: Int) -> some View {

        let isSelected = selectedIndex == index
        let isCorrect = correctIndex == index

        return Button {
            onSelect(index)
        } label: {
            Text(answers[index])
                .font(.headline)
                .frame(maxWidth: .infinity)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(buttonColor(isSelected: isSelected, isCorrect: isCorrect))
                        .background(.ultraThinMaterial,
                                    in: RoundedRectangle(cornerRadius: 16))
                )
        }
        .buttonStyle(.plain)
        .disabled(selectedIndex != nil)
    }

    // MARK: - COLOR LOGIC
    private func buttonColor(isSelected: Bool, isCorrect: Bool) -> Color {
        if isSelected && isCorrect { return .green.opacity(0.5) }
        if isSelected && !isCorrect { return .red.opacity(0.5) }
        return .clear
    }
}
