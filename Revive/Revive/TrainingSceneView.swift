//
//  TrainingSceneView.swift
//  Revive
//
//  Created by ariana jansen on 13/01/2026.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct TrainingSceneView: View {

    let sceneName: String       // "cprhands", "cprhelp", "TrainingScene"
    let tintEnabled: Bool       // apply tint if user selected tinted Man model

    @State private var root = Entity()

    var body: some View {
        RealityView { content in
            // Add only once
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

    // LOAD REALITYKIT SCENE
    private func loadScene() async {
        root.children.removeAll()

        guard let scene = try? await Entity.load(
            named: sceneName,
            in: realityKitContentBundle
        ) else {
            print("❌ Failed to load scene:", sceneName)
            return
        }

        let cloned = scene.clone(recursive: true)

        // Apply tint only when enabled + mesh exists
        if tintEnabled {
            applyTint(to: cloned)
        }

        root.addChild(cloned)
    }

    // APPLY TINT TO MAN MESH
    private func applyTint(to entity: Entity) {
        guard
            let hex = UserDefaults.standard.string(forKey: "savedTintColor"),
            let color = Color(hex: hex),
            let mesh = entity.findEntity(named: "Manguts") as? ModelEntity
        else {
            return
        }

        mesh.model?.materials = [
            SimpleMaterial(color: UIColor(color), isMetallic: false)
        ]
    }
}
