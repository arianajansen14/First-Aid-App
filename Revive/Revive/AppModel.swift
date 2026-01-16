//  AppModel.swift

import SwiftUI

@Observable
class AppModel {

    // volumetric assessment window
    let modelWindowID = "AssessmentModelWindow"
    var isModelVisible: Bool = false

    func showModelWindow() { isModelVisible = true }
    func hideModelWindow() { isModelVisible = false }

    // immersive space
    let immersiveSpaceID = "ImmersiveSpace"
    enum ImmersiveState { case closed, open }
    var immersiveSpaceState: ImmersiveState = .closed

    // current immersive scene to load
    var pendingScene: String = "TrainingScene"

    func requestScene(_ name: String) {
        print("🌐 Loading immersive scene:", name)
        pendingScene = name
    }

    // immersive helpers called by the button

    func openImmersiveSpace() {
        immersiveSpaceState = .open
        print("🟢 Immersive space opened")
    }

    func closeImmersiveSpace() {
        immersiveSpaceState = .closed
        print("🔴 Immersive space closed")
    }

    func loadScene(_ name: String) {
        requestScene(name)
    }
}
