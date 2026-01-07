import SwiftUI

struct AssessmentResultView: View {

    let score: Int
    let totalCount: Int
    let moduleTitle: String

    let onRetry: () -> Void
    let onFinish: () -> Void

    var passed: Bool {
        score >= Int(Double(totalCount) * 0.7)
    }

    var body: some View {
        VStack(spacing: 30) {

            Text(moduleTitle)
                .font(.largeTitle.bold())

            Text(passed ? "Pass" : "Fail")
                .font(.system(size: 50, weight: .heavy))
                .foregroundColor(passed ? .green : .red)

            Text("You scored \(score) out of \(totalCount)")
                .font(.title2)
                .foregroundStyle(.secondary)

            Spacer()

            Button("Retry") {
                onRetry()
            }
            .buttonStyle(.borderedProminent)

            Button("Finish") {
                onFinish()
            }
            .buttonStyle(.bordered)

        }
        .padding(40)
        .glassBackgroundEffect()
    }
}
