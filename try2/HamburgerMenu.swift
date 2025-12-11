//
//  HamburgerMenu.swift
//  try2
//
//  Created by ariana jansen on 04/12/2025.
//

import SwiftUI

struct HamburgerMenu: View {

    @State private var expanded = false

    var body: some View {
        VStack {
            HStack {
                Spacer()

                // --- Compact Chrome Pill ---
                Button {
                    withAnimation(.spring(response: 0.25, dampingFraction: 0.8)) {
                        expanded.toggle()
                    }
                } label: {
                    Image(systemName: "ellipsis")
                        .font(.system(size: 20, weight: .semibold))
                        .padding(.vertical, 10)
                        .padding(.horizontal, 16)
                        .background(.ultraThinMaterial, in: Capsule())
                        .shadow(radius: 4, y: 2)
                }
                .padding(.top, 20)
                .padding(.trailing, 20)
            }

            // --- Expanded Menu ---
            if expanded {
                VStack(alignment: .leading, spacing: 14) {

                    chromeItem("Main Menu") {
                        NotificationCenter.default.post(name: .openMainMenu, object: nil)
                        collapse()
                    }

                    chromeItem("Settings") {
                        NotificationCenter.default.post(name: .openSettings, object: nil)
                        collapse()
                    }

                    chromeItem("Help") {
                        NotificationCenter.default.post(name: .openHelp, object: nil)
                        collapse()
                    }

                    Divider().opacity(0.4)

                    chromeItem("Save & Quit") {
                        NotificationCenter.default.post(name: .quitApp, object: nil)
                        collapse()
                    }

                }
                .padding(18)
                .frame(width: 220)
                .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 22))
                .shadow(radius: 10, y: 4)
                .transition(.move(edge: .top).combined(with: .opacity))
                .padding(.trailing, 20)
            }

            Spacer()
        }
    }

    // MARK: - Chrome Menu Item
    private func chromeItem(_ title: String, action: @escaping () -> Void) -> some View {
        Button {
            action()
        } label: {
            Text(title)
                .font(.system(size: 18, weight: .regular))
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .buttonStyle(.plain)
    }

    private func collapse() {
        withAnimation(.spring(response: 0.25, dampingFraction: 0.8)) {
            expanded = false
        }
    }
}


// MARK: - Notifications used by other views
extension Notification.Name {
    static let openMainMenu = Notification.Name("openMainMenu")
    static let openSettings = Notification.Name("openSettings")
    static let openHelp = Notification.Name("openHelp")
    static let quitApp = Notification.Name("quitApp")
}
