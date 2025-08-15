//
//  AppTriggersSetupView.swift
//  ToneDown
//
//  Created by Dyuven on 10.08.2025.
//

import SwiftUI

// MARK: - App Triggers Setup View
struct AppTriggersSetupView: View {
    @EnvironmentObject var appState: AppState
    @State private var currentStep = 0
    @State private var showDetailedInstructions = false
    
    private let setupSteps = [
        SetupStep(
            number: 1,
            title: "Команды готовы",
            description: "Базовые команды для включения и выключения серого режима уже созданы",
            action: "Посмотреть инструкции",
            icon: "checkmark.circle.fill",
            color: .green
        ),
        SetupStep(
            number: 2,
            title: "Открыть автоматизации",
            description: "Перейдите прямо к экрану создания автоматизаций в Командах",
            action: "Открыть автоматизации",
            icon: "arrow.up.right.square.fill",
            color: .blue
        ),
        SetupStep(
            number: 3,
            title: "Создать автоматизацию",
            description: "Следуйте инструкциям для настройки автоматического включения при открытии приложений",
            action: "Показать инструкции",
            icon: "list.bullet.clipboard.fill",
            color: .green
        )
    ]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 32) {
                // Header
                VStack(spacing: 16) {
                    Text("Настройте автоматическое включение серого режима при открытии приложений")
                        .font(.body)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 20)
                }
                .padding(.top, 20)
                
                // Progress indicator
                VStack(spacing: 16) {
                    HStack(spacing: 12) {
                        ForEach(0..<setupSteps.count, id: \.self) { index in
                            Circle()
                                .fill(index <= currentStep ? DS.Color.accent : Color(.separator))
                                .frame(width: 12, height: 12)
                                .scaleEffect(index == currentStep ? 1.2 : 1.0)
                                .animation(.easeInOut(duration: 0.3), value: currentStep)
                        }
                    }
                    
                    Text("Шаг \(currentStep + 1) из \(setupSteps.count)")
                        .font(.caption.weight(.medium))
                        .foregroundColor(.secondary)
                }
                .padding(.horizontal, 20)
                
                // Current step card
                VStack(spacing: 20) {
                    let step = setupSteps[currentStep]
                    
                    // Step header
                    HStack(spacing: 16) {
                        ZStack {
                            Circle()
                                .fill(step.color)
                                .frame(width: 48, height: 48)
                            
                            Text("\(step.number)")
                                .font(.title2.weight(.bold))
                                .foregroundColor(.white)
                        }
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text(step.title)
                                .font(.title3.weight(.semibold))
                                .foregroundColor(.primary)
                            
                            Text(step.description)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                                .lineLimit(3)
                        }
                        
                        Spacer()
                    }
                    
                    // Action button
                    Button {
                        handleStepAction(step: step)
                    } label: {
                        HStack(spacing: 12) {
                            Image(systemName: step.icon)
                                .font(.title3)
                            Text(step.action)
                                .font(.headline.weight(.semibold))
                        }
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 56)
                        .background(
                            LinearGradient(
                                colors: [step.color, step.color.opacity(0.8)],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                        .shadow(color: step.color.opacity(0.3), radius: 12, x: 0, y: 6)
                    }
                }
                .padding(.vertical, 24)
                .padding(.horizontal, 20)
                .background(
                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                        .fill(.ultraThinMaterial)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20, style: .continuous)
                                .stroke(DS.Color.accent.opacity(0.2), lineWidth: 1)
                        )
                )
                .padding(.horizontal, 20)
                
                // Navigation buttons
                HStack(spacing: 16) {
                    if currentStep > 0 {
                        Button {
                            withAnimation(.easeInOut(duration: 0.3)) {
                                currentStep -= 1
                            }
                        } label: {
                            HStack(spacing: 8) {
                                Image(systemName: "chevron.left")
                                    .font(.subheadline.weight(.semibold))
                                Text("Назад")
                                    .font(.headline.weight(.semibold))
                            }
                            .foregroundColor(DS.Color.accent)
                            .frame(maxWidth: .infinity)
                            .frame(height: 48)
                            .background(
                                RoundedRectangle(cornerRadius: 12, style: .continuous)
                                    .fill(DS.Color.accent.opacity(0.1))
                            )
                        }
                    }
                    
                    if currentStep < setupSteps.count - 1 {
                        Button {
                            withAnimation(.easeInOut(duration: 0.3)) {
                                currentStep += 1
                            }
                        } label: {
                            HStack(spacing: 8) {
                                Text("Далее")
                                    .font(.headline.weight(.semibold))
                                Image(systemName: "chevron.right")
                                    .font(.subheadline.weight(.semibold))
                            }
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 48)
                            .background(
                                LinearGradient(
                                    colors: [DS.Color.accent, DS.Color.accent.opacity(0.8)],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                        }
                    }
                }
                .padding(.horizontal, 20)
                
                // Quick help
                if currentStep == 2 {
                    VStack(spacing: 16) {
                        Text("💡 Нужна помощь?")
                            .font(.subheadline.weight(.semibold))
                            .foregroundColor(.primary)
                        
                        Button {
                            showDetailedInstructions = true
                        } label: {
                            HStack(spacing: 8) {
                                Image(systemName: "questionmark.circle.fill")
                                    .font(.title3)
                                Text("Показать подробные инструкции")
                                    .font(.subheadline.weight(.medium))
                            }
                            .foregroundColor(DS.Color.accent)
                            .padding(.vertical, 12)
                            .padding(.horizontal, 16)
                            .background(
                                RoundedRectangle(cornerRadius: 12, style: .continuous)
                                    .fill(DS.Color.accent.opacity(0.1))
                            )
                        }
                    }
                    .padding(.vertical, 16)
                    .padding(.horizontal, 20)
                    .background(
                        RoundedRectangle(cornerRadius: 16, style: .continuous)
                            .fill(.ultraThinMaterial)
                    )
                    .padding(.horizontal, 20)
                }
                
                Spacer(minLength: 40)
            }
        }
        .navigationTitle("Настройка автоматизации")
        .navigationBarTitleDisplayMode(.inline)
        .background(Color(.systemGroupedBackground))
        .sheet(isPresented: $showDetailedInstructions) {
            DetailedInstructionsView()
        }
    }
    
    private func handleStepAction(step: SetupStep) {
        switch step.number {
        case 1:
            // Показываем инструкции по созданию команд
            showDetailedInstructions = true
        case 2:
            openAutomationsScreen()
        case 3:
            showDetailedInstructions = true
        default:
            break
        }
    }
    
    private func openAutomationsScreen() {
        // Открываем экран автоматизаций в Командах
        if let url = URL(string: "shortcuts://automation") {
            UIApplication.shared.open(url)
        } else {
            // Fallback: открываем обычное приложение Команды
            ShortcutsRunner.openShortcutsApp()
        }
    }
}

// MARK: - Setup Step Model
struct SetupStep {
    let number: Int
    let title: String
    let description: String
    let action: String
    let icon: String
    let color: Color
}

#Preview {
    AppTriggersSetupView()
        .environmentObject(AppState())
}
