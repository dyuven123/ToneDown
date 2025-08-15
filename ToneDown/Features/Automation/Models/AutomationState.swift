//
//  AutomationState.swift
//  ToneDown
//
//  Created by Dyuven on 10.08.2025.
//

import Foundation

// MARK: - Automation State
enum AutomationState {
    case idle
    case creatingCommands
    case commandsCreated
    case setupCompleted
    case error(String)
}

// MARK: - Automation Status
struct AutomationStatus {
    var hasCreatedBaseCommands: Bool
    var hasCompletedAutomationSetup: Bool
    var lastSetupDate: Date?
    var commandsCount: Int
}

// MARK: - Automation Error
enum AutomationError: LocalizedError {
    case shortcutsNotAvailable
    case commandCreationFailed
    case automationSetupFailed
    
    var errorDescription: String? {
        switch self {
        case .shortcutsNotAvailable:
            return "Приложение Команды недоступно"
        case .commandCreationFailed:
            return "Не удалось создать команды"
        case .automationSetupFailed:
            return "Не удалось настроить автоматизацию"
        }
    }
}

// MARK: - Extensions

extension AutomationStatus: Codable {
    // Codable conformance для сохранения в UserDefaults
}
