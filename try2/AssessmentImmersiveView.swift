//
//
import SwiftUI
import RealityKit
import RealityKitContent

struct AssessmentImmersiveView: View {

    @Environment(\.openImmersiveSpace) private var openImmersiveSpace
    @Environment(\.dismissImmersiveSpace) private var dismissImmersiveSpace

    // MARK: - Navigation State
    @State private var selectedSection: AppSection = .assessment

    // MARK: - Scene State
    @State private var root: Entity?
    @State private var selectedZone: String?

    var body: some View {
        ZStack(alignment: .leading) {

            // MARK: - Left Navigation Bar (always visible)
            LeftNavBar(selectedSection: $selectedSection)

            // MARK: - Immersive Scene Area
            RealityView { content in

                if let scene = root, scene.parent == nil {
                    content.add(scene)
                    removeMaterials(scene)

                    // Zone labels: CPR / Airway / Recovery
                    let zones: [(String, String)] = [
                        ("Cube_003", "Airway"),
                        ("Cube", "CPR"),
                        ("Cube_007", "Recovery")
                    ]

                    for (cubeName, labelText) in zones {
                        if let zone = scene.findEntity(named: cubeName) {
                            if zone.findEntity(named: "Label_\(labelText)") == nil {
                                addReadableLabel(labelText, above: zone)
                            }
                        }
                    }
                }
            }
            .padding(.leading, 90)
        }

        // MARK: - Load immersive scene
        .task {
            do {
                _ = await openImmersiveSpace(id: "Immersive")
                if root == nil {
                    root = try await Entity(named: "Immersive", in: realityKitContentBundle)
                }
            } catch {
                print("Failed to load immersive scene: \(error)")
            }
        }

        // MARK: - Tap Handling
        .gesture(
            SpatialTapGesture()
                .targetedToAnyEntity()
                .onEnded { result in
                    handleTap(on: result.entity)
                }
        )
    }

    // MARK: - Handle Tap
    private func handleTap(on entity: Entity) {
        guard let zoneName = trainingZoneName(for: entity) else { return }

        Task {
            root = nil
            await dismissImmersiveSpace()

            NotificationCenter.default.post(
                name: .openAssessmentVolume,
                object: zoneName
            )
        }
    }

    // MARK: - Add floating label
    private func addReadableLabel(_ text: String, above entity: Entity) {
        let mesh = MeshResource.generateText(
            text,
            extrusionDepth: 0.002,
            font: .systemFont(ofSize: 0.06, weight: .semibold),
            containerFrame: .zero,
            alignment: .center
        )

        let labelEntity = ModelEntity(mesh: mesh, materials: [UnlitMaterial(color: .white)])
        labelEntity.position = SIMD3<Float>(0, 0.18, 0)
        labelEntity.name = "Label_\(text)"
        labelEntity.components.set(BillboardComponent())

        entity.addChild(labelEntity)
    }

    // MARK: - Zone Mapping
    private func trainingZoneName(for entity: Entity) -> String? {
        switch entity.name {
        case "Cube_003": return "Airway"
        case "Cube":     return "CPR"
        case "Cube_007": return "Recovery"
        default:         return nil
        }
    }

    // MARK: - Remove RCP Materials
    private func removeMaterials(_ entity: Entity?) {
        guard let entity else { return }

        if var model = entity.components[ModelComponent.self] {
            model.materials = []
            entity.components.set(model)
        }

        for child in entity.children {
            removeMaterials(child)
        }
    }
}

extension Notification.Name {
    static let openAssessmentVolume = Notification.Name("openAssessmentVolume")
}

#Preview {
    AssessmentImmersiveView()
}
