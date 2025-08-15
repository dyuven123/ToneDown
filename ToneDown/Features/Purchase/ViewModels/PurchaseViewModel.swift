//
//  PurchaseViewModel.swift
//  ToneDown
//
//  Created by Dyuven on 10.08.2025.
//

import SwiftUI
import Combine
import StoreKit

// MARK: - Purchase ViewModel
@MainActor
class PurchaseViewModel: ObservableObject {
    // MARK: - Published Properties
    @Published var isPurchasing = false
    @Published var purchaseError: String?
    @Published var showError = false
    
    // MARK: - Dependencies
    private let appState: AppState
    private let purchaseService: PurchaseServiceProtocol
    
    // MARK: - Constants
    let premiumPrice = "999₽"
    let premiumFeatures = [
        PurchaseFeatureModel(
            icon: "clock.fill",
            title: "Автоматическое расписание",
            description: "Включение/выключения по времени"
        ),
        PurchaseFeatureModel(
            icon: "apps.iphone",
            title: "Smart триггеры приложений",
            description: "Автоматика для TikTok, Instagram и других"
        ),
        PurchaseFeatureModel(
            icon: "moon.zzz.fill",
            title: "Focus режимы",
            description: "Интеграция с режимами концентрации"
        ),
        PurchaseFeatureModel(
            icon: "location.fill",
            title: "Геолокация",
            description: "Автоматизация по местоположению"
        )
    ]
    
    // MARK: - Computed Properties
    var hasPremium: Bool {
        appState.hasPremium
    }
    
    var canPurchase: Bool {
        !hasPremium && !isPurchasing
    }
    
    var purchaseButtonTitle: String {
        if isPurchasing {
            return "Покупка..."
        } else if hasPremium {
            return "Уже куплено"
        } else {
            return "✨ Купить за \(premiumPrice)"
        }
    }
    
    var purchaseButtonColor: Color {
        if hasPremium {
            return .green
        } else {
            return DS.Color.accent
        }
    }
    
    // MARK: - Initialization
    init(appState: AppState, purchaseService: PurchaseServiceProtocol) {
        self.appState = appState
        self.purchaseService = purchaseService
    }

    /// Выполнение покупки Premium
    func purchasePremium() async {
        guard canPurchase else { return }
        
        isPurchasing = true
        purchaseError = nil
        
        do {
            try await purchaseService.purchasePremium()
            appState.purchasePremium()
            
            // Успешная покупка
            await MainActor.run {
                isPurchasing = false
            }
        } catch {
            // Ошибка покупки
            await MainActor.run {
                isPurchasing = false
                purchaseError = error.localizedDescription
                showError = true
            }
        }
    }
    
    /// Восстановление покупок
    func restorePurchases() async {
        do {
            try await purchaseService.restorePurchases()
            // Проверяем, есть ли активные покупки
            if purchaseService.hasActivePremiumSubscription() {
                appState.purchasePremium()
            }
        } catch {
            await MainActor.run {
                purchaseError = "Не удалось восстановить покупки: \(error.localizedDescription)"
                showError = true
            }
        }
    }
    
    /// Проверка статуса покупки
    func checkPurchaseStatus() async {
        if purchaseService.hasActivePremiumSubscription() {
            appState.purchasePremium()
        }
    }
    
    /// Скрыть ошибку
    func hideError() {
        showError = false
        purchaseError = nil
    }
}

// MARK: - Purchase Feature Model
struct PurchaseFeatureModel {
    let icon: String
    let title: String
    let description: String
}

// MARK: - Purchase Service Protocol
protocol PurchaseServiceProtocol {
    func purchasePremium() async throws
    func restorePurchases() async throws
    func hasActivePremiumSubscription() -> Bool
}

// MARK: - Purchase Service Implementation
class PurchaseService: PurchaseServiceProtocol {
    func purchasePremium() async throws {
        // Здесь будет интеграция с StoreKit
        // Пока что просто симулируем покупку
        try await Task.sleep(nanoseconds: 2_000_000_000) // 2 секунды
        
        // В реальной реализации здесь будет:
        // 1. Запрос к StoreKit
        // 2. Обработка транзакции
        // 3. Валидация покупки
        // 4. Сохранение статуса
    }
    
    func restorePurchases() async throws {
        // Восстановление покупок через StoreKit
        try await Task.sleep(nanoseconds: 1_000_000_000) // 1 секунда
    }
    
    func hasActivePremiumSubscription() -> Bool {
        // Проверка активной подписки
        // В реальной реализации здесь будет проверка через StoreKit
        return false
    }
}
