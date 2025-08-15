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
    private var appState: AppState?
    
    // MARK: - Initialization
    init(appState: AppState? = nil) {
        self.appState = appState
        // Загружаем сохраненное состояние при инициализации
        loadAutomationStatus()
    }
    
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
        // Загружаем сохраненное состояние при инициализации
        loadAutomationStatus()
    }
    
    // MARK: - Public Methods
    
    /// Обновление AppState ссылки
    func updateAppState(_ appState: AppState) {
        self.appState = appState
        // Синхронизируем состояние после обновления AppState
        appState.syncAutomationState(
            hasCommands: automationStatus.hasCreatedBaseCommands,
            hasAutomation: automationStatus.hasCompletedAutomationSetup
        )
    }
    
    /// Проверка и обновление статуса команд
    func refreshCommandsStatus() async {
        // Просто обновляем состояние на основе сохраненных данных
        // Никаких сложных проверок не делаем
    }
    
    /// Импорт команды для включения серого режима
    func importEnableCommand() async {
        automationState = .creatingCommands
        
        do {
            try await ShortcutsRunner.importBaseEnableCommand()
            await updateCommandsStatus()
            automationState = .commandsCreated
            
            // Принудительно синхронизируем с AppState
            appState?.syncAutomationState(hasCommands: true, hasAutomation: false)
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
            
            // Принудительно синхронизируем с AppState
            appState?.syncAutomationState(hasCommands: true, hasAutomation: false)
        } catch {
            automationState = .error("Не удалось импортировать команду выключения: \(error.localizedDescription)")
        }
    }
    
    /// Подтверждение создания команд
    func confirmCommandsCreation() async {
        // Просто подтверждаем создание команд
        automationStatus.hasCreatedBaseCommands = true
        automationStatus.lastSetupDate = Date()
        saveAutomationStatus()
        automationState = .commandsCreated
        
                    // Принудительно синхронизируем с AppState
            appState?.syncAutomationState(hasCommands: true, hasAutomation: false)
    }
    
    /// Сброс команд
    func resetCommands() {
        automationStatus.hasCreatedBaseCommands = false
        automationStatus.hasCompletedAutomationSetup = false
        automationStatus.lastSetupDate = nil
        automationStatus.commandsCount = 0
        saveAutomationStatus()
        automationState = .idle
        
        // Принудительно синхронизируем с AppState
        appState?.syncAutomationState(hasCommands: false, hasAutomation: false)
    }
    
    /// Завершение настройки автоматизации
    func completeAutomationSetup() {
        automationStatus.hasCompletedAutomationSetup = true
        automationStatus.lastSetupDate = Date()
        saveAutomationStatus()
        automationState = .setupCompleted
        
        // Принудительно синхронизируем с AppState
        appState?.syncAutomationState(hasCommands: true, hasAutomation: true)
    }
    
    // MARK: - Private Methods
    
    private func loadAutomationStatus() {
        // Загружаем статус из UserDefaults или другого хранилища
        if let data = UserDefaults.standard.data(forKey: "automationStatus"),
           let status = try? JSONDecoder().decode(AutomationStatus.self, from: data) {
            automationStatus = status
        }
        
        // Синхронизируем с AppState
        appState?.syncAutomationState(
            hasCommands: automationStatus.hasCreatedBaseCommands,
            hasAutomation: automationStatus.hasCompletedAutomationSetup
        )
        
        // Определяем текущее состояние
        if automationStatus.hasCompletedAutomationSetup {
            automationState = .setupCompleted
        } else if automationStatus.hasCreatedBaseCommands {
            automationState = .commandsCreated
        } else {
            automationState = .idle
        }
    }
    
    // Упрощенная проверка - просто возвращаем сохраненное состояние
    private func verifyCommandsExistence() async {
        // Ничего не делаем - просто доверяем сохраненному состоянию
        // Если пользователь удалил команды, он может нажать "Пересоздать команды"
    }
    
    private func saveAutomationStatus() {
        if let data = try? JSONEncoder().encode(automationStatus) {
            UserDefaults.standard.set(data, forKey: "automationStatus")
        }
        
        // Синхронизируем с AppState
        appState?.syncAutomationState(
            hasCommands: automationStatus.hasCreatedBaseCommands,
            hasAutomation: automationStatus.hasCompletedAutomationSetup
        )
    }
    
    private func updateCommandsStatus() async {
        // Обновляем количество команд (можно добавить логику проверки)
        automationStatus.commandsCount = 2 // Включение + выключение
        saveAutomationStatus()
    }
}


