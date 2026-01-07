//
//  CustomisationView.swift
//

import SwiftUI
import RealityKit
import RealityKitContent

struct CustomisationView: View {

    // MARK: - State
    @State private var selectedColor: Color? = nil

    // Man model ("MaN")
    @State private var manEntity: Entity? = nil
    @State private var manMesh: ModelEntity? = nil
    @State private var originalMaterial: RealityKit.Material? = nil

    // Joel model ("_09_08_2023")
    @State private var joelEntity: Entity? = nil
    @State private var isUsingJoel: Bool = false

    var body: some View {
        HStack {

            // ===========================
            // LEFT PANEL
            // ===========================
            VStack(alignment: .leading, spacing: 20) {

                Text("Customisation")
                    .font(.largeTitle.bold())

                // ---------------------------
                // COLOUR PRESETS
                // ---------------------------
                Text("Preset Colours")
                    .font(.headline)

                HStack {
                    ForEach([Color.red, .orange, .yellow, .green, .blue, .indigo, .purple, .pink],
                            id: \.self) { col in
                        Circle()
                            .fill(col)
                            .frame(width: 28, height: 28)
                            .opacity(isUsingJoel ? 0.25 : 1.0)
                            .onTapGesture {
                                guard !isUsingJoel else { return }
                                selectedColor = col
                                applyTint()
                            }
                    }
                }

                // ---------------------------
                // STATUS MESSAGE
                // ---------------------------
                Group {
                    if isUsingJoel {
                        Text("ⓘ Imported skins cannot be tinted.\nThey appear only in non-interactive steps.")
                            .font(.callout)
                            .foregroundColor(.orange)
                    } else if selectedColor != nil {
                        Text("Previewing coloured model")
                            .foregroundColor(.secondary)
                    } else {
                        Text("Previewing original model")
                            .foregroundColor(.secondary)
                    }
                }

                // ---------------------------
                // SKIN SWITCHER
                // ---------------------------
                Text("Skins")
                    .font(.headline)
                    .padding(.top, 6)

                Button("Default Man") {
                    switchToMan()
                }

                Button("Joel") {
                    switchToJoel()
                }

                // ---------------------------
                // RESET BUTTON
                // ---------------------------
                Button("Reset to Original") {
                    selectedColor = nil
                    resetTint()
                    switchToMan()
                }
                .buttonStyle(.borderedProminent)

                // ---------------------------
                // SAVE BUTTON
                // ---------------------------
                Button("Save Appearance") {
                    saveAppearance()
                }
                .buttonStyle(.bordered)

                Spacer()
            }
            .frame(width: 350)
            .padding()

            // ===========================
            // MODEL PREVIEW
            // ===========================
            VStack {
                modelPreview
                    .frame(width: 600, height: 500)
            }
            .padding()
        }
        .task {
            await loadPreviewScene()
        }
    }
}

//
// MARK: - RealityView
//
extension CustomisationView {

    private var modelPreview: some View {
        RealityView { content in

            if content.entities.isEmpty {
                if let man = manEntity { content.add(man) }
                if let joel = joelEntity { content.add(joel) }
            }
        }
    }
}

//
// MARK: - Load PreviewScene
//
extension CustomisationView {

    private func loadPreviewScene() async {
        do {
            let scene = try await Entity.load(
                named: "PreviewScene",
                in: realityKitContentBundle
            )

            // MATCH EXACT NAMES FROM RCP
            manEntity = scene.findEntity(named: "MaN")
            joelEntity = scene.findEntity(named: "_09_08_2023")

            // Assign OpacityComponents manually (CRITICAL FIX)
            manEntity?.components.set(OpacityComponent(opacity: 1.0))
            joelEntity?.components.set(OpacityComponent(opacity: 0.0))

            // Tintable mesh
            manMesh = manEntity?.findEntity(named: "Manguts") as? ModelEntity
            originalMaterial = manMesh?.model?.materials.first

            print("✅ Loaded PreviewScene")
            print("→ Man found:", manEntity != nil)
            print("→ Joel found:", joelEntity != nil)

        } catch {
            print("❌ Failed to load PreviewScene:", error)
        }
    }
}

//
// MARK: - Visibility Switching
//
extension CustomisationView {

    private func switchToMan() {
        isUsingJoel = false
        setOpacity(entity: manEntity, value: 1.0)
        setOpacity(entity: joelEntity, value: 0.0)
    }

    private func switchToJoel() {
        isUsingJoel = true
        setOpacity(entity: manEntity, value: 0.0)
        setOpacity(entity: joelEntity, value: 1.0)
    }

    private func setOpacity(entity: Entity?, value: Float) {
        guard var opacity = entity?.components[OpacityComponent.self] else { return }
        opacity.opacity = value
        entity?.components.set(opacity)
    }
}

//
// MARK: - Tint System
//
extension CustomisationView {

    private func applyTint() {
        guard !isUsingJoel else { return }
        guard let mesh = manMesh,
              let col = selectedColor else { return }

        var model = mesh.model
        model?.materials = [
            SimpleMaterial(color: UIColor(col), isMetallic: false)
        ]
        mesh.model = model
    }

    private func resetTint() {
        guard let mesh = manMesh,
              let original = originalMaterial else { return }

        var model = mesh.model
        model?.materials = [original]
        mesh.model = model
    }
}

//
// MARK: - Save Appearance
//
extension CustomisationView {

    private func saveAppearance() {
        if isUsingJoel {
            print("💾 Saved appearance: Joel")
        } else if selectedColor != nil {
            print("💾 Saved appearance: Tinted Man")
        } else {
            print("💾 Saved appearance: Default Man")
        }
    }
}
