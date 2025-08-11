//
//  ToneDownApp.swift
//  ToneDown
//
//  Created by Dyuven on 10.08.2025.
//  iOS 15.0+
//

import SwiftUI

@main
struct ToneDownApp: App {
    @StateObject private var appState = AppState()
    
    var body: some Scene {
        WindowGroup {
            Group {
                if appState.hasSeenOnboarding {
                    MainTabView()
                } else {
                    OnboardingView()
                }
            }
            .environmentObject(appState)
            .preferredColorScheme(nil) // поддерживаем и светлую, и тёмную
        }
    }
}
