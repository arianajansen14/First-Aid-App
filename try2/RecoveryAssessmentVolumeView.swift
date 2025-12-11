//
//  RecoveryAssessmentVolumeView.swift
//  try2
//
//  Created by ariana jansen on 04/12/2025.
//

import SwiftUI
import RealityKit
import RealityKitContent

// MARK: - Model for Recovery Exam Questions
struct RecoveryExamQuestion {
    let prompt: String
    let options: [String]
    let correctIndex: Int
    let explanation: String
}

// MARK: - Recovery Assessment View (Professional Level)
struct RecoveryAssessmentVolumeView: View {

    // MARK: - State
    @State private var manEntity: Entity?
    @State private var selectedIndex: Int? = nil
    @State private var questionIndex: Int = 0
    @State private var examCompleted: Bool = false
    @State private var score: Int = 0

    // MARK: - Professional Recovery Exam Questions
    let professionalRecoveryQuestions: [RecoveryExamQuestion] = [

        RecoveryExamQuestion(
            prompt: "When should you place a casualty into the recovery position?",
            options: [
                "When they are unresponsive but breathing normally",
                "When they are fully conscious",
                "Only after CPR has been performed",
                "Whenever their legs are injured"
            ],
            correctIndex: 0,
            explanation: "The recovery position is used when someone is unresponsive but breathing normally and has no suspected spinal injuries."
        ),

        RecoveryExamQuestion(
            prompt: "What is the FIRST step in placing someone in the recovery position?",
            options: [
                "Remove glasses and kneel beside them",
                "Roll them onto their side immediately",
                "Lift their legs straight up",
                "Give two rescue breaths"
            ],
            correctIndex: 0,
            explanation: "The first step is to ensure safety, check breathing, remove glasses, and kneel beside them to prepare for rolling."
        ),

        RecoveryExamQuestion(
            prompt: "Which leg do you lift when preparing to roll the casualty?",
            options: [
                "The leg that is furthest from you",
                "Both legs together",
                "The leg closest to you, at a right angle",
                "Neither, legs should remain straight"
            ],
            correctIndex: 2,
            explanation: "You lift the leg closest to you, bending it at a right angle to help stabilise the casualty when rolled."
        ),

        RecoveryExamQuestion(
            prompt: "What should you do with the casualty’s arm nearest to you?",
            options: [
                "Place it at a right angle to the body with the elbow bent",
                "Hold it across their chest",
                "Place it behind their back",
                "Lift it straight in the air"
            ],
            correctIndex: 0,
            explanation: "The nearest arm should be positioned at a right angle with the elbow bent for stability during rolling."
        ),

        RecoveryExamQuestion(
            prompt: "How should you position the casualty’s head once in the recovery position?",
            options: [
                "Tilted back slightly to maintain an open airway",
                "Facing directly downward",
                "Pressed toward their chest",
                "Kept completely straight"
            ],
            correctIndex: 0,
            explanation: "A slight head tilt ensures the airway remains open and fluids drain naturally."
        ),

        RecoveryExamQuestion(
            prompt: "Why is the recovery position important for an unresponsive casualty?",
            options: [
                "It keeps the airway open and prevents choking",
                "It improves circulation",
                "It helps them wake up faster",
                "It prepares them for CPR"
            ],
            correctIndex: 0,
            explanation: "The main purpose is to protect the airway and allow fluids to drain, reducing the risk of choking."
        ),

        RecoveryExamQuestion(
            prompt: "Once the casualty is in the recovery position, what must you continue to do?",
            options: [
                "Monitor breathing until emergency help arrives",
                "Leave them unattended",
                "Give them water",
                "Perform chest compressions"
            ],
            correctIndex: 0,
            explanation: "Breathing must be monitored continuously to ensure it remains normal."
        ),

        RecoveryExamQuestion(
            prompt: "What do you do if the casualty stops breathing while in the recovery position?",
            options: [
                "Roll them onto their back and begin CPR",
                "Leave them in the position",
                "Shake them repeatedly",
                "Give abdominal thrusts"
            ],
            correctIndex: 0,
            explanation: "If breathing stops, roll them onto their back and immediately start CPR."
        )
    ]

    // MARK: - Computed Properties
    var currentQuestion: RecoveryExamQuestion {
        professionalRecoveryQuestions[questionIndex]
    }

    var body: some View {
        HStack(spacing: 24) {

            // MARK: - Preview Window (3D Man)
            RealityView { content in
                if let man = manEntity, man.parent == nil {
                    content.add(man)
                }
            }
            .frame(width: 380, height: 480)
            .glassBackgroundEffect()

            // MARK: - Question Card
            VStack(alignment: .leading, spacing: 20) {

                if examCompleted {
                    summaryCard
                } else {
                    questionCard
                }

                Spacer()
            }
            .frame(maxWidth: .infinity)
        }
        .padding(32)
        .task {
            // Load 3D model
            if manEntity == nil {
                do { manEntity = try await Entity(named: "man", in: realityKitContentBundle) }
                catch { print("Failed to load model: \(error)") }
            }
        }
    }

    // MARK: - Question Card View
    var questionCard: some View {
        VStack(alignment: .leading, spacing: 16) {

            Text("Recovery Position Assessment")
                .font(.largeTitle)
                .bold()

            Text("Question \(questionIndex + 1) of \(professionalRecoveryQuestions.count)")
                .font(.headline)
                .opacity(0.7)

            Text(currentQuestion.prompt)
                .font(.title3)
                .padding(.top, 8)

            ForEach(currentQuestion.options.indices, id: \.self) { idx in
                Button {
                    handleSelection(idx)
                } label: {
                    Text(currentQuestion.options[idx])
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(optionBackground(for: idx))
                        .cornerRadius(12)
                }
                .disabled(selectedIndex != nil)
            }

            if let selected = selectedIndex {
                Text(currentQuestion.explanation)
                    .font(.footnote)
                    .padding(.top, 4)

                HStack {
                    Button("Next Question") { advance() }
                        .buttonStyle(.borderedProminent)

                    Button("Retry Question") { selectedIndex = nil }
                        .buttonStyle(.bordered)
                }
                .padding(.top, 8)
            }
        }
        .padding()
        .glassBackgroundEffect()
    }

    // MARK: - Summary Card
    var summaryCard: some View {
        VStack(spacing: 16) {
            Text("Assessment Complete!")
                .font(.largeTitle.bold())

            Text("Score: \(score) / \(professionalRecoveryQuestions.count)")
                .font(.title2)

            Text("Well done. Continue practising to build confidence.")
                .font(.body)
                .opacity(0.7)

            Button("Retake Exam") { resetExam() }
                .buttonStyle(.borderedProminent)
        }
        .padding()
        .glassBackgroundEffect()
    }

    // MARK: - Helpers
    func handleSelection(_ index: Int) {
        selectedIndex = index
        if index == currentQuestion.correctIndex { score += 1 }
    }

    func advance() {
        if questionIndex + 1 < professionalRecoveryQuestions.count {
            questionIndex += 1
            selectedIndex = nil
        } else {
            examCompleted = true
        }
    }

    func resetExam() {
        questionIndex = 0
        selectedIndex = nil
        score = 0
        examCompleted = false
    }

    func optionBackground(for index: Int) -> Color {
        guard let selected = selectedIndex else { return .gray.opacity(0.2) }
        return index == currentQuestion.correctIndex ? .green.opacity(0.4) : (index == selected ? .red.opacity(0.4) : .gray.opacity(0.2))
    }
}

// MARK: - Preview
#Preview {
    RecoveryAssessmentVolumeView()
}
