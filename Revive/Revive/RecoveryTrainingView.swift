//
//  RecoveryTrainingView.swift
//  Revive
//
//  Created by ariana jansen on 06/01/2026.
//

import SwiftUI

struct RecoveryTrainingView: View {

    private let recoverySteps: [TrainingStep] = [

        TrainingStep(
            title: "Check Responsiveness",
            description: """
Before touching the person, make sure the area is safe (no traffic, fire, or sharp objects).

Kneel beside them and gently tap the shoulders.

Speak loudly:
“Can you hear me? Open your eyes.”

Check for any response:
• Eye movement  
• Facial reaction  
• Attempt to speak  
• Any purposeful movement  

If unresponsive *but breathing*, continue.
If not breathing → start CPR immediately.
""",
            customView: nil
        ),

        TrainingStep(
            title: "Open the Airway",
            description: """
Place one hand on the forehead.
Place two fingers of your other hand under the chin.

Tilt the head back slightly to open the airway.

Check for normal breathing for up to 10 seconds:
• Look for chest movement  
• Listen for breath  
• Feel for air on your cheek  

If breathing normally, move to the recovery position.
If not breathing → begin CPR immediately.
""",
            customView: nil
        ),

        TrainingStep(
            title: "Position the Arm Closest to You",
            description: """
Straighten the arm that is nearest to you.

Place it at a right angle (90°) to the body:
• Elbow bent  
• Palm facing upward  

This arm acts as stabilisation during the roll.
""",
            customView: nil
        ),

        TrainingStep(
            title: "Position the Far Arm",
            description: """
Take the person’s far arm and place it across their chest.

Put the back of their hand against the cheek closest to you.

Hold it gently in place.
This helps keep the head aligned during the roll.
""",
            customView: nil
        ),

        TrainingStep(
            title: "Prepare the Far Leg",
            description: """
Take the leg that is furthest from you.

Bend the knee upwards so the foot is flat on the ground.

This leg acts as a lever to help you roll the person safely.
""",
            customView: nil
        ),

        TrainingStep(
            title: "Roll to the Side",
            description: """
Keep the person’s hand pressed lightly to their cheek.

Place your other hand on their bent knee.

Pull the knee towards you in one controlled movement.

Guide the body as it rolls toward you.
Do NOT twist the neck.

Ensure the person rests safely on their side.
""",
            customView: nil
        ),

        TrainingStep(
            title: "Adjust the Airway",
            description: """
Tilt the head slightly back again to keep the airway open.

Angle the mouth downward to allow vomit or fluid to drain safely.

Adjust the top leg into a 90° bend.
This prevents rolling onto the stomach or back.

Make sure the top arm continues supporting the head.
""",
            customView: nil
        ),

        TrainingStep(
            title: "Monitor Until Help Arrives",
            description: """
Stay with the person at all times.

Regularly check:
• Are they still breathing normally?  
• Has breathing changed?  
• Is the airway clear?  

If breathing stops at ANY time:
Roll them onto their back and start CPR immediately.
""",
            customView: nil
        )
    ]

    var body: some View {
        TrainingStepView(steps: recoverySteps)
            .navigationTitle("Recovery Position")
            .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        RecoveryTrainingView()
    }
}
