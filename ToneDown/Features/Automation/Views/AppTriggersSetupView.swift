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
    
    private let setupSteps = [
        SetupStep(
            number: 1,
            title: "Создайте первую автоматизацию (включение)",
            description: "• Нажмите на значок '+' или 'Новая автоматизация'\n• Выберите 'Приложение'",
            action: "Создать автоматизацию",
            icon: "plus.circle.fill",
            color: .green
        ),
        SetupStep(
            number: 2,
            title: "Выберите приложения и настройте триггер",
            description: "• Выберите ВСЕ приложения, для которых должна работать автоматизация (Instagram, TikTok, YouTube и т.д.)\n• Затем в разделе 'Приложение' выберите 'Открыто'\n• И включите 'Немедленный запуск' для мгновенного срабатывания",
            action: "Настроить приложения и триггер",
            icon: "app.badge.checkmark",
            color: .purple
        ),
        // Убираем дублирующийся шаг 3
        SetupStep(
            number: 3,
            title: "Выберите команду 'Grayscale On'",
            description: "• Выберите команду 'Grayscale On' (включение серого режима) из списка ваших команд\n• Если команда не найдена, вернитесь к экрану создания команд",
            action: "Выбрать команду",
            icon: "checkmark.circle.fill",
            color: .green
        ),
        // Шаг 4: Создание второй автоматизации
        SetupStep(
            number: 4,
            title: "Создайте вторую автоматизацию (выключение)",
            description: "• Нажмите на значок '+' и выберите 'Приложение'",
            action: "Создать автоматизацию",
            icon: "plus.circle.fill",
            color: .green
        ),
        // Шаг 5: Настройка триггера для выключения
        SetupStep(
            number: 5,
            title: "Настройте триггер 'Закрыто'",
            description: "• Выберите те же приложения, что и в шаге 2\n• В разделе 'Приложение' выберите 'Закрыто'\n• Включите 'Немедленный запуск'",
            action: "Настроить триггер",
            icon: "xmark.circle.fill",
            color: .red
        ),
        // Шаг 6: Выбор команды для выключения
        SetupStep(
            number: 6,
            title: "Выберите команду 'Grayscale Off'",
            description: "• Выберите команду 'Grayscale Off' (выключение серого режима) из списка ваших команд\n• Это автоматически выключит серый режим при закрытии приложений",
            action: "Выбрать команду",
            icon: "checkmark.circle.fill",
            color: .orange
        ),
        // Шаг 7: Тестирование автоматизации
        SetupStep(
            number: 7,
            title: "Протестируйте автоматизацию",
            description: "• Откройте любое выбранное приложение - экран должен стать серым\n• Закройте приложение - экран должен вернуться к нормальным цветам\n• Если что-то не работает, вернитесь к соответствующим шагам настройки",
            action: "Протестировать",
            icon: "play.circle.fill",
            color: .blue
        )
    ]
    
    private let automationInstructions = [
        AutomationInstruction(
            stepNumber: 1,
            title: "Откройте приложение Команды",
            description: "Найдите и запустите приложение Команды на вашем iPhone"
        ),
        AutomationInstruction(
            stepNumber: 2,
            title: "Создайте первую автоматизацию (включение)",
            description: "Нажмите на значок '+' и выберите 'Создать персональную автоматизацию'"
        ),
        AutomationInstruction(
            stepNumber: 3,
            title: "Выберите триггер 'Приложение'",
            description: "Прокрутите вниз и выберите 'Приложение' в разделе 'Приложение'"
        ),
        AutomationInstruction(
            stepNumber: 4,
            title: "Выберите приложения и настройте 'Открывается'",
            description: "Выберите ВСЕ приложения, для которых должна работать автоматизация (Instagram, TikTok, YouTube и т.д.) и убедитесь, что выбрано 'Открывается'"
        ),
        AutomationInstruction(
            stepNumber: 5,
            title: "Добавьте действие 'Выполнить команду'",
            description: "Нажмите 'Добавить действие' и найдите 'Выполнить команду'"
        ),
        AutomationInstruction(
            stepNumber: 6,
            title: "Выберите команду 'Grayscale On'",
            description: "Выберите команду 'Grayscale On' (включение серого режима) из списка"
        ),
        AutomationInstruction(
            stepNumber: 7,
            title: "Отключите подтверждение и сохраните",
            description: "Отключите 'Спрашивать перед запуском' и нажмите 'Готово'"
        ),
        AutomationInstruction(
            stepNumber: 8,
            title: "Создайте вторую автоматизацию (выключение)",
            description: "Повторите шаги 2-7, но выберите 'Grayscale Off' и настройте триггер 'Закрывается'"
        )
    ]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 32) {
                // Header
                VStack(spacing: 16) {
                    Text("Пошаговая настройка автоматизации")
                        .font(.title2.weight(.bold))
                        .foregroundColor(.primary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 20)
                    
                    Text("Следуйте инструкциям для создания автоматического включения серого режима")
                        .font(.body)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 20)
                }
                .padding(.top, 20)
                
                // Progress indicator with checkboxes
                VStack(spacing: 16) {
                    HStack(spacing: 12) {
                        ForEach(0..<setupSteps.count, id: \.self) { index in
                            Button {
                                withAnimation(.easeInOut(duration: 0.3)) {
                                    currentStep = index
                                }
                            } label: {
                                ZStack {
                                    Circle()
                                        .fill(index <= currentStep ? DS.Color.accent : Color(.separator))
                                        .frame(width: 16, height: 16)
                                    
                                    if index < currentStep {
                                        Image(systemName: "checkmark")
                                            .font(.caption2.weight(.bold))
                                            .foregroundColor(.white)
                                    }
                                }
                                .scaleEffect(index == currentStep ? 1.2 : 1.0)
                                .animation(.easeInOut(duration: 0.3), value: currentStep)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    
                    Text("Шаг \(currentStep + 1) из \(setupSteps.count)")
                        .font(.caption.weight(.medium))
                        .foregroundColor(.secondary)
                }
                .padding(.horizontal, 20)
                
                // Current step card with detailed instructions
                VStack(spacing: 20) {
                    // Убираем ограничения по высоте, чтобы контент мог расширяться
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
                                .fixedSize(horizontal: false, vertical: true)
                        }
                        
                        Spacer()
                    }
                    
                    // Пошаговые инструкции теперь являются основными шагами
                    
                    // Action button - показываем для шагов 1 и 4
                    if step.number == 1 || step.number == 4 {
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
                .frame(maxWidth: .infinity)
                
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
                
                // Пошаговые инструкции уже добавлены выше
                

                
                Spacer(minLength: 40)
            }
        }
        .navigationTitle("Настройка автоматизации")
        .navigationBarTitleDisplayMode(.inline)
        .background(Color(.systemGroupedBackground))

    }
    
    private func handleStepAction(step: SetupStep) {
        switch step.number {
        case 1, 4:
            // Открываем экран создания автоматизаций для шагов 1 и 4
            openAutomationsScreen()
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

// MARK: - Automation Instruction Model
struct AutomationInstruction {
    let stepNumber: Int
    let title: String
    let description: String
}

#Preview {
    AppTriggersSetupView()
        .environmentObject(AppState())
}
