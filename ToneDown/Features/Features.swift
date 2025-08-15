//
//  Features.swift
//  ToneDown
//
//  Created by Dyuven on 10.08.2025.
//

import SwiftUI

// MARK: - Features Module
// Этот файл содержит импорты для всех фич приложения

// Automation Feature
struct AutomationFeature {
    static let automationView = AutomationView.self
    static let appTriggersSetupView = AppTriggersSetupView.self
    static let detailedInstructionsView = DetailedInstructionsView.self
    static let automationContent = AutomationContent.self
}

// Home Feature
struct HomeFeature {
    static let homeView = HomeView.self
    static let mainTabView = MainTabView.self
}

// Onboarding Feature
struct OnboardingFeature {
    static let onboardingView = OnboardingView.self
}

// Purchase Feature
struct PurchaseFeatureModule {
    static let purchaseView = PurchaseView.self
}

// Setup Feature
struct SetupFeature {
    static let setupView = SetupView.self
}

// Demo Feature
struct DemoFeature {
    static let demoView = DemoView.self
}
