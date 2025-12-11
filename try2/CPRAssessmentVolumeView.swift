//
//  AssessmentVolumeView.swift
//  try2
//
//  Created by ariana jansen on 28/11/2025.
//

import SwiftUI
import RealityKit
import RealityKitContent

//  AssessmentVolumeView.swift
//  try2
//
//  Created by ariana jansen on 28/11/2025.
//

import SwiftUI
import RealityKit
import RealityKitContent

// MARK: - Exam model

struct ExamQuestion {
    let prompt: String
    let options: [String]
    let correctIndex: Int
    let explanation: String
}

// A CPR-only exam covering both CPR sequence (danger, response, breathing, call help)
// and CPR technique (rate, depth, hand placement, stopping criteria).
let professionalExamQuestions: [ExamQuestion] = [
    ExamQuestion(
        prompt: "You find an adult collapsed on the floor and they are not responding. What is the FIRST thing you should do?",
        options: [
            "Check for danger around you and them",
            "Start chest compressions",
            "Put them in the recovery position",
            "Give them a drink of water"
        ],
        correctIndex: 0,
        explanation: "Your safety comes first. Quickly check for danger before approaching the casualty."
    ),
    ExamQuestion(
        prompt: "The area is safe and the person is unresponsive. What should you do NEXT?",
        options: [
            "Shout for help and check for normal breathing",
            "Immediately roll them onto their side",
            "Move them to a chair",
            "Leave them to see if they wake up"
        ],
        correctIndex: 0,
        explanation: "You should shout for help and check whether they are breathing normally."
    ),
    ExamQuestion(
        prompt: "You open the airway and look, listen and feel for breathing. You cannot see or feel normal breathing. What should you do now?",
        options: [
            "Call emergency services and start CPR",
            "Put them in the recovery position",
            "Give them sips of water",
            "Try to sit them up"
        ],
        correctIndex: 0,
        explanation: "If they are not breathing normally, you must call emergency services and begin CPR."
    ),
    ExamQuestion(
        prompt: "Where should you place your hands for adult chest compressions?",
        options: [
            "Centre of the chest, on the lower half of the breastbone",
            "On the left side of the chest over the heart",
            "On the upper chest near the collarbone",
            "On the stomach, above the belly button"
        ],
        correctIndex: 0,
        explanation: "Hands go in the centre of the chest on the lower half of the breastbone."
    ),
    ExamQuestion(
        prompt: "How deep should adult chest compressions be?",
        options: [
            "About 5–6 cm",
            "About 1 cm",
            "As shallow as possible",
            "More than 10 cm"
        ],
        correctIndex: 0,
        explanation: "Adult chest compressions should be around 5–6 cm deep."
    ),
    ExamQuestion(
        prompt: "What is the correct rate of chest compressions for an adult?",
        options: [
            "About 100–120 compressions per minute",
            "About 40–50 compressions per minute",
            "About 200 compressions per minute",
            "As slow as feels comfortable"
        ],
        correctIndex: 0,
        explanation: "The recommended rate is about 100–120 compressions per minute."
    ),
    ExamQuestion(
        prompt: "During CPR, when should you stop compressions?",
        options: [
            "When the person shows clear signs of life or a professional tells you to stop",
            "After exactly one minute",
            "When you feel tired, even if alone",
            "As soon as you have called for help"
        ],
        correctIndex: 0,
        explanation: "You continue until the person shows signs of life, you are replaced, it is unsafe, or you are physically unable to continue."
    ),
    ExamQuestion(
        prompt: "Why is tilting the head back and lifting the chin important before checking breathing?",
        options: [
            "It helps open the airway by lifting the tongue away from the back of the throat",
            "It warms them up",
            "It stops them moving",
            "It has no real purpose"
        ],
        correctIndex: 0,
        explanation: "Head tilt and chin lift helps open the airway so you can check breathing properly before beginning CPR."
    )
]

struct CPRAssessmentVolumeView: View {

    // 3D model state
    @State private var manEntity: Entity?

    // Exam state
    @State private var examStarted: Bool = false
    @State private var currentQuestionIndex: Int = 0
    @State private var selectedOptionIndex: Int? = nil
    @State private var isAnswered: Bool = false
    @State private var isCorrect: Bool? = nil
    @State private var score: Int = 0
    @State private var finished: Bool = false

    private var questions: [ExamQuestion] { professionalExamQuestions }

    var body: some View {
        ZStack {
            Color.black.opacity(0.15)
                .ignoresSafeArea()

            if finished {
                summaryCard
                    .frame(maxWidth: 800, maxHeight: 420)
                    .glassBackgroundEffect()
                    .clipShape(RoundedRectangle(cornerRadius: 32, style: .continuous))
                    .shadow(radius: 20)
                    .padding()
            } else {
                mainCard
                    .frame(maxWidth: 900, maxHeight: 520)
                    .glassBackgroundEffect()
                    .clipShape(RoundedRectangle(cornerRadius: 32, style: .continuous))
                    .shadow(radius: 20)
                    .padding()
            }
        }
        // Load the 3D model once, in a safe async context
        .task {
            if manEntity == nil {
                do {
                    manEntity = try await Entity(named: "man", in: realityKitContentBundle)
                } catch {
                    print("Failed to load man.usda for assessment: \(error)")
                }
            }
        }
        // Start / restart exam when we are told to open the assessment volume
        .onReceive(NotificationCenter.default.publisher(for: .openAssessmentVolume)) { _ in
            startExam()
        }
    }

    // MARK: - Main exam card

    private var mainCard: some View {
        VStack(alignment: .leading, spacing: 20) {

            header

            Divider()

            HStack(spacing: 24) {
                modelPreview
                questionArea
            }
        }
        .padding(24)
    }

    private var header: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text("Assessment")
                    .font(.largeTitle.bold())

                Text("Professional first aid check")
                    .font(.headline)
                    .foregroundStyle(.secondary)

                Text("Question \(currentQuestionIndex + 1) of \(questions.count)")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }

            Spacer()

            if examStarted {
                let progress = Double(currentQuestionIndex + 1) / Double(questions.count)
                VStack(alignment: .trailing, spacing: 6) {
                    Text("Progress")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    ProgressView(value: progress)
                        .frame(width: 160)
                }
            }
        }
    }

    private var modelPreview: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("3D reference")
                .font(.headline)

            ZStack {
                RoundedRectangle(cornerRadius: 24, style: .continuous)
                    .strokeBorder(.white.opacity(0.2), lineWidth: 1)
                    .background(
                        RoundedRectangle(cornerRadius: 24, style: .continuous)
                            .fill(Color.white.opacity(0.03))
                    )

                RealityView { content in
                    if let man = manEntity, man.parent == nil {
                        content.add(man)
                    }
                }
                .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
            }
            .frame(width: 260, height: 260)

            Text("Use the mannequin as a visual reminder of body position and actions.")
                .font(.footnote)
                .foregroundStyle(.secondary)
        }
    }

    private var questionArea: some View {
        let question = questions[currentQuestionIndex]

        return VStack(alignment: .leading, spacing: 16) {
            Text(question.prompt)
                .font(.title3.bold())
                .fixedSize(horizontal: false, vertical: true)

            VStack(spacing: 10) {
                ForEach(question.options.indices, id: \.self) { index in
                    optionButton(text: question.options[index], index: index, correctIndex: question.correctIndex)
                }
            }

            if isAnswered {
                if let correct = isCorrect {
                    Text(correct ? "Correct" : "Not quite")
                        .font(.headline)
                        .foregroundStyle(correct ? .green : .red)

                    Text(question.explanation)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
            } else {
                Text("Choose the best answer. You can only answer once per question.")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }

            Spacer()

            HStack {
                Button {
                    restartCurrentQuestion()
                } label: {
                    Label("Clear selection", systemImage: "arrow.uturn.backward")
                }
                .buttonStyle(.bordered)
                .disabled(!examStarted || selectedOptionIndex == nil || isAnswered)

                Spacer()

                Button {
                    advance()
                } label: {
                    Text(isLastQuestion ? "Finish assessment" : "Next question")
                }
                .buttonStyle(.borderedProminent)
                .disabled(!isAnswered)
            }
        }
    }

    // MARK: - Summary card

    private var summaryCard: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Assessment complete")
                .font(.largeTitle.bold())

            Text("You answered \(score) out of \(questions.count) correctly.")
                .font(.title3)

            let percentage = Int(Double(score) / Double(questions.count) * 100)
            Text("Score: \(percentage)%")
                .font(.headline)

            if percentage >= 70 {
                Text("Nice work. This would be a passing score in many basic first aid trainings.")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            } else {
                Text("You might want to repeat the training sections and try the assessment again.")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }

            Spacer()

            HStack {
                Button {
                    startExam()
                } label: {
                    Label("Retake assessment", systemImage: "gobackward")
                }
                .buttonStyle(.bordered)

                Spacer()

                Button {
                    // Close behaviour: app can listen for this and reopen main menu window.
                    NotificationCenter.default.post(name: .openMainMenu, object: nil)
                } label: {
                    Label("Close & return to menu", systemImage: "xmark.circle")
                }
                .buttonStyle(.borderedProminent)
            }
        }
        .padding(24)
    }

    // MARK: - Option button

    private func optionButton(text: String, index: Int, correctIndex: Int) -> some View {
        let isSelected = index == selectedOptionIndex

        let background: Color
        let border: Color

        if isAnswered {
            if index == correctIndex {
                background = Color.green.opacity(0.25)
                border = Color.green.opacity(0.6)
            } else if isSelected {
                background = Color.red.opacity(0.25)
                border = Color.red.opacity(0.6)
            } else {
                background = Color.white.opacity(0.05)
                border = Color.white.opacity(0.15)
            }
        } else {
            background = isSelected ? Color.white.opacity(0.12) : Color.white.opacity(0.05)
            border = isSelected ? Color.white.opacity(0.4) : Color.white.opacity(0.15)
        }

        return Button {
            handleSelection(index: index, correctIndex: correctIndex)
        } label: {
            HStack {
                Text(text)
                    .font(.body)
                Spacer()
            }
            .padding(.horizontal, 14)
            .padding(.vertical, 10)
        }
        .buttonStyle(.plain)
        .background(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .fill(background)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .stroke(border, lineWidth: 1)
        )
        .disabled(!examStarted || isAnswered)
    }

    // MARK: - Logic

    private var isLastQuestion: Bool {
        currentQuestionIndex == questions.count - 1
    }

    private func startExam() {
        examStarted = true
        finished = false
        score = 0
        currentQuestionIndex = 0
        selectedOptionIndex = nil
        isAnswered = false
        isCorrect = nil
    }

    private func handleSelection(index: Int, correctIndex: Int) {
        guard examStarted, !isAnswered else { return }
        selectedOptionIndex = index
        isAnswered = true
        let correct = (index == correctIndex)
        isCorrect = correct
        if correct {
            score += 1
        }
    }

    private func restartCurrentQuestion() {
        guard examStarted else { return }
        selectedOptionIndex = nil
        isAnswered = false
        isCorrect = nil
    }

    private func advance() {
        guard examStarted, isAnswered else { return }

        if isLastQuestion {
            finished = true
            examStarted = false
        } else {
            currentQuestionIndex += 1
            selectedOptionIndex = nil
            isAnswered = false
            isCorrect = nil
        }
    }
}

#Preview {
    CPRAssessmentVolumeView()
}

