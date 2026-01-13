//
//  AssessmentModelView.swift
//  Revive
//

import SwiftUI
import RealityKit
import RealityKitContent

struct AssessmentModelView: View {

    @State private var rootEntity = Entity()

    @AppStorage("selectedModel") private var savedModel: String = "man"   // man, manTinted, joel
    @AppStorage("savedTintColor") private var savedTintHex: String = ""   // "#RRGGBB"

    var body: some View {
        RealityView { content in

            // Add only once
            if rootEntity.parent == nil {
                content.add(rootEntity)
            }

        }
        .task {
            await loadModel()
        }
        .padding()
    }
}

extension AssessmentModelView {

    private func loadModel() async {

        // Clear whatever is inside the rootEntity
        rootEntity.children.removeAll()

        guard let scene = try? await Entity.load(named: "PreviewScene",
                                                 in: realityKitContentBundle) else {
            print("❌ Failed to load PreviewScene")
            return
        }

        let man = scene.findEntity(named: "MaN")
        let joel = scene.findEntity(named: "_09_08_2023")

        // We always clone so the Customisation view stays untouched
        var model: Entity?

        switch savedModel {

        case "joel":
            model = joel?.clone(recursive: true)

        case "manTinted":
            if let m = man?.clone(recursive: true) {
                tintMan(on: m)
                model = m
            }

        default: // "man"
            model = man?.clone(recursive: true)
        }

        guard let model else { return }

        autoFit(model)
        rootEntity.addChild(model)
    }

    // Tint mesh if saved
    private func tintMan(on entity: Entity) {
        guard let tintColor = Color(hex: savedTintHex),
              let mesh = entity.findEntity(named: "Manguts") as? ModelEntity else { return }

        mesh.model?.materials = [
            SimpleMaterial(color: UIColor(tintColor), isMetallic: false)
        ]
    }

    // Scale + center
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

//
// MARK: - HEX PARSER
//
extension Color {
    init?(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

        var rgb: UInt64 = 0
        guard Scanner(string: hexSanitized).scanHexInt64(&rgb) else { return nil }

        let r = Double((rgb >> 16) & 0xFF) / 255
        let g = Double((rgb >> 8) & 0xFF) / 255
        let b = Double(rgb & 0xFF) / 255

        self = Color(red: r, green: g, blue: b)
    }
}
