//
//  CommandState.swift
//  ToneDown
//
//  Created by Dyuven on 10.08.2025.
//

import Foundation

// MARK: - Command State для отслеживания состояния команд
struct CommandState: Codable {
    var enableCommandsCount: Int = 0
    var disableCommandsCount: Int = 0
    var lastCommandTimestamp: Date?
    var isGrayscaleEnabled: Bool = false
    var lastAutomationType: AutomationType?
    
    // Вычисляемое свойство для определения текущего состояния
    var effectiveState: GrayscaleState {
        if enableCommandsCount > disableCommandsCount {
            return .enabled
        } else if disableCommandsCount > enableCommandsCount {
            return .disabled
        } else {
            return .unknown
        }
    }
    
    // Проверка на конфликт команд
    var hasConflict: Bool {
        return enableCommandsCount > 0 && disableCommandsCount > 0
    }
    
    // Сброс счетчиков
    mutating func resetCounters() {
        enableCommandsCount = 0
        disableCommandsCount = 0
        lastCommandTimestamp = nil
        lastAutomationType = nil
    }
}

// MARK: - Grayscale State
enum GrayscaleState: String, CaseIterable, Codable {
    case enabled = "enabled"
    case disabled = "disabled"
    case unknown = "unknown"
    
    var localizedDescription: String {
        switch self {
        case .enabled:
            return "command.state.enabled"
        case .disabled:
            return "command.state.disabled"
        case .unknown:
            return "command.state.unknown"
        }
    }
}

// MARK: - Automation Type
enum AutomationType: String, CaseIterable, Codable {
    case focus = "focus"
    case location = "location"
    case schedule = "schedule"
    case manual = "manual"
    
    var localizedDescription: String {
        switch self {
        case .focus:
            return "automation.type.focus"
        case .location:
            return "automation.type.location"
        case .schedule:
            return "automation.type.schedule"
        case .manual:
            return "automation.type.manual"
        }
    }
}

// MARK: - Command Action
enum CommandAction: String, CaseIterable, Codable {
    case enable = "enable"
    case disable = "disable"
    case toggle = "toggle"
    
    var localizedDescription: String {
        switch self {
        case .enable:
            return "command.action.enable"
        case .disable:
            return "command.action.disable"
        case .toggle:
            return "command.action.toggle"
        }
    }
}
