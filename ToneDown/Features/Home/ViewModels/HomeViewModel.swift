//
//  HomeViewModel.swift
//  ToneDown
//
//  Created by Dyuven on 10.08.2025.
//

import SwiftUI
import Combine

// MARK: - Home ViewModel
@MainActor
class HomeViewModel: ObservableObject {
    // MARK: - Published Properties
    @Published var isButtonPressed = false
    @Published var showSetup = false
    @Published var showDemo = false
    @Published var showPurchase = false
    
    // MARK: - Dependencies
    private let appState: AppState
    
    // MARK: - Computed Properties
    var hasCompletedSetup: Bool {
        appState.hasCompletedSetup
    }
    
    var hasPremium: Bool {
        appState.hasPremium
    }
    
    var shouldShowPremiumBlock: Bool {
        hasCompletedSetup && !hasPremium
    }
    
    var buttonTitle: String {
        hasCompletedSetup ? "Включить серый режим" : "Настроить"
    }
    
    var buttonSubtitle: String {
        hasCompletedSetup ? "Нажмите для переключения" : "Добавить команды"
    }
    
    var buttonIcon: String {
        hasCompletedSetup ? "eye.slash.fill" : "⚙️"
    }
    
    // MARK: - Initialization
    init(appState: AppState) {
        self.appState = appState
    }
    
    // MARK: - Public Methods
    
    /// Обработка нажатия на главную кнопку
    func handleMainButtonTap() {
        if hasCompletedSetup {
            toggleGrayscale()
        } else {
            showSetup = true
        }
        
        // Haptic feedback
        UIImpactFeedbackGenerator(style: .medium).impactOccurred()
    }
    
    /// Переключение серого режима
    func toggleGrayscale() {
        ShortcutsRunner.runShortcut(named: "Toggle Grayscale")
    }
    
    /// Показать экран настройки
    func showSetupScreen() {
        showSetup = true
    }
    
    /// Скрыть экран настройки
    func hideSetupScreen() {
        showSetup = false
    }
    
    /// Показать демо
    func showDemoScreen() {
        showDemo = true
    }
    
    /// Скрыть демо
    func hideDemoScreen() {
        showDemo = false
    }
    
    /// Показать экран покупки Premium
    func showPurchaseScreen() {
        showPurchase = true
    }
    
    /// Скрыть экран покупки Premium
    func hidePurchaseScreen() {
        showPurchase = false
    }
    
    /// Обработка нажатия на кнопку
    func onButtonPress() {
        isButtonPressed = true
    }
    
    /// Обработка отпускания кнопки
    func onButtonRelease() {
        isButtonPressed = false
    }
}

// MARK: - Shortcuts Service Protocol
// ShortcutsServiceProtocol и ShortcutsService определены в ShortcutsRunner.swift
