//
//  TrainingImmersiveView.swift
//  try2
//
//  Created by ariana jansen on 28/11/2025.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct TrainingImmersiveView: View {

    // MARK: - State

    // State variable holding scene
    @State private var root: Entity?

    // MARK: - Body

    var body: some View {
        ZStack {
            // MARK: - RealityView Setup
            // Loads the immersive scene once and attaches gestures for hover + tap
            RealityView { content in

                if root == nil {
                    // Load the Reality Composer Pro scene named "Immersive"
                    Task {
                        do {
                            let scene = try await Entity(
                                named: "Immersive",
                                in: realityKitContentBundle
                            )
                            await MainActor.run {
                                root = scene
                            }
                        } catch {
                            print("Failed to load immersive scene: \(error)")
                        }
                    }
                }

            } update: { content in    // <-- only ONE parameter in this SDK

                guard let scene = root else { return }

                // Attach the scene to the RealityView once it's loaded
                if scene.parent == nil {
                    content.add(scene)

                    // Clean RCP materials so colour changes show
                    removeRCPMaterials(scene.findEntity(named: "Cube"))
                    removeRCPMaterials(scene.findEntity(named: "Cube_003"))
                    removeRCPMaterials(scene.findEntity(named: "Cube_007"))

                    // --- STATIC LABELS (matching assessment positioning) ---
                    if let head = scene.findEntity(named: "Cube_003") {
                        addStaticLabel(text: "Airway", above: head, in: scene)
                    }
                    if let chest = scene.findEntity(named: "Cube") {
                        addStaticLabel(text: "CPR", above: chest, in: scene)
                    }
                    if let legs = scene.findEntity(named: "Cube_007") {
                        addStaticLabel(text: "Recovery", above: legs, in: scene)
                    }
                }

            }
            .gesture(tapGesture)
        }
    }

    // MARK: - Material Helpers

    // Removes RCP materials so our highlight colours can show properly
    func removeRCPMaterials(_ entity: Entity?) {
        guard let entity = entity,
              var model = entity.components[ModelComponent.self] else { return }
        model.materials = []
        entity.components[ModelComponent.self] = model
    }

    // MARK: - Labels

    // Adds a static text label above a given entity within the scene
    func addStaticLabel(text: String, above entity: Entity, in root: Entity) {
        let mesh = MeshResource.generateText(
            text,
            extrusionDepth: 0.01,
            font: .systemFont(ofSize: 0.12),
            containerFrame: .zero,
            alignment: .center,
            lineBreakMode: .byWordWrapping
        )

        let mat = UnlitMaterial(color: .white)
        let model = ModelEntity(mesh: mesh, materials: [mat])
        model.components.set(BillboardComponent())

        let worldPos = entity.position(relativeTo: nil)
        model.position = [worldPos.x, worldPos.y + 0.25, worldPos.z]

        root.addChild(model)
    }

    // MARK: - Training Mapping

    // Maps cube names from Reality Composer to meaningful training names
    func trainingName(for entity: Entity) -> String? {
        switch entity.name {
        case "Cube":     return "CPR"
        case "Cube_003": return "Airway"
        case "Cube_007": return "Recovery"
        default:         return nil
        }
    }

    // MARK: - Tap Handling

    // When the user taps a zone → load the specific training scene
    func handleTap(on entity: Entity) {
        guard let name = trainingName(for: entity) else { return }
        openTrainingScene(named: name)
    }

    // MARK: - Scene Switching

    // Loads and adds a specific training scene to the root's parent
    func openTrainingScene(named sceneName: String) {
        Task {
            do {
                let scene = try await Entity(
                    named: sceneName,
                    in: realityKitContentBundle
                )
                root?.parent?.addChild(scene)
            } catch {
                print(" Failed to load training scene \(sceneName): \(error)")
            }
        }
    }

    // MARK: - Gestures

    // Tap gesture: loads training scene
    private var tapGesture: some Gesture {
        SpatialTapGesture()
            .targetedToAnyEntity()
            .onEnded { value in
                handleTap(on: value.entity)
            }
    }

}
