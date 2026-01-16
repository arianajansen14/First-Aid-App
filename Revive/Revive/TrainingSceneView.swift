//
//  TrainingSceneView.swift
//  Revive
//

import SwiftUI
import RealityKit
import RealityKitContent

struct TrainingSceneView: View {

    let sceneName: String
    let tintEnabled: Bool   // kept for compatibility, but does nothing

    @State private var root = Entity()

    var body: some View {
        RealityView { content in
            if root.parent == nil {
                content.add(root)
            }
        }
        .task {
            await loadScene()
        }
        .frame(height: 350)
        .padding(.vertical)
    }

    // loads your RealityKit scene
    private func loadScene() async {
        root.children.removeAll()

        guard let scene = try? await Entity.load(
            named: sceneName,
            in: realityKitContentBundle
        ) else {
            print("❌ Failed to load scene:", sceneName)
            return
        }

        let model = scene.clone(recursive: true)

        // tint has been disabled permanently
        // (kept structure but no tint applied)

        root.addChild(model)
    }
}
