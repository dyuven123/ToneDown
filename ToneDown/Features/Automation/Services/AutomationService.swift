//
//  AutomationService.swift
//  ToneDown
//
//  Created by Dyuven on 10.08.2025.
//

import Foundation
import UIKit

// MARK: - Automation Service Protocol
protocol AutomationServiceProtocol {
    func importBaseEnableCommand() async throws
    func importBaseDisableCommand() async throws
    func openShortcutsApp() async throws
    func openAutomationsScreen() async throws
    func checkShortcutsAvailability() async -> Bool
}

// MARK: - Automation Service Implementation
class AutomationService: AutomationServiceProtocol {
    
    // MARK: - Constants
    private enum Constants {
        static let shortcutsURLScheme = "shortcuts://"
        static let shortcutsAppURL = "shortcuts://automation"
        static let shortcutsAppStoreID = "915249334" // ID приложения Shortcuts в App Store
    }
    
    // MARK: - Public Methods
    
    /// Импорт базовой команды для включения серого режима
    func importBaseEnableCommand() async throws {
        // Здесь будет логика импорта команды
        // Пока что просто симулируем успешный импорт
        try await Task.sleep(nanoseconds: 1_000_000_000) // 1 секунда
        
        // В реальной реализации здесь будет вызов Shortcuts API
        // или создание команды через URL scheme
    }
    
    /// Импорт базовой команды для выключения серого режима
    func importBaseDisableCommand() async throws {
        // Аналогично importBaseEnableCommand
        try await Task.sleep(nanoseconds: 1_000_000_000) // 1 секунда
    }
    
    /// Открытие приложения Shortcuts
    func openShortcutsApp() async throws {
        guard let url = URL(string: Constants.shortcutsURLScheme) else {
            throw AutomationError.shortcutsNotAvailable
        }
        
        if await UIApplication.shared.canOpenURL(url) {
            await UIApplication.shared.open(url)
        } else {
            // Fallback: открываем App Store
            if let appStoreURL = URL(string: "itms-apps://itunes.apple.com/app/id\(Constants.shortcutsAppStoreID)") {
                await UIApplication.shared.open(appStoreURL)
            } else {
                throw AutomationError.shortcutsNotAvailable
            }
        }
    }
    
    /// Открытие экрана автоматизаций в Shortcuts
    func openAutomationsScreen() async throws {
        guard let url = URL(string: Constants.shortcutsAppURL) else {
            throw AutomationError.shortcutsNotAvailable
        }
        
        if await UIApplication.shared.canOpenURL(url) {
            await UIApplication.shared.open(url)
        } else {
            // Fallback: открываем обычное приложение Shortcuts
            try await openShortcutsApp()
        }
    }
    
    /// Проверка доступности приложения Shortcuts
    func checkShortcutsAvailability() async -> Bool {
        guard let url = URL(string: Constants.shortcutsURLScheme) else {
            return false
        }
        
        return await UIApplication.shared.canOpenURL(url)
    }
}

// MARK: - Automation Error
// AutomationError определен в AutomationState.swift
