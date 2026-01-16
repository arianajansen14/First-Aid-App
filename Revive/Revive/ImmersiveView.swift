import SwiftUI
import RealityKit
import RealityKitContent

struct ImmersiveView: View {

    @Environment(AppModel.self) private var model
    @State private var root = Entity()

    var body: some View {
        RealityView { content in
            if root.parent == nil {
                content.add(root)
            }
        }
        .task {
            await loadScene(model.pendingScene)
        }
        .onChange(of: model.pendingScene) { _, newScene in
            Task { await loadScene(newScene) }
        }
    }

    private func loadScene(_ name: String) async {
        root.children.removeAll()

        guard let scene = try? await Entity.load(named: name,
                                                 in: realityKitContentBundle)
        else {
            print("❌ Failed to load immersive scene:", name)
            return
        }

        root.addChild(scene.clone(recursive: true))
    }
}
