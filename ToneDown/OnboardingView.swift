//
//  OnboardingView.swift
//  ToneDown
//
//  Created by Dyuven on 10.08.2025.
//

import SwiftUI

struct OnboardingView: View {
    @EnvironmentObject var appState: AppState
    @State private var currentPage = 0
    @State private var isPressed = false
    
    let pages = [
        OnboardingPage(
            emoji: "📱",
            title: "Добро пожаловать в ToneDown",
            description: "Приложение, которое поможет сделать твоё время в телефоне более осознанным"
        ),
        OnboardingPage(
            emoji: "🎨",
            title: "Убери яркие цвета",
            description: "Одно нажатие и Instagram, TikTok, YouTube станут менее \"вкусными\" в чёрно-белом режиме"
        ),
        OnboardingPage(
            emoji: "🧠",
            title: "Осознанное использование",
            description: "Серые тона снижают визуальную привлекательность и помогают тратить меньше времени в лентах"
        ),
        OnboardingPage(
            emoji: "⚡",
            title: "Мгновенное переключение",
            description: "Быстро включай и выключай режим в зависимости от ситуации"
        )
    ]
    
    var body: some View {
        VStack(spacing: 0) {
            // Progress indicator
            HStack(spacing: 8) {
                ForEach(0..<pages.count, id: \.self) { index in
                    Capsule()
                        .fill(index <= currentPage ? DS.Color.accent : Color.gray.opacity(0.3))
                        .frame(width: index == currentPage ? 24 : 8, height: 4)
                        .animation(.spring(response: 0.3), value: currentPage)
                }
            }
            .padding(.top, 20)
            .padding(.horizontal, 20)
            
            Spacer()
            
            // Page content
            TabView(selection: $currentPage) {
                ForEach(0..<pages.count, id: \.self) { index in
                    OnboardingPageView(page: pages[index])
                        .tag(index)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .frame(maxHeight: .infinity)
            
            // Navigation buttons
            VStack(spacing: 16) {
                if currentPage < pages.count - 1 {
                    Button {
                        withAnimation(.spring()) {
                            currentPage += 1
                        }
                        UIImpactFeedbackGenerator(style: .light).impactOccurred()
                    } label: {
                        Text("Продолжить")
                            .font(DS.Typo.button)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 16)
                            .background(DS.Color.accent)
                            .foregroundColor(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                    }
                    .scaleEffect(isPressed ? 0.98 : 1.0)
                    .animation(.spring(response: 0.2), value: isPressed)
                } else {
                    Button {
                        appState.completeOnboarding()
                        UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                    } label: {
                        Text("Начать пользоваться")
                            .font(DS.Typo.button)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 16)
                            .background(DS.Color.accent)
                            .foregroundColor(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                    }
                    .scaleEffect(isPressed ? 0.98 : 1.0)
                    .animation(.spring(response: 0.2), value: isPressed)
                }
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 34)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(appBackground.ignoresSafeArea())
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
            // Скрыть индикаторы страниц при возврате в приложение
        }
    }
    
    // MARK: - Dynamic colors
    private var appBackground: Color {
        Color(uiColor: .init { trait in
            trait.userInterfaceStyle == .dark
            ? UIColor(DS.Color.backgroundDark)
            : UIColor(DS.Color.backgroundLight)
        })
    }
}

// MARK: - OnboardingPageView
struct OnboardingPageView: View {
    let page: OnboardingPage
    
    var body: some View {
        VStack(spacing: 32) {
            Text(page.emoji)
                .font(.system(size: 80))
                .padding(.top, 20)
            
            VStack(spacing: 16) {
                Text(page.title)
                    .font(DS.Typo.title)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 20)
                
                Text(page.description)
                    .font(.body)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 32)
                    .lineLimit(nil)
            }
            
            Spacer()
        }
    }
}

// MARK: - OnboardingPage Model
struct OnboardingPage {
    let emoji: String
    let title: String
    let description: String
}

// MARK: - Preview
#Preview {
    OnboardingView()
        .environmentObject(AppState())
}
