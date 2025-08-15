//
//  AppState.swift
//  ToneDown
//
//  Created by Dyuven on 10.08.2025.
//

import SwiftUI

// MARK: - AppState для управления состоянием приложения
class AppState: ObservableObject {
    @AppStorage("hasSeenOnboarding") var hasSeenOnboarding: Bool = false
    @AppStorage("hasCompletedSetup") var hasCompletedSetup: Bool = false
    @AppStorage("hasPremium") var hasPremium: Bool = false
    @AppStorage("hasCompletedAutomationSetup") var hasCompletedAutomationSetup: Bool = false
    @AppStorage("hasCreatedBaseCommands") var hasCreatedBaseCommands: Bool = false
    
    func completeOnboarding() {
        hasSeenOnboarding = true
    }
    
    func completeSetup() {
        hasCompletedSetup = true
    }
    
    func purchasePremium() {
        hasPremium = true
    }
    
    func completeAutomationSetup() {
        hasCompletedAutomationSetup = true
    }
    
    func completeBaseCommandsCreation() {
        hasCreatedBaseCommands = true
    }
    
    func resetBaseCommands() {
        hasCreatedBaseCommands = false
    }
}
