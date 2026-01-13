//
//  AppModel.swift
//  Revive
//

import SwiftUI

@Observable
class AppModel {

    // ============================================================
    // MODEL WINDOW STATE
    // ============================================================

    /// Unique window ID
    let modelWindowID = "AssessmentModelWindow"

    /// Whether the model window should be visible
    var isModelVisible: Bool = false

    /// Toggle and request opening
    func showModelWindow() {
        isModelVisible = true
    }

    func hideModelWindow() {
        isModelVisible = false
    }

    // ============================================================
    // IMMERSIVE SPACE STATE
    // ============================================================

    let immersiveSpaceID = "ImmersiveSpace"

    enum ImmersiveState { case closed, open }
    var immersiveSpaceState: ImmersiveState = .closed
}
