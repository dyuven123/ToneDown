//
//  OnboardingViewModel.swift
//  ToneDown
//
//  Created by Dyuven on 10.08.2025.
//

import SwiftUI
import Combine

// MARK: - Onboarding ViewModel
@MainActor
class OnboardingViewModel: ObservableObject {
    // MARK: - Published Properties
    @Published var currentPage = 0
    @Published var isButtonPressed = false
    
    // MARK: - Dependencies
    private let appState: AppState
    
    // MARK: - Constants
    let pages = [
        OnboardingPage(
            emoji: "📱",
            title: "onboarding.page1.title",
            description: "onboarding.page1.description"
        ),
        OnboardingPage(
            emoji: "🎨",
            title: "onboarding.page2.title",
            description: "onboarding.page2.description"
        ),
        OnboardingPage(
            emoji: "🧠",
            title: "onboarding.page3.title",
            description: "onboarding.page3.description"
        ),
        OnboardingPage(
            emoji: "⚡",
            title: "onboarding.page4.title",
            description: "onboarding.page4.description"
        )
    ]
    
    // MARK: - Computed Properties
    var totalPages: Int {
        pages.count
    }
    
    var isLastPage: Bool {
        currentPage == totalPages - 1
    }
    
    var canGoNext: Bool {
        currentPage < totalPages - 1
    }
    
    var progress: Double {
        Double(currentPage + 1) / Double(totalPages)
    }
    
    var buttonTitle: String {
        isLastPage ? "onboarding.button.start" : "onboarding.button.next"
    }
    
    var currentPageData: OnboardingPage {
        pages[currentPage]
    }
    
    // MARK: - Initialization
    init(appState: AppState) {
        self.appState = appState
    }
    
    // MARK: - Public Methods
    
    /// Переход к следующей странице
    func nextPage() {
        guard canGoNext else { return }
        
        withAnimation(.spring()) {
            currentPage += 1
        }
        
        // Haptic feedback
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
    }
    
    /// Завершение онбординга
    func completeOnboarding() {
        appState.completeOnboarding()
        
        // Haptic feedback
        UIImpactFeedbackGenerator(style: .medium).impactOccurred()
    }
    
    /// Переход к конкретной странице
    func goToPage(_ page: Int) {
        guard page >= 0 && page < totalPages else { return }
        
        withAnimation(.spring()) {
            currentPage = page
        }
    }
    
    /// Сброс к первой странице
    func resetToFirstPage() {
        withAnimation(.spring()) {
            currentPage = 0
        }
    }
    
    /// Обработка нажатия на кнопку
    func onButtonPress() {
        isButtonPressed = true
    }
    
    /// Обработка отпускания кнопки
    func onButtonRelease() {
        isButtonPressed = false
    }
    
    /// Обработка свайпа
    func handleSwipe(_ direction: SwipeDirection) {
        switch direction {
        case .left:
            nextPage()
        case .right:
            if currentPage > 0 {
                goToPage(currentPage - 1)
            }
        }
    }
}

// MARK: - Onboarding Page Model
struct OnboardingPage {
    let emoji: String
    let title: String
    let description: String
}

// MARK: - Swipe Direction
enum SwipeDirection {
    case left
    case right
}
