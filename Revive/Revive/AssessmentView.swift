import SwiftUI

struct AssessmentView: View {

    // MARK: - CPR Questions
    private let cprQuestions: [AssessmentQuestion] = [
        AssessmentQuestion(
            question: "Where should chest compressions be performed?",
            answers: ["Lower abdomen", "Centre of the chest", "On the neck", "Upper ribs"],
            correctIndex: 1,
            explanation: "Chest compressions must be performed in the centre of the chest, on the sternum."
        ),
        AssessmentQuestion(
            question: "What is the correct compression rate?",
            answers: ["40–60 per minute", "80–100 per minute", "100–120 per minute", "150–200 per minute"],
            correctIndex: 2,
            explanation: "The recommended CPR compression rate is 100–120 compressions per minute."
        ),
        AssessmentQuestion(
            question: "What is the correct compression depth for an adult?",
            answers: ["1 cm", "3 cm", "5–6 cm", "10 cm"],
            correctIndex: 2,
            explanation: "Adult compressions must be 5–6 cm deep to be effective."
        )
    ]

    // MARK: - BREATHING QUESTIONS
    private let breathingQuestions: [AssessmentQuestion] = [
        AssessmentQuestion(
            question: "How long should you check for normal breathing?",
            answers: ["1 second", "5 seconds", "10 seconds", "30 seconds"],
            correctIndex: 2,
            explanation: "You should check for normal breathing for no more than 10 seconds."
        ),
        AssessmentQuestion(
            question: "Which method is used to open the airway?",
            answers: ["Jaw thrust", "Head tilt & chin lift", "Neck extension", "Pulling the tongue forward"],
            correctIndex: 1,
            explanation: "The standard airway-opening method is the head-tilt chin-lift manoeuvre."
        )
    ]

    // MARK: - RECOVERY POSITION QUESTIONS
    private let recoveryQuestions: [AssessmentQuestion] = [
        AssessmentQuestion(
            question: "When should someone be placed in the Recovery Position?",
            answers: ["If breathing normally but unconscious", "If fully awake", "If not breathing", "If choking"],
            correctIndex: 0,
            explanation: "Use the recovery position for an unconscious but normally breathing person."
        ),
        AssessmentQuestion(
            question: "Why is the Recovery Position used?",
            answers: [
                "To help them sleep comfortably",
                "To maintain an open airway",
                "To stop CPR",
                "To prevent movement"
            ],
            correctIndex: 1,
            explanation: "The recovery position keeps the airway open and prevents choking."
        )
    ]

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 30) {

                Text("Assessment")
                    .font(.largeTitle.bold())

                Text("Choose a module to be assessed on. You will answer multiple-choice questions and receive a score at the end.")
                    .font(.title3)
                    .foregroundStyle(.secondary)

                Divider().padding(.vertical, 10)

                VStack(spacing: 20) {

                    // CPR
                    NavigationLink {
                        AssessmentQuestionView(
                            questions: cprQuestions,
                            moduleTitle: "CPR Assessment"
                        )
                    } label: {
                        moduleButton(title: "CPR Assessment", subtitle: "Test your CPR knowledge", icon: "waveform.path.ecg")
                    }

                    // Breathing
                    NavigationLink {
                        AssessmentQuestionView(
                            questions: breathingQuestions,
                            moduleTitle: "Breathing Assessment"
                        )
                    } label: {
                        moduleButton(title: "Breathing Assessment", subtitle: "Airway & breathing checks", icon: "lungs.fill")
                    }

                    // Recovery
                    NavigationLink {
                        AssessmentQuestionView(
                            questions: recoveryQuestions,
                            moduleTitle: "Recovery Position Assessment"
                        )
                    } label: {
                        moduleButton(title: "Recovery Position", subtitle: "Safe positioning knowledge", icon: "figure.stand")
                    }
                }

                Spacer()
            }
            .padding(50)
            .glassBackgroundEffect()
        }
    }

    // MARK: - UI Button Style
    private func moduleButton(title: String, subtitle: String, icon: String) -> some View {
        HStack(spacing: 16) {
            Image(systemName: icon)
                .font(.title)
                .foregroundColor(.white)

            VStack(alignment: .leading, spacing: 4) {
                Text(title).font(.headline)
                Text(subtitle)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }

            Spacer()

            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
        }
        .padding(20)
        .frame(maxWidth: .infinity)
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}
