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

    /// Volume Window ID used in ReviveApp
    let modelWindowID = "AssessmentModelWindow"

    /// Whether model window should be visible
    var isModelVisible: Bool = false


    // Toggle on/off (called by the Show Model button)
    func toggleModel() {
        isModelVisible.toggle()
    }


    // ============================================================
    // IMMERSIVE SPACE STATE
    // ============================================================

    let immersiveSpaceID = "ImmersiveSpace"

    enum ImmersiveState { case closed, open }
    var immersiveSpaceState: ImmersiveState = .closed
}
