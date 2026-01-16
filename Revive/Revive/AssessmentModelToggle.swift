//
//  AssessmentModelToggle.swift
//  Revive
//
//  Created by ariana jansen on 10/01/2026.
//


import SwiftUI

struct AssessmentModelToggle: View {
    @Environment(AppModel.self) private var appModel
    @Environment(\.openWindow) private var openWindow
    @Environment(\.dismissWindow) private var dismissWindow

    var body: some View {
        @Bindable var appModel = appModel

        Toggle("Show Model", isOn: $appModel.isModelVisible)
            .onChange(of: appModel.isModelVisible) { _, isShowing in
                if isShowing {
                    openWindow(id: appModel.modelWindowID)
                } else {
                    dismissWindow(id: appModel.modelWindowID)
                }
            }
            .toggleStyle(.button)
    }
}
