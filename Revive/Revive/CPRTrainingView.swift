import SwiftUI

struct CPRTrainingView: View {

    private let cprSteps: [TrainingStep] = [

        TrainingStep(
            title: "Locate the Casualty",
            description: "Look around the area and find the person who needs help. Make sure the location is safe for you before approaching",
            customView: nil
        ),

        TrainingStep(
            title: "Check Responsiveness",
            description: "Kneel beside the person. Tap their shoulders firmly and speak loudly: ‘Can you hear me?’ Look for any response — movement, sound, or opening of the eyes.",
            customView: nil
        ),

        TrainingStep(
            title: "Assess Breathing",
            description: "Look at the chest to see if it rises and falls. Listen for normal breathing. If the person is not breathing or breathing abnormally (gasping), begin CPR immediately",
            customView: nil
        ),

        TrainingStep(
            title: "Call Emergency Services",
            description: "Call 999, or ask someone nearby to call. Put the phone on speaker so you can keep your hands free. Follow the operator’s guidance while you start CPR.",
            customView: nil
        ),

        TrainingStep(
            title: "Hand Positioning",
            description: "Place the heel of your hand in the centre of the chest. Put your other hand on top and interlock your fingers. Keep your arms straight with your shoulders directly above your hands.",
            customView: nil // later: tile view for hand demo animation
        ),

        TrainingStep(
            title: "Start Chest Compressions",
            description: "Press straight down hard and fast at 100–120 compressions per minute. Allow the chest to fully rise between pushes.",
            customView: nil // later: BPM ring animation
        ),

        TrainingStep(
            title: "Continue CPR",
            description: "Do not stop unless help arrives, the person shows signs of life, or you're unable to continue.",
            customView: nil
        )
    ]

    var body: some View {
        TrainingStepView(steps: cprSteps)
            .navigationTitle("CPR Training")
            .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        CPRTrainingView()
    }
}
