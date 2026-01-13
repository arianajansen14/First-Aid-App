//
//  TrainingStep.swift
//  Revive
//

import SwiftUI

struct TrainingStep: Identifiable {
    let id = UUID()
    let title: String
    let description: String
    
    /// Name of RealityKit scene (e.g. "cprhands", "cprhelp")
    let sceneName: String?
    
    /// Optional SwiftUI view (for illustrations/images)
    let customView: AnyView?
}
