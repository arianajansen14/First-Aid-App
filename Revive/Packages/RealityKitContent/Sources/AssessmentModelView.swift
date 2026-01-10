//
//  AssessmentModelView.swift
//  RealityKitContent
//
//  Created by ariana jansen on 10/01/2026.
//


//
//  AssessmentModelView.swift
//  Revive
//

import SwiftUI
import RealityKit
import RealityKitContent

struct AssessmentModelView: View {

    @Environment(AppModel.self) private var appModel

    @State private var manEntity: Entity?
    @State private var joelEntity: Entity?
    @State private var manMesh: ModelEntity?
    @State private var originalMaterial: Material?

    var body: some View {
        RealityView { content in
            if content.entities.isEmpty {
                Task { await loadScene(into: content) }
            }
        }
    }

    // LOAD FROM PreviewScene
    private func loadScene(into content: RealityViewContent) async {
        do {
            let scene = try await Entity.load(named: "PreviewScene", in: realityKitContentBundle)

            manEntity = scene.findEntity(named: "MaN")
            joelEntity = scene.findEntity(named: "_09_08_2023")

            manEntity?.components.set(OpacityComponent(opacity: 1.0))
            joelEntity?.components.set(OpacityComponent(opacity: 0.0))

            manMesh = manEntity?.findEntity(named: "Manguts") as? ModelEntity
            originalMaterial = manMesh?.model?.materials.first

            applyAppearance()

            if let man = manEntity { content.add(man) }
            if let joel = joelEntity { content.add(joel) }

        } catch {
            print("❌ Failed to load PreviewScene:", error)
        }
    }

    // APPLY SAVED LOOK
    private func applyAppearance() {
        switch appModel.savedAppearance {

        case "manTinted":
            if let tint = appModel.savedTintColor {
                var model = manMesh?.model
                model?.materials = [SimpleMaterial(color: UIColor(tint), isMetallic: false)]
                manMesh?.model = model
            }

        case "joel":
            manEntity?.components.set(OpacityComponent(opacity: 0.0))
            joelEntity?.components.set(OpacityComponent(opacity: 1.0))

        default:
            break
        }
    }
}