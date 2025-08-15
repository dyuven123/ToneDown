//
//  AutomationViewModel.swift
//  ToneDown
//
//  Created by Dyuven on 10.08.2025.
//

import SwiftUI
import Combine

// MARK: - Automation ViewModel
@MainActor
class AutomationViewModel: ObservableObject {
    // MARK: - Published Properties
    @Published var automationState: AutomationState = .idle
    @Published var automationStatus = AutomationStatus(
        hasCreatedBaseCommands: false,
        hasCompletedAutomationSetup: false,
        lastSetupDate: nil,
        commandsCount: 0
    )
    
    // MARK: - Private Properties
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Computed Properties
    var hasCreatedBaseCommands: Bool {
        automationStatus.hasCreatedBaseCommands
    }
    
    var hasCompletedAutomationSetup: Bool {
        automationStatus.hasCompletedAutomationSetup
    }
    
    var canSetupAutomation: Bool {
        hasCreatedBaseCommands && !hasCompletedAutomationSetup
    }
    
    // MARK: - Initialization
    init() {
        loadAutomationStatus()
    }
    
    // MARK: - Public Methods
    
    /// Импорт команды для включения серого режима
    func importEnableCommand() async {
        automationState = .creatingCommands
        
        do {
            try await ShortcutsRunner.importBaseEnableCommand()
            await updateCommandsStatus()
            automationState = .commandsCreated
        } catch {
            automationState = .error("Не удалось импортировать команду включения: \(error.localizedDescription)")
        }
    }
    
    /// Импорт команды для выключения серого режима
    func importDisableCommand() async {
        automationState = .creatingCommands
        
        do {
            try await ShortcutsRunner.importBaseDisableCommand()
            await updateCommandsStatus()
            automationState = .commandsCreated
        } catch {
            automationState = .error("Не удалось импортировать команду выключения: \(error.localizedDescription)")
        }
    }
    
    /// Подтверждение создания команд
    func confirmCommandsCreation() {
        automationStatus.hasCreatedBaseCommands = true
        automationStatus.lastSetupDate = Date()
        saveAutomationStatus()
        automationState = .commandsCreated
    }
    
    /// Сброс команд
    func resetCommands() {
        automationStatus.hasCreatedBaseCommands = false
        automationStatus.hasCompletedAutomationSetup = false
        automationStatus.lastSetupDate = nil
        automationStatus.commandsCount = 0
        saveAutomationStatus()
        automationState = .idle
    }
    
    /// Завершение настройки автоматизации
    func completeAutomationSetup() {
        automationStatus.hasCompletedAutomationSetup = true
        automationStatus.lastSetupDate = Date()
        saveAutomationStatus()
        automationState = .setupCompleted
    }
    
    // MARK: - Private Methods
    
    private func loadAutomationStatus() {
        // Загружаем статус из UserDefaults или другого хранилища
        if let data = UserDefaults.standard.data(forKey: "automationStatus"),
           let status = try? JSONDecoder().decode(AutomationStatus.self, from: data) {
            automationStatus = status
        }
        
        // Определяем текущее состояние
        if automationStatus.hasCompletedAutomationSetup {
            automationState = .setupCompleted
        } else if automationStatus.hasCreatedBaseCommands {
            automationState = .commandsCreated
        } else {
            automationState = .idle
        }
    }
    
    private func saveAutomationStatus() {
        if let data = try? JSONEncoder().encode(automationStatus) {
            UserDefaults.standard.set(data, forKey: "automationStatus")
        }
    }
    
    private func updateCommandsStatus() async {
        // Обновляем количество команд (можно добавить логику проверки)
        automationStatus.commandsCount = 2 // Включение + выключение
        saveAutomationStatus()
    }
}


