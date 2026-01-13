import SwiftUI

// MARK: - DATA MODEL
struct AssessmentQuestion: Identifiable {
    let id = UUID()
    let question: String
    let answers: [String]       // MUST be 4 answers
    let correctIndex: Int       // 0–3
    let explanation: String
}

// MARK: - QUESTION VIEW
struct AssessmentQuestionView: View {

    let questions: [AssessmentQuestion]
    let moduleTitle: String

    @State private var index = 0
    @State private var selectedAnswer: Int? = nil
    @State private var showExplanation = false
    @State private var showResults = false
    @State private var score = 0

    @Environment(\.dismiss) private var dismiss

    // REQUIRED FOR SHOW MODEL BUTTON
    @Environment(AppModel.self) private var appModel
    @Environment(\.openWindow) private var openWindow

    var body: some View {
        if showResults {
            AssessmentResultView(
                score: score,
                totalCount: questions.count,
                moduleTitle: moduleTitle,
                onRetry: restartModule,
                onFinish: { dismiss() }
            )
        } else {
            questionPage
        }
    }

    // MARK: - MAIN QUESTION UI
    private var questionPage: some View {
        let current = questions[index]

        return VStack(spacing: 36) {

            // TITLE
            Text(current.question)
                .font(.largeTitle.bold())
                .multilineTextAlignment(.center)
                .padding(.horizontal)

            // ANSWERS GRID (2x2)
            answersGrid(for: current.answers)

            // EXPLANATION
            if showExplanation {
                Text(current.explanation)
                    .font(.body)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
            }

            Spacer()

            // SHOW MODEL BUTTON — NOW WORKS
            Button {
                openWindow(id: appModel.modelWindowID)   // ← OPENS WINDOW
            } label: {
                Text("Show Model")
                    .font(.headline)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 10)
            }
            .buttonStyle(.borderedProminent)

            // NEXT / FINISH BUTTON
            Button(action: nextQuestion) {
                Text(index == questions.count - 1 ? "Finish" : "Next")
                    .font(.title2.bold())
                    .padding(.horizontal, 30)
                    .padding(.vertical, 12)
            }
            .buttonStyle(.borderedProminent)
            .controlSize(.large)
            .disabled(selectedAnswer == nil)

        }
        .padding(50)
        .glassBackgroundEffect()
        .navigationTitle(moduleTitle)
        .navigationBarTitleDisplayMode(.inline)
    }

    // MARK: - 2×2 GRID
    private func answersGrid(for answers: [String]) -> some View {
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

    // MARK: - ANSWER BUTTON
    private func answerButton(index answerIndex: Int) -> some View {
        let current = questions[index]

        let isSelected = selectedAnswer == answerIndex
        let isCorrect = current.correctIndex == answerIndex
        let revealColours = selectedAnswer != nil

        return Button {
            handleAnswer(answerIndex)
        } label: {
            Text(current.answers[answerIndex])
                .font(.headline)
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 14)
                        .fill(
                            revealColours
                            ? (isCorrect ? Color.green.opacity(0.35)
                                          : (isSelected ? Color.red.opacity(0.35) : .clear))
                            : .clear
                        )
                )
                .background(
                    RoundedRectangle(cornerRadius: 14)
                        .fill(.ultraThinMaterial)
                )
        }
        .buttonStyle(.plain)
        .disabled(selectedAnswer != nil)
    }

    // MARK: - HANDLE ANSWER
    private func handleAnswer(_ answer: Int) {
        let current = questions[index]
        selectedAnswer = answer
        showExplanation = true

        if answer == current.correctIndex {
            score += 1
        }
    }

    // MARK: - NEXT QUESTION
    private func nextQuestion() {
        guard selectedAnswer != nil else { return }

        if index < questions.count - 1 {
            index += 1
            selectedAnswer = nil
            showExplanation = false
        } else {
            showResults = true
        }
    }

    // MARK: - RESTART
    private func restartModule() {
        index = 0
        selectedAnswer = nil
        showExplanation = false
        showResults = false
        score = 0
    }
}

#Preview {
    NavigationStack {
        AssessmentQuestionView(
            questions: [
                AssessmentQuestion(
                    question: "Example Q",
                    answers: ["A","B","C","D"],
                    correctIndex: 1,
                    explanation: "Explanation here."
                )
            ],
            moduleTitle: "Preview Module"
        )
    }
}
