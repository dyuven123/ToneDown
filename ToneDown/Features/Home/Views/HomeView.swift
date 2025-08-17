//
//  HomeView.swift
//  ToneDown
//
//  Created by Dyuven on 10.08.2025.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var appState: AppState
    @State private var isPressed = false
    @State private var showSetup = false
    @State private var showDemo = false

    var body: some View {
        NavigationView {
            VStack(spacing: 28) {
                // Header
                VStack(spacing: 8) {
                    Text(L10n.Home.title)
                        .font(DS.Typo.title)
                        .foregroundColor(Color.primary)
                        .accessibilityAddTraits(.isHeader)

                    Text(L10n.Home.subtitle)
                        .font(DS.Typo.subtitle)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 24)
                        .accessibilityLabel(L10n.Accessibility.description)
                }

                Spacer(minLength: 16)

                // Big round button
                Button {
                    if appState.hasCompletedSetup {
                        ShortcutsRunner.runShortcut(named: "Toggle Grayscale")
                    } else {
                        showSetup = true
                    }
                    UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                } label: {
                    ZStack {
                        Circle()
                            .fill(cardBackground)
                            .frame(width: 280, height: 280)
                            .shadow(color: DS.Shadow.soft, radius: 24, x: 0, y: 8)

                        VStack(spacing: 12) {
                            if appState.hasCompletedSetup {
                                Text(LocalizedStringKey("home.button.enable.grayscale"))
                                    .font(.title2).bold()
                                    .lineLimit(2)
                                Text(LocalizedStringKey("home.button.tap.to.toggle"))
                                    .foregroundColor(.secondary)
                                    .font(.callout)
                                    .lineLimit(1)
                            } else {
                                Text("⚙️")
                                    .font(.system(size: 64))
                                Text(LocalizedStringKey("home.button.setup"))
                                    .font(.title2).bold()
                                    .lineLimit(1)
                                Text(LocalizedStringKey("home.button.add.commands"))
                                    .foregroundColor(.secondary)
                                    .font(.callout)
                                    .lineLimit(2)
                            }
                        }
                        .padding(.horizontal, 20)
                        .padding(.vertical, 16)
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
                .accessibilityLabel(appState.hasCompletedSetup ? L10n.Accessibility.MainButton.toggle : L10n.Accessibility.MainButton.setup)
                .accessibilityHint(appState.hasCompletedSetup ? L10n.Accessibility.Hint.toggle : L10n.Accessibility.Hint.setup)

                Spacer()
                
                // comment.premium.demo.block
                if appState.hasCompletedSetup && !appState.hasPremium {
                    VStack(spacing: 16) {
                        Text(L10n.Premium.title)
                            .font(.subheadline.weight(.medium))
                        
                        HStack(spacing: 12) {
                            Button {
                                showDemo = true
                            } label: {
                                Text(L10n.Premium.Button.demo)
                                    .font(.subheadline.weight(.medium))
                                .padding(.horizontal, 16)
                                .padding(.vertical, 10)
                                .background(DS.Color.accent.opacity(0.1))
                                .foregroundColor(DS.Color.accent)
                                .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                            }
                            
                            Button {
                                showDemo = true
                            } label: {
                                HStack(spacing: 6) {
                                    Text(L10n.Premium.Button.learn)
                                        .font(.subheadline.weight(.medium))
                                    Text("→")
                                }
                                .padding(.horizontal, 16)
                                .padding(.vertical, 10)
                                .background(Color.secondary.opacity(0.1))
                                .foregroundColor(.primary)
                                .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                            }
                        }
                    }
                    .padding(.bottom, 20)
                }

                Text(appState.hasCompletedSetup ? 
                     L10n.Home.Footer.works :
                     L10n.Home.Footer.setup)
                    .font(DS.Typo.caption)
                    .foregroundColor(.secondary)
                    .padding(.bottom, 12)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 20)

            }
            .padding(.top, 24)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(appBackground.ignoresSafeArea())
            .sheet(isPresented: $showSetup) {
                SetupView()
            }
            .sheet(isPresented: $showDemo) {
                DemoView()
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
        .environmentObject(AppState())
}
