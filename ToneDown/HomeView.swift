//
//  HomeView.swift
//  ToneDown
//
//  Created by Dyuven on 10.08.2025.
//

import SwiftUI

struct HomeView: View {
    @State private var isPressed = false
    @State private var showSetup = false

    var body: some View {
        NavigationView {
            VStack(spacing: 28) {
                // Header
                VStack(spacing: 8) {
                    Text("ToneDown")
                        .font(DS.Typo.title)
                        .foregroundColor(Color.primary)
                        .accessibilityAddTraits(.isHeader)

                    Text("Сделай ленты менее «вкусными» одним тапом")
                        .font(DS.Typo.subtitle)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 24)
                        .accessibilityLabel("Описание: сделать ленты менее привлекательными одним нажатием")
                }

                Spacer(minLength: 16)

                // Big round button
                Button {
                    ShortcutsRunner.runShortcut(named: "Toggle Grayscale")
                    UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                } label: {
                    ZStack {
                        Circle()
                            .fill(cardBackground)
                            .frame(width: 280, height: 280)
                            .shadow(color: DS.Shadow.soft, radius: 24, x: 0, y: 8)

                        VStack(spacing: 8) {
                            Text("ON / OFF Grayscale")
                                .font(.title2).bold()
                            Text("жмякни, чтобы переключить")
                                .foregroundColor(.secondary)
                                .font(.callout)
                        }
                        .padding(.horizontal, 16)
                        .multilineTextAlignment(.center)
                    }
                    .scaleEffect(isPressed ? 0.98 : 1.0)
                    .animation(.spring(response: 0.2, dampingFraction: 0.7), value: isPressed)
                }
                .buttonStyle(.plain)
                .simultaneousGesture(DragGesture(minimumDistance: 0).onChanged { _ in
                    if !isPressed { isPressed = true }
                }.onEnded { _ in
                    isPressed = false
                })
                .accessibilityLabel("Переключить режим оттенков серого")
                .accessibilityHint("Открывает ярлык Toggle Grayscale в Командах")

                Spacer()

                // Setup button
                Button {
                    showSetup = true
                } label: {
                    Text("⚙️ Настроить")
                        .font(DS.Typo.button)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .background(DS.Color.accent)
                        .foregroundColor(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                }
                .padding(.horizontal, 20)
                .accessibilityLabel("Открыть экран настройки")

                Text("Работает через ярлык «Переключить светофильтры» в Командах")
                    .font(DS.Typo.caption)
                    .foregroundColor(.secondary)
                    .padding(.bottom, 12)

            }
            .padding(.top, 24)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(appBackground.ignoresSafeArea())
            .sheet(isPresented: $showSetup) {
                SetupView()
            }
        }
        .navigationViewStyle(.stack)
    }

    // MARK: - Dynamic colors
    private var appBackground: Color {
        Color(uiColor: .init { trait in
            trait.userInterfaceStyle == .dark
            ? UIColor(DS.Color.backgroundDark)
            : UIColor(DS.Color.backgroundLight)
        })
    }

    private var cardBackground: Color {
        Color(uiColor: .init { trait in
            trait.userInterfaceStyle == .dark
            ? UIColor(DS.Color.cardDark)
            : UIColor(DS.Color.card)
        })
    }
}

#Preview {
    HomeView()
}
