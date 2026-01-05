//
//  ReviveApp.swift
//  Revive
//
//  Created by ariana jansen on 05/01/2026.
//

import SwiftUI

@main
struct ReviveApp: App {

    @State private var appModel = AppModel()

    var body: some Scene {
        WindowGroup {
            MainTabView()
                .environment(appModel)
        }

        ImmersiveSpace(id: appModel.immersiveSpaceID) {
            ImmersiveView()
                .environment(appModel)
                .onAppear {
                    appModel.immersiveSpaceState = .open
                }
                .onDisappear {
                    appModel.immersiveSpaceState = .closed
                }
        }
        .immersionStyle(selection: .constant(.mixed), in: .mixed)
     }
}
