//
//  AppModel.swift
//  try2
//
//  Created by Ariana Jansen on 28/11/2025.
//

import SwiftUI
import Observation

/// Global app state shared across all views
@MainActor
@Observable
class AppModel {

    // MARK: - Navigation
    enum Screen {
        case home
        case training
        case assessment
        case genniCustomisation
        case help
        case settings
    }

    /// Which part of the app the user is currently in
    var currentScreen: Screen = .home

    /// Shows the left navigation bar (hidden only on Home window)
    var showLeftNavBar: Bool = false


    // MARK: - Immersive Space
    let immersiveSpaceID = "ImmersiveSpace"

    enum ImmersiveSpaceState {
        case closed
        case inTransition
        case open
    }

    var immersiveSpaceState = ImmersiveSpaceState.closed


    // MARK: - Training Progress
    /// Keeps track of completed topics (CPR, Airway, Recovery)
    var completedTraining: Set<String> = []


    // MARK: - Assessment
    /// The currently active exam: "CPR", "Airway", "Recovery"
    var activeAssessmentTopic: String? = nil

    /// Attempts and scores recorded per topic
    var lastScores: [String : Int] = [:]
    var assessmentAttemptsByTopic: [String : Int] = [:]

    /// Convenience function to open an exam
    func openAssessment(_ topic: String) {
        activeAssessmentTopic = topic
        currentScreen = .assessment
    }


    // MARK: - Save & Quit
    func saveState() {
        print("Saving app state…") // will be persistent later
    }

    func resetToHome() {
        currentScreen = .home
        showLeftNavBar = false
    }
}
