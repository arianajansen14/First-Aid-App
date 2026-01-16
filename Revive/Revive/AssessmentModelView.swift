//
//  AssessmentModelView.swift
//  Revive
//

import SwiftUI
import RealityKit
import RealityKitContent

struct AssessmentModelView: View {

    @State private var root = Entity()
    @Environment(AppModel.self) private var model

    var body: some View {
        RealityView { content in
            if root.parent == nil {
                content.add(root)
            }
        }
        .task { await loadModel() }
    }
}

extension AssessmentModelView {

    private func loadModel() async {
        root.children.removeAll()

        guard let scene = try? await Entity.load(
            named: "PreviewScene",
            in: realityKitContentBundle
        ) else { return }

        // LOAD ONLY MAN — clean and simple
        if let man = scene.findEntity(named: "MaN")?.clone(recursive: true) {
            autoFit(man)
            root.addChild(man)
        }
    }

    private func autoFit(_ entity: Entity) {
        let bounds = entity.visualBounds(relativeTo: nil)
        let maxDim = max(bounds.extents.x, bounds.extents.y, bounds.extents.z)
        let scale = 0.35 / maxDim

        entity.scale = SIMD3(repeating: Float(scale))

        entity.position = [
            -bounds.center.x * Float(scale),
            -bounds.center.y * Float(scale),
            -bounds.center.z * Float(scale)
        ]
    }
}
