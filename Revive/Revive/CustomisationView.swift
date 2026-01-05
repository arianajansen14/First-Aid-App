//
//  CustomisationView.swift
//

import SwiftUI
import RealityKit
import RealityKitContent

struct CustomisationView: View {

    @State private var selectedColor: Color? = nil
    @State private var rootEntity: Entity? = nil
    @State private var meshEntity: ModelEntity? = nil
    @State private var originalMaterial: RealityKit.Material? = nil

    var body: some View {
        HStack {

            // -----------------------------------------------------------
            // LEFT SIDE UI
            // -----------------------------------------------------------
            VStack(alignment: .leading, spacing: 20) {

                Text("Customisation")
                    .font(.largeTitle.bold())

                Text("Preset Colours")
                    .font(.headline)

                // PRESET COLOUR CIRCLES
                HStack {
                    ForEach([Color.red, .green, .blue, .yellow, .orange, .pink],
                            id: \.self) { col in
                        Circle()
                            .fill(col)
                            .frame(width: 30, height: 30)
                            .onTapGesture {
                                selectedColor = col
                                applyTint()
                            }
                    }
                }

                // LIVE PREVIEW TEXT (MOVED HERE)
                Text(selectedColor == nil ?
                     "Previewing original model" :
                     "Previewing coloured model")
                    .font(.headline)
                    .foregroundColor(.secondary)
                    .padding(.top, 10)

                // IMPORT SKIN BUTTON (UI ONLY FOR NOW)
                Button("Import Skin") {
                    print("🟣 Import skin tapped — will implement later.")
                }
                .buttonStyle(.bordered)

                // RESET BUTTON
                Button("Reset to Original") {
                    selectedColor = nil
                    resetTint()
                }
                .buttonStyle(.borderedProminent)

                Spacer()
            }
            .frame(width: 350)
            .padding()

            // -----------------------------------------------------------
            // RIGHT SIDE — MODEL PREVIEW
            // -----------------------------------------------------------
            VStack {
                modelPreview
                    .frame(width: 600, height: 500)
            }
            .padding()
        }
        .task {
            await loadModel()
        }
    }
}

//
// MARK: - RealityView (no async allowed)
//
extension CustomisationView {
    private var modelPreview: some View {
        RealityView { content in
            if let root = rootEntity {
                if content.entities.isEmpty {
                    content.add(root)
                }
            }
        }
    }
}

//
// MARK: - Load Model (async allowed)
//
extension CustomisationView {

    private func loadModel() async {
        guard rootEntity == nil else { return }

        do {
            // LOAD YOUR MODEL
            let entity = try await Entity.load(named: "MaN",
                                               in: realityKitContentBundle)

            // Auto-fit the model safely
            autoFit(entity)

            rootEntity = entity

            // FIND YOUR MAIN MESH
            if let mesh = entity.findEntity(named: "Manguts") as? ModelEntity {
                meshEntity = mesh
                originalMaterial = mesh.model?.materials.first
                print("✅ Found mesh: Manguts")
            } else {
                print("⚠️ Manguts NOT found")
            }

        } catch {
            print("❌ Failed to load MaN.usdz:", error)
        }
    }
}

//
// MARK: - Auto-fit model (no crashes)
//
extension CustomisationView {

    private func autoFit(_ entity: Entity) {
        let bounds = entity.visualBounds(relativeTo: nil)
        let maxDim = max(bounds.extents.x, bounds.extents.y, bounds.extents.z)

        // Your stable scale (was working)
        let scale = 0.35 / max(0.001, maxDim)

        entity.scale = [scale, scale, scale]

        // Center it in view
        entity.position = [
            -bounds.center.x * scale,
            -bounds.center.y * scale,
            -bounds.center.z * scale
        ]
    }
}

//
// MARK: - Tint System
//
extension CustomisationView {

    private func applyTint() {
        guard let mesh = meshEntity,
              let col = selectedColor else { return }

        var model = mesh.model
        model?.materials = [
            SimpleMaterial(color: UIColor(col), isMetallic: false)
        ]
        mesh.model = model
    }

    private func resetTint() {
        guard let mesh = meshEntity,
              let original = originalMaterial else { return }

        var model = mesh.model
        model?.materials = [original]
        mesh.model = model
    }
}
