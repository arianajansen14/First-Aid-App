//
//  AirwayAssessmentVolumeView.swift
//  try2
//
//  Created by Ariana Jansen on 04/12/2025.
//

import SwiftUI
import RealityKit
import RealityKitContent

// Simple question model
struct AirwayQuestion: Identifiable {
    let id = UUID()
    let question: String
    let options: [String]
    let correctIndex: Int
}

/// Airway-only assessment window
struct AirwayAssessmentVolumeView: View {

    // MARK: - Exam State
    @State private var currentQuestionIndex: Int = 0
    @State private var selectedOptionIndex: Int? = nil
    @State private var score: Int = 0
    @State private var examCompleted = false

    // MARK: - 3D Preview State
    @State private var manEntity: Entity?

    // MARK: - Airway Questions
    private let airwayQuestions: [AirwayQuestion] = [
        AirwayQuestion(
            question: "What is the first step in assessing airway?",
            options: [
                "Open the mouth and inspect",
                "Listen for breathing",
                "Check responsiveness",
                "Perform rescue breaths immediately"
            ],
            correctIndex: 2
        ),
        AirwayQuestion(
            question: "Which method is used to open an airway?",
            options: [
                "Chin lift / Head tilt",
                "Triple Airway Manoeuvre",
                "Jaw thrust",
                "All of the above"
            ],
            correctIndex: 3
        ),
        AirwayQuestion(
            question: "What is the recommended method to check for normal breathing?",
            options: [
                "Look, listen, and feel",
                "Check radial pulse",
                "Begin chest compressions",
                "Give two rescue breaths"
            ],
            correctIndex: 0
        ),
        AirwayQuestion(
            question: "When should the jaw thrust technique be used instead of head‑tilt chin‑lift?",
            options: [
                "When the patient is vomiting",
                "When a spinal injury is suspected",
                "When the patient is unconscious",
                "When rescue breaths are ineffective"
            ],
            correctIndex: 1
        ),
        AirwayQuestion(
            question: "What is a key sign of a completely blocked airway?",
            options: [
                "Gasping",
                "Weak cough",
                "Effective breathing sounds",
                "Silent, unable to breathe or cough"
            ],
            correctIndex: 3
        )
    ]

    // MARK: - Body
    var body: some View {
        HStack(spacing: 24) {

            // LEFT: 3D MODEL PREVIEW
            VStack {
                Text("Airway Model View")
                    .font(.title2.bold())

                RealityView { content in
                    if let man = manEntity, man.parent == nil {
                        content.add(man)
                    } else {
                        // Load man.usda for preview in exam window
                        Task {
                            do {
                                let loaded = try await Entity(
                                    named: "man",
                                    in: realityKitContentBundle
                                )
                                manEntity = loaded
                            } catch {
                                print("Failed to load man.usda: \(error)")
                            }
                        }
                    }
                }
                .frame(width: 400, height: 400)
                .glassBackgroundEffect()
            }

            // RIGHT: QUESTIONS
            VStack(alignment: .leading, spacing: 20) {

                if examCompleted {
                    summaryView
                } else {
                    questionView
                }
            }
            .padding()
            .frame(maxWidth: 400)
            .glassBackgroundEffect()
        }
        .padding()
        .task {
            // Reset when opened
            resetExam()
        }
    }

    // MARK: - Question View
    private var questionView: some View {
        let question = airwayQuestions[currentQuestionIndex]

        return VStack(alignment: .leading, spacing: 20) {
            Text(question.question)
                .font(.title3.bold())

            ForEach(question.options.indices, id: \.self) { index in
                let isSelected = selectedOptionIndex == index
                let isCorrect = index == question.correctIndex
                let answered = selectedOptionIndex != nil

                Button {
                    handleAnswer(index: index)
                } label: {
                    Text(question.options[index])
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                        .background(answered ?
                                    (isCorrect ? Color.green.opacity(0.2) :
                                                 (isSelected ? Color.red.opacity(0.2) : Color.clear))
                                    : Color.clear)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }
                .disabled(answered)
            }

            if selectedOptionIndex != nil {
                Button("Next") {
                    goToNextQuestion()
                }
                .padding(.top, 10)
            }
        }
    }

    // MARK: - Summary View
    private var summaryView: some View {
        VStack(spacing: 20) {
            Text("Airway Assessment Complete")
                .font(.title2.bold())

            let total = airwayQuestions.count
            let percentage = Int((Double(score) / Double(total)) * 100)

            Text("Score: \(score)/\(total) (\(percentage)%)")

            if percentage == 100 {
                Text("Perfect airway technique!").foregroundColor(.green)
            } else if percentage >= 70 {
                Text("Strong understanding.").foregroundColor(.yellow)
            } else {
                Text("Review airway steps again.").foregroundColor(.red)
            }

            Button("Restart") {
                resetExam()
            }
            .padding(.top, 10)
        }
    }

    // MARK: - Logic
    private func handleAnswer(index: Int) {
        selectedOptionIndex = index

        if index == airwayQuestions[currentQuestionIndex].correctIndex {
            score += 1
        }
    }

    private func goToNextQuestion() {
        if currentQuestionIndex < airwayQuestions.count - 1 {
            currentQuestionIndex += 1
            selectedOptionIndex = nil
        } else {
            examCompleted = true
        }
    }

    private func resetExam() {
        currentQuestionIndex = 0
        selectedOptionIndex = nil
        score = 0
        examCompleted = false
    }
}
