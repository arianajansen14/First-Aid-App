//
//  TrainingSceneView.swift
//  Revive
//

import SwiftUI
import RealityKit
import RealityKitContent

struct TrainingSceneView: View {

    let sceneName: String
    let tintEnabled: Bool      // <—— REQUIRED

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

    // MARK: - Load Scene
    private func loadScene() async {
        root.children.removeAll()

        guard let scene = try? await Entity.load(named: sceneName,
                                                 in: realityKitContentBundle)
        else {
            print("❌ Failed to load scene:", sceneName)
            return
        }

        let model = scene.clone(recursive: true)

        if tintEnabled {
            applyTint(to: model)
        }

        root.addChild(model)
    }

    // MARK: - Tint Application
    private func applyTint(to entity: Entity) {
        guard
            let hex = UserDefaults.standard.string(forKey: "savedTintColor"),
            let color = Color(hex: hex),
            let mesh = entity.findEntity(named: "Manguts") as? ModelEntity
        else { return }

        mesh.model?.materials = [
            SimpleMaterial(color: UIColor(color), isMetallic: false)
        ]
    }
}
