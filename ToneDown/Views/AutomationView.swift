//
//  AutomationView.swift
//  ToneDown
//
//  Created by Dyuven on 10.08.2025.
//

import SwiftUI

struct AutomationView: View {
    @EnvironmentObject var appState: AppState
    @State private var showDemo = false
    @State private var showPurchase = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 0) {
                    // Centered title
                    Text("Автоматизация")
                        .font(.largeTitle.weight(.bold))
                        .frame(maxWidth: .infinity)
                        .padding(.top, 20)
                        .padding(.bottom, 16)
                    
                    if appState.hasPremium {
                        if appState.hasCreatedBaseCommands {
                            automationContent
                        } else {
                            baseCommandsSetupContent
                        }
                    } else {
                        freeUserContent
                    }
                }
            }
            .navigationTitle("")
            .navigationBarTitleDisplayMode(.inline)
            .background(Color(.systemGroupedBackground))
        }
        .navigationViewStyle(.stack)
        .sheet(isPresented: $showDemo) {
            DemoView()
        }
        .sheet(isPresented: $showPurchase) {
            PurchaseView()
        }
    }
    
    // MARK: - Base Commands Setup Content
    private var baseCommandsSetupContent: some View {
        VStack(spacing: 32) {
            // Header
            VStack(spacing: 16) {
                Text("⚙️")
                    .font(.system(size: 56))
                Text("Создание базовых команд")
                    .font(.title.weight(.bold))
                Text("Сначала создайте команды для включения и выключения серого режима")
                    .font(.body)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 20)
            }
            
            // Info block
            VStack(alignment: .leading, spacing: 16) {
                HStack(spacing: 12) {
                    Image(systemName: "info.circle.fill")
                        .font(.title2)
                        .foregroundColor(DS.Color.accent)
                    
                    Text("Два шортката")
                        .font(.system(size: 16, weight: .semibold, design: .rounded))
                        .foregroundColor(.primary)
                }
                
                Text("Импортируйте готовые команды для управления серым режимом")
                    .font(.system(size: 14, weight: .medium, design: .rounded))
                    .foregroundColor(.secondary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .fixedSize(horizontal: false, vertical: true)
            }
            .padding(.vertical, 20)
            .padding(.horizontal, 20)
            .frame(maxWidth: .infinity)
            .background(
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .fill(DS.Color.accent.opacity(0.05))
                    .overlay(
                        RoundedRectangle(cornerRadius: 16, style: .continuous)
                            .stroke(DS.Color.accent.opacity(0.2), lineWidth: 1)
                    )
            )
            .padding(.horizontal, 20)
            
            // Import buttons
            VStack(spacing: 16) {
                Button(action: {
                    ShortcutsRunner.importBaseEnableCommand()
                }) {
                    HStack(spacing: 16) {
                        Image(systemName: "plus.circle.fill")
                            .font(.title2)
                            .foregroundColor(DS.Color.accent)
                            .frame(width: 32, height: 32)
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Включить серый режим")
                                .font(.system(size: 16, weight: .semibold, design: .rounded))
                                .foregroundColor(.primary)
                            
                            Text("Команда для активации")
                                .font(.system(size: 14, weight: .medium, design: .rounded))
                                .foregroundColor(.secondary)
                        }
                        
                        Spacer()
                        
                        Image(systemName: "arrow.up.right.square.fill")
                            .font(.title3)
                            .foregroundColor(DS.Color.accent)
                    }
                    .padding(.vertical, 20)
                    .padding(.horizontal, 20)
                    .background(
                        RoundedRectangle(cornerRadius: 16, style: .continuous)
                            .fill(.ultraThinMaterial)
                            .overlay(
                                RoundedRectangle(cornerRadius: 16, style: .continuous)
                                    .stroke(DS.Color.accent.opacity(0.2), lineWidth: 1)
                            )
                    )
                }
                .buttonStyle(.plain)
                
                Button(action: {
                    ShortcutsRunner.importBaseDisableCommand()
                }) {
                    HStack(spacing: 16) {
                        Image(systemName: "minus.circle.fill")
                            .font(.title2)
                            .foregroundColor(.secondary)
                            .frame(width: 32, height: 32)
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Восстановить цвета")
                                .font(.system(size: 16, weight: .semibold, design: .rounded))
                                .foregroundColor(.primary)
                            
                            Text("Команда для деактивации")
                                .font(.system(size: 14, weight: .medium, design: .rounded))
                                .foregroundColor(.secondary)
                        }
                        
                        Spacer()
                        
                        Image(systemName: "arrow.up.right.square.fill")
                            .font(.title3)
                            .foregroundColor(.secondary)
                    }
                    .padding(.vertical, 20)
                    .padding(.horizontal, 20)
                    .background(
                        RoundedRectangle(cornerRadius: 16, style: .continuous)
                            .fill(.ultraThinMaterial)
                            .overlay(
                                RoundedRectangle(cornerRadius: 16, style: .continuous)
                                    .stroke(.secondary.opacity(0.2), lineWidth: 1)
                            )
                    )
                }
                .buttonStyle(.plain)
            }
            .padding(.horizontal, 20)
            
            // Confirmation button
            VStack(spacing: 16) {
                Text("После добавления команд подтвердите создание")
                    .font(.subheadline.weight(.medium))
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                
                Button {
                    appState.completeBaseCommandsCreation()
                } label: {
                    HStack(spacing: 12) {
                        Image(systemName: "checkmark.circle.fill")
                            .font(.title3)
                        Text("Команды созданы")
                        .font(.headline.weight(.semibold))
                    }
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 56)
                    .background(
                        LinearGradient(
                            colors: [.green, .green.opacity(0.8)],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                    .shadow(color: .green.opacity(0.3), radius: 12, x: 0, y: 6)
                }
                .padding(.horizontal, 20)
            }
            .padding(.top, 16)
        }
        .padding(.top, 20)
    }
    
    // MARK: - Automation Content (shown after base commands are created)
    private var automationContent: some View {
        VStack(spacing: 24) {
            // Success message
            VStack(spacing: 16) {
                HStack(spacing: 12) {
                    Image(systemName: "checkmark.circle.fill")
                        .font(.title2)
                        .foregroundColor(.green)
                    VStack(alignment: .leading, spacing: 2) {
                        Text("Базовые команды созданы!")
                            .font(.headline.weight(.semibold))
                            .foregroundColor(.green)
                        Text("Теперь вы можете настроить автоматизацию")
                            .font(.caption)
                            .foregroundColor(.green.opacity(0.8))
                    }
                }
                .padding(.vertical, 12)
                .padding(.horizontal, 16)
                .background(
                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                        .fill(.green.opacity(0.1))
                )
            }
            .padding(.horizontal, 20)
            
            // Automation grid
            LazyVGrid(columns: [
                GridItem(.flexible(), spacing: 16),
                GridItem(.flexible(), spacing: 16)
            ], spacing: 16) {
                NavigationLink(destination: AppTriggersSetupView()) {
                    ModernAutomationCard(
                        icon: "apps.iphone",
                        title: "Приложения",
                        subtitle: "Автоматическое включение при открытии",
                        color: .purple,
                        isEnabled: true
                    )
                }
                .buttonStyle(.plain)
                
                ModernAutomationCard(
                    icon: "clock.fill",
                    title: "Расписание",
                    subtitle: "По времени суток",
                    color: .orange,
                    isEnabled: true
                )
                
                ModernAutomationCard(
                    icon: "moon.zzz.fill",
                    title: "Focus",
                    subtitle: "Интеграция с системой",
                    color: .indigo,
                    isEnabled: true
                )
                
                ModernAutomationCard(
                    icon: "location.fill",
                    title: "Геолокация",
                    subtitle: "По месту нахождения",
                    color: .green,
                    isEnabled: true
                )
            }
            .padding(.horizontal, 20)
            
            // Quick help
            VStack(spacing: 16) {
                Text("💡 Как настроить автоматизацию?")
                    .font(.subheadline.weight(.semibold))
                    .foregroundColor(.primary)
                
                Text("Выберите тип автоматизации и следуйте инструкциям. Все автоматизации будут использовать созданные вами базовые команды.")
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
            }
            .padding(.vertical, 16)
            .padding(.horizontal, 20)
            .background(
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .fill(.ultraThinMaterial)
            )
            .padding(.horizontal, 20)
            
            // Reset commands button
            Button {
                appState.resetBaseCommands()
            } label: {
                HStack(spacing: 8) {
                    Image(systemName: "arrow.clockwise")
                        .font(.subheadline)
                    Text("Пересоздать команды")
                        .font(.subheadline.weight(.medium))
                }
                .foregroundColor(.secondary)
                .padding(.vertical, 8)
                .padding(.horizontal, 16)
                .background(
                    RoundedRectangle(cornerRadius: 8, style: .continuous)
                        .fill(.secondary.opacity(0.1))
                )
            }
            .padding(.horizontal, 20)
        }
        .padding(.top, 20)
    }
    
    // MARK: - Free User Content
    private var freeUserContent: some View {
        VStack(spacing: 24) {
            // Premium required message
            VStack(spacing: 16) {
                Text("🔒")
                    .font(.system(size: 56))
                Text("Требуется Premium")
                    .font(.title.weight(.bold))
                Text("Автоматизация доступна только для Premium пользователей")
                    .font(.body)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 20)
            }
            
            // Purchase button
            Button {
                showPurchase = true
            } label: {
                HStack(spacing: 12) {
                    Image(systemName: "crown.fill")
                        .font(.title3)
                    Text("Получить Premium")
                        .font(.headline.weight(.semibold))
                }
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .frame(height: 56)
                .background(
                    LinearGradient(
                        colors: [DS.Color.accent, DS.Color.accent.opacity(0.8)],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
                .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                .shadow(color: DS.Color.accent.opacity(0.3), radius: 12, x: 0, y: 6)
            }
            .padding(.horizontal, 20)
            
            // Demo button
            Button {
                showDemo = true
            } label: {
                HStack(spacing: 12) {
                    Image(systemName: "play.circle.fill")
                        .font(.title3)
                    Text("Попробовать демо")
                        .font(.headline.weight(.semibold))
                }
                .foregroundColor(DS.Color.accent)
                .frame(maxWidth: .infinity)
                .frame(height: 56)
                .background(
                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                        .fill(DS.Color.accent.opacity(0.1))
                )
            }
            .padding(.horizontal, 20)
        }
        .padding(.top, 20)
    }
}

// MARK: - Modern Components

struct ModernAutomationCard: View {
    let icon: String
    let title: String
    let subtitle: String
    let color: Color
    let isEnabled: Bool
    
    var body: some View {
        VStack(spacing: 16) {
            // Icon with gradient background
            ZStack {
                Circle()
                    .fill(
                        LinearGradient(
                            colors: [color, color.opacity(0.7)],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: 56, height: 56)
                    .shadow(color: color.opacity(0.3), radius: 12, x: 0, y: 6)
                
                Image(systemName: icon)
                    .font(.system(size: 24, weight: .semibold))
                    .foregroundColor(.white)
            }
            
                            // Content
                VStack(spacing: 8) {
                    Text(title)
                        .font(.system(size: 16, weight: .semibold, design: .rounded))
                        .foregroundColor(.primary)
                        .multilineTextAlignment(.center)
                        .lineLimit(1)
                    
                    Text(subtitle)
                        .font(.system(size: 12, weight: .medium, design: .rounded))
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                        .lineLimit(2)
                        .fixedSize(horizontal: false, vertical: true)
                }
        }
        .frame(maxWidth: .infinity)
        .frame(height: 140)
        .padding(.vertical, 20)
        .background(
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(.ultraThinMaterial)
                .overlay(
                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                        .stroke(Color(.separator).opacity(0.2), lineWidth: 0.5)
                )
        )
        .shadow(color: Color.black.opacity(0.06), radius: 8, x: 0, y: 2)
        .opacity(isEnabled ? 1.0 : 0.6)
    }
}


        }
        .padding(.vertical, 12)
        .padding(.horizontal, 16)
        .background(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .fill(.ultraThinMaterial)
        )
    }
}





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
    
    @State private var showDetailedInstructions = false
    
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

// MARK: - Detailed Instructions View
struct DetailedInstructionsView: View {
    @Environment(\.dismiss) private var dismiss
    
    private let instructions = [
        InstructionStep(
            number: 1,
            title: "Команды уже созданы",
            description: "Базовые команды для включения и выключения серого режима уже добавлены в приложение Команды"
        ),
        InstructionStep(
            number: 2,
            title: "Откройте приложение Команды",
            description: "Найдите и запустите приложение Команды на вашем iPhone"
        ),
        InstructionStep(
            number: 3,
            title: "Создайте первую автоматизацию (включение)",
            description: "Нажмите на значок '+' и выберите 'Создать персональную автоматизацию'"
        ),
        InstructionStep(
            number: 4,
            title: "Выберите триггер 'Приложение'",
            description: "Прокрутите вниз и выберите 'Приложение' в разделе 'Приложение'"
        ),
        InstructionStep(
            number: 5,
            title: "Выберите приложения и настройте 'Открывается'",
            description: "Выберите ВСЕ приложения, для которых должна работать автоматизация (Instagram, TikTok, YouTube и т.д.) и убедитесь, что выбрано 'Открывается'"
        ),
        InstructionStep(
            number: 6,
            title: "Добавьте действие 'Выполнить команду'",
            description: "Нажмите 'Добавить действие' и найдите 'Выполнить команду'"
        ),
        InstructionStep(
            number: 7,
            title: "Выберите команду 'Grayscale On'",
            description: "Выберите команду 'Grayscale On' (включение серого режима) из списка"
        ),
        InstructionStep(
            number: 8,
            title: "Отключите подтверждение и сохраните",
            description: "Отключите 'Спрашивать перед запуском' и нажмите 'Готово'"
        ),
        InstructionStep(
            number: 9,
            title: "Создайте вторую автоматизацию (выключение)",
            description: "Повторите шаги 3-8, но выберите 'Закрывается', команду 'Grayscale Off' и те же приложения"
        ),
        InstructionStep(
            number: 10,
            title: "Проверьте работу",
            description: "Откройте и закройте приложение - серый режим должен включаться и выключаться автоматически"
        )
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 24) {
                    // Header
                    VStack(spacing: 12) {
                        Text("📋")
                            .font(.system(size: 48))
                        Text("Подробные инструкции")
                            .font(.title.weight(.bold))
                        Text("Пошаговое руководство по настройке автоматизации")
                            .font(.body)
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.center)
                    }
                    .padding(.top, 20)
                    
                    // Instructions list
                    VStack(spacing: 16) {
                        ForEach(instructions, id: \.number) { instruction in
                            InstructionRow(instruction: instruction)
                        }
                    }
                    .padding(.horizontal, 20)
                    
                    // Tips section
                    VStack(spacing: 16) {
                        Text("💡 Полезные советы")
                            .font(.title3.weight(.semibold))
                        
                        VStack(alignment: .leading, spacing: 12) {
                            TipRow(
                                icon: "checkmark.circle.fill",
                                text: "Для каждого приложения нужно создать ДВЕ автоматизации",
                                color: .green
                            )
                            TipRow(
                                icon: "info.circle.fill",
                                text: "Выберите ВСЕ нужные приложения сразу в первой автоматизации",
                                color: .blue
                            )
                            TipRow(
                                icon: "checkmark.circle.fill",
                                text: "Базовые команды уже созданы и готовы к использованию",
                                color: .green
                            )
                            TipRow(
                                icon: "lightbulb.fill",
                                text: "В обеих автоматизациях должны быть выбраны одинаковые приложения",
                                color: .purple
                            )
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
            .navigationTitle("Инструкции")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing: Button("Готово") {
                dismiss()
            })
        }
    }
}

// MARK: - Instruction Row
struct InstructionRow: View {
    let instruction: InstructionStep
    
    var body: some View {
        HStack(spacing: 16) {
            ZStack {
                Circle()
                    .fill(DS.Color.accent)
                    .frame(width: 32, height: 32)
                
                Text("\(instruction.number)")
                    .font(.subheadline.weight(.bold))
                    .foregroundColor(.white)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(instruction.title)
                    .font(.subheadline.weight(.semibold))
                    .foregroundColor(.primary)
                
                Text(instruction.description)
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .lineLimit(3)
            }
            
            Spacer()
        }
        .padding(.vertical, 12)
        .padding(.horizontal, 16)
        .background(
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .fill(.ultraThinMaterial)
        )
    }
}

// MARK: - Tip Row
struct TipRow: View {
    let icon: String
    let text: String
    let color: Color
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .font(.subheadline)
                .foregroundColor(color)
            
            Text(text)
                .font(.subheadline)
                .foregroundColor(.primary)
            
            Spacer()
        }
    }
}

// MARK: - Instruction Step Model
struct InstructionStep {
    let number: Int
    let title: String
    let description: String
}

#Preview {
    AutomationView()
        .environmentObject(AppState())
}
