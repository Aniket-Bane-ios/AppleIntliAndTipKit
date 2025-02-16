//
//  AppleIntelligenceApp.swift
//  AppleIntelligence
//
//  Created by Aniket Bane on 15/02/25.
//

import SwiftUI
import TipKit

@main
struct AppleIntelligenceApp: App {
    var body: some Scene {
        WindowGroup {
            DashBoardView()
                .task {
                    try? Tips.resetDatastore()
                    try? Tips
                        .configure(
                            [
                                .datastoreLocation(.applicationDefault),
                                .displayFrequency(.immediate)
                            ]
                        )
                }
        }
    }
}
