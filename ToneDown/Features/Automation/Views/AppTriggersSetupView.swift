//
//  AppTriggersSetupView.swift
//  ToneDown
//
//  Created by Dyuven on 10.08.2025.
//

import SwiftUI
import AVKit

// MARK: - App Triggers Setup View
struct AppTriggersSetupView: View {
    @EnvironmentObject var appState: AppState
    @State private var currentStep = 0
    @State private var isViewActive = false
    @State private var videoPlayers: [Int: AVPlayer] = [:]
    
    private let setupSteps = [
        SetupStep(
            number: 1,
            title: "app.triggers.setup.step1.title",
            description: "app.triggers.setup.step1.description",
            action: "app.triggers.setup.step1.action",
            icon: "plus.circle.fill",
            color: .green,
            video: "step1_create_automation"
        ),
        SetupStep(
            number: 2,
            title: "app.triggers.setup.step2.title",
            description: "app.triggers.setup.step2.description",
            action: "app.triggers.setup.step2.action",
            icon: "app.badge.checkmark",
            color: .purple,
            video: "step2_select_apps"
        ),
        // Убираем дублирующийся шаг 3
        SetupStep(
            number: 3,
            title: "app.triggers.setup.step3.title",
            description: "app.triggers.setup.step3.description",
            action: "app.triggers.setup.step3.action",
            icon: "checkmark.circle.fill",
            color: .green,
            video: "step3_select_grayscale_on"
        ),
        // Шаг 4: Создание второй автоматизации
        SetupStep(
            number: 4,
            title: "app.triggers.setup.step4.title",
            description: "app.triggers.setup.step4.description",
            action: "app.triggers.setup.step4.action",
            icon: "plus.circle.fill",
            color: .green,
            video: "step4_create_second_automation"
        ),
        // Шаг 5: Настройка триггера для выключения
        SetupStep(
            number: 5,
            title: "app.triggers.setup.step5.title",
            description: "app.triggers.setup.step5.description",
            action: "app.triggers.setup.step5.action",
            icon: "xmark.circle.fill",
            color: .red,
            video: "step5_configure_closed_trigger"
        ),
        // Шаг 6: Выбор команды для выключения
        SetupStep(
            number: 6,
            title: "app.triggers.setup.step6.title",
            description: "app.triggers.setup.step6.description",
            action: "app.triggers.setup.step6.action",
            icon: "checkmark.circle.fill",
            color: .orange,
            video: "step6_select_grayscale_off"
        ),
        // Шаг 7: Тестирование автоматизации
        SetupStep(
            number: 7,
            title: "app.triggers.setup.step7.title",
            description: "app.triggers.setup.step7.description",
            action: "app.triggers.setup.step7.action",
            icon: "play.circle.fill",
            color: .blue,
            video: "step7_test_automation"
        )
    ]
    
    private let automationInstructions = [
        AutomationInstruction(
            stepNumber: 1,
            title: "app.triggers.setup.instruction.step1.title",
            description: "app.triggers.setup.instruction.step1.description"
        ),
        AutomationInstruction(
            stepNumber: 2,
            title: "app.triggers.setup.instruction.step2.title",
            description: "app.triggers.setup.instruction.step2.description"
        ),
        AutomationInstruction(
            stepNumber: 3,
            title: "app.triggers.setup.instruction.step3.title",
            description: "app.triggers.setup.instruction.step3.description"
        ),
        AutomationInstruction(
            stepNumber: 4,
            title: "app.triggers.setup.instruction.step4.title",
            description: "app.triggers.setup.instruction.step4.description"
        ),
        AutomationInstruction(
            stepNumber: 5,
            title: "app.triggers.setup.instruction.step5.title",
            description: "app.triggers.setup.instruction.step5.description"
        ),
        AutomationInstruction(
            stepNumber: 6,
            title: "app.triggers.setup.instruction.step6.title",
            description: "app.triggers.setup.instruction.step6.description"
        ),
        AutomationInstruction(
            stepNumber: 7,
            title: "app.triggers.setup.instruction.step7.title",
            description: "app.triggers.setup.instruction.step7.description"
        ),
        AutomationInstruction(
            stepNumber: 8,
            title: "app.triggers.setup.instruction.step8.title",
            description: "app.triggers.setup.instruction.step8.description"
        )
    ]
    
    var body: some View {
                ScrollView {
            VStack(spacing: 24) {
                // Progress indicator with checkboxes
                VStack(spacing: 12) {
                    HStack(spacing: 12) {
                        ForEach(0..<setupSteps.count, id: \.self) { index in
                            Button {
                                withAnimation(.easeInOut(duration: 0.3)) {
                                    currentStep = index
                                    // Перезапускаем видео для нового шага
                                    if let videoName = setupSteps[index].video {
                                        if isViewActive {
                                            if let player = videoPlayers[index] {
                                                player.seek(to: .zero)
                                                player.play()
                                            }
                                        }
                                    }
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
                    
                    Text(String(format: LocalizationHelper.localizedString("app.triggers.setup.step", comment: ""), currentStep + 1, setupSteps.count))
                        .font(.caption.weight(.medium))
                        .foregroundColor(.secondary)
                }
                .padding(.horizontal, 20)
                
                // Current step card with detailed instructions
                VStack(spacing: 16) {
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
                            Text(LocalizedStringKey(step.title))
                                .font(.title3.weight(.semibold))
                                .foregroundColor(.primary)
                            
                            Text(LocalizedStringKey(step.description))
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                                .fixedSize(horizontal: false, vertical: true)
                        }
                        
                        Spacer()
                    }
                    .padding(.bottom, 8)
                    
                    // Video or Screenshot - показываем если есть
                    if let videoName = step.video {
                        // Сначала пробуем найти в папке Resources/Videos
                        if let videoURL = Bundle.main.url(forResource: videoName, withExtension: "mp4", subdirectory: "Resources/Videos") {
                            VStack(spacing: 0) {
                                // Красивая рамка для видео
                                ZStack {
                                    // Фоновая рамка с градиентом
                                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                                        .fill(
                                            LinearGradient(
                                                colors: [
                                                    DS.Color.accent.opacity(0.1),
                                                    DS.Color.accent.opacity(0.05),
                                                    DS.Color.accent.opacity(0.02)
                                                ],
                                                startPoint: .topLeading,
                                                endPoint: .bottomTrailing
                                            )
                                        )
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 20, style: .continuous)
                                                .stroke(
                                                    LinearGradient(
                                                        colors: [
                                                            DS.Color.accent.opacity(0.3),
                                                            DS.Color.accent.opacity(0.1)
                                                        ],
                                                        startPoint: .topLeading,
                                                        endPoint: .bottomTrailing
                                                    ),
                                                    lineWidth: 2
                                                )
                                        )
                                    
                                    // Видео с закругленными углами
                                    VideoPlayer(player: getOrCreatePlayer(for: step.number, with: videoURL))
                                        .aspectRatio(contentMode: .fit)
                                        .frame(maxHeight: 300)
                                        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                                        .padding(8)
                                }
                                .shadow(
                                    color: DS.Color.accent.opacity(0.2),
                                    radius: 20,
                                    x: 0,
                                    y: 8
                                )
                                .shadow(
                                    color: .black.opacity(0.1),
                                    radius: 8,
                                    x: 0,
                                    y: 4
                                )
                                
                                // Индикатор воспроизведения
                                HStack(spacing: 8) {
                                    Image(systemName: "play.circle.fill")
                                        .font(.caption)
                                        .foregroundColor(DS.Color.accent)
                                    Text(LocalizedStringKey("app.triggers.setup.video.playing"))
                                        .font(.caption2.weight(.medium))
                                        .foregroundColor(.secondary)
                                }
                                .padding(.top, 8)
                            }
                            .onAppear {
                                // Запускаем видео сразу
                                playVideoForCurrentStep()
                            }
                        } else {
                            // Fallback: попробуем найти в основном bundle
                            if let videoURL = Bundle.main.url(forResource: videoName, withExtension: "mp4") {
                                VStack(spacing: 0) {
                                    // Красивая рамка для видео
                                    ZStack {
                                        // Фоновая рамка с градиентом
                                        RoundedRectangle(cornerRadius: 20, style: .continuous)
                                            .fill(
                                                LinearGradient(
                                                    colors: [
                                                        DS.Color.accent.opacity(0.1),
                                                        DS.Color.accent.opacity(0.05),
                                                        DS.Color.accent.opacity(0.02)
                                                    ],
                                                    startPoint: .topLeading,
                                                    endPoint: .bottomTrailing
                                                )
                                            )
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 20, style: .continuous)
                                                    .stroke(
                                                        LinearGradient(
                                                            colors: [
                                                                    DS.Color.accent.opacity(0.3),
                                                                    DS.Color.accent.opacity(0.1)
                                                                ],
                                                                startPoint: .topLeading,
                                                                endPoint: .bottomTrailing
                                                            ),
                                                        lineWidth: 2
                                                    )
                                            )
                                        
                                        // Видео с закругленными углами
                                        VideoPlayer(player: getOrCreatePlayer(for: step.number, with: videoURL))
                                            .aspectRatio(contentMode: .fit)
                                            .frame(maxHeight: 300)
                                            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                                            .padding(8)
                                    }
                                    .shadow(
                                        color: DS.Color.accent.opacity(0.2),
                                        radius: 20,
                                        x: 0,
                                        y: 8
                                    )
                                    .shadow(
                                        color: .black.opacity(0.1),
                                        radius: 8,
                                        x: 0,
                                        y: 4
                                    )
                                    
                                    // Индикатор воспроизведения
                                    HStack(spacing: 8) {
                                        Image(systemName: "play.circle.fill")
                                            .font(.caption)
                                            .foregroundColor(DS.Color.accent)
                                        Text(LocalizedStringKey("app.triggers.setup.video.playing"))
                                            .font(.caption2.weight(.medium))
                                            .foregroundColor(.secondary)
                                    }
                                    .padding(.top, 8)
                                }
                                .onAppear {
                                    // Запускаем видео с задержкой 2 секунды
                                    playVideoForCurrentStep()
                                }
                            } else {
                                // Отладочная информация
                                Text("Видео не найдено: \(videoName).mp4")
                                    .font(.caption)
                                    .foregroundColor(.red)
                                    .padding()
                            }
                        }
                    }
                    
                    // Если нет видео, показываем красивую заглушку
                    if step.video == nil {
                        VStack(spacing: 0) {
                            // Красивая рамка для заглушки
                            ZStack {
                                // Фоновая рамка с градиентом
                                RoundedRectangle(cornerRadius: 20, style: .continuous)
                                    .fill(
                                        LinearGradient(
                                            colors: [
                                                DS.Color.accent.opacity(0.1),
                                                DS.Color.accent.opacity(0.05),
                                                DS.Color.accent.opacity(0.02)
                                            ],
                                            startPoint: .topLeading,
                                            endPoint: .bottomTrailing
                                        )
                                    )
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 20, style: .continuous)
                                            .stroke(
                                                LinearGradient(
                                                    colors: [
                                                            DS.Color.accent.opacity(0.3),
                                                            DS.Color.accent.opacity(0.1)
                                                        ],
                                                        startPoint: .topLeading,
                                                        endPoint: .bottomTrailing
                                                    ),
                                                    lineWidth: 2
                                                )
                                            )
                                
                                // Содержимое заглушки
                                VStack(spacing: 16) {
                                    Image(systemName: "photo")
                                        .font(.system(size: 48))
                                        .foregroundColor(DS.Color.accent.opacity(0.6))
                                    Text(LocalizedStringKey("app.triggers.setup.placeholder.title"))
                                        .font(.subheadline.weight(.medium))
                                        .foregroundColor(.secondary)
                                        .multilineTextAlignment(.center)
                                }
                                .padding(32)
                            }
                            .shadow(
                                color: DS.Color.accent.opacity(0.2),
                                radius: 20,
                                x: 0,
                                y: 8
                            )
                            .shadow(
                                color: .black.opacity(0.1),
                                radius: 8,
                                x: 0,
                                y: 4
                            )
                        }
                    }
                    
                    // Action button - показываем для шагов 1 и 4
                    if step.number == 1 || step.number == 4 {
                        Button {
                            handleStepAction(step: step)
                        } label: {
                            HStack(spacing: 12) {
                                Image(systemName: step.icon)
                                    .font(.title3)
                                Text(LocalizedStringKey(step.action))
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
                .padding(.vertical, 20)
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
                                // Перезапускаем видео для предыдущего шага
                                if let videoName = setupSteps[currentStep].video {
                                    if isViewActive {
                                        if let player = videoPlayers[currentStep] {
                                            player.seek(to: .zero)
                                            player.play()
                                        }
                                    }
                                }
                            }
                        } label: {
                            HStack(spacing: 8) {
                                Image(systemName: "chevron.left")
                                    .font(.subheadline.weight(.semibold))
                                Text(LocalizedStringKey("app.triggers.setup.button.back"))
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
                                // Перезапускаем видео для следующего шага
                                if let videoName = setupSteps[currentStep].video {
                                    if isViewActive {
                                        if let player = videoPlayers[currentStep] {
                                            player.seek(to: .zero)
                                            player.play()
                                        }
                                    }
                                }
                            }
                        } label: {
                            HStack(spacing: 8) {
                                Text(LocalizedStringKey("app.triggers.setup.button.next"))
                                    .font(.headline.weight(.semibold))
                                Image(systemName: "chevron.right")
                                    .font(.subheadline.weight(.semibold))
                            }
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 48)
                            .background(
                                LinearGradient(
                                    colors: [
                                        DS.Color.accent,
                                        DS.Color.accent.opacity(0.8)
                                    ],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                        }
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, 8)
                
                // Пошаговые инструкции уже добавлены выше
                
                
                
                Spacer(minLength: 24)
            }
            .padding(.top, 8)
        }
        .navigationTitle(LocalizedStringKey("app.triggers.setup.title"))
        .navigationBarTitleDisplayMode(.inline)
        .background(Color(.systemGroupedBackground))
        .onAppear {
            isViewActive = true
            
            // Запускаем видео для текущего шага с небольшой задержкой для первого запуска
            if let videoName = setupSteps[currentStep].video {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    if isViewActive {
                        playVideoForCurrentStep()
                    }
                }
            }
        }
        .onDisappear {
            isViewActive = false
            
            // Останавливаем все видео при уходе с экрана
            for player in videoPlayers.values {
                player.pause()
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)) { _ in
            // Приложение уходит в фон - останавливаем видео
            isViewActive = false
            for player in videoPlayers.values {
                player.pause()
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.didBecomeActiveNotification)) { _ in
            // Приложение возвращается на передний план - запускаем видео сразу
            isViewActive = true
            if let videoName = setupSteps[currentStep].video {
                playVideoForCurrentStep()
            }
        }
        .onChange(of: currentStep) { newStep in
            // При смене шага автоматически запускаем видео
            if let videoName = setupSteps[newStep].video {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    if isViewActive {
                        if let player = videoPlayers[newStep] {
                            player.seek(to: .zero)
                            player.play()
                        }
                    }
                }
            }
        }

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
    
    private func getOrCreatePlayer(for stepNumber: Int, with url: URL) -> AVPlayer {
        if let existingPlayer = videoPlayers[stepNumber] {
            return existingPlayer
        } else {
            let newPlayer = AVPlayer(url: url)
            videoPlayers[stepNumber] = newPlayer
            return newPlayer
        }
    }
    
    private func playVideoForCurrentStep() {
        guard let videoName = setupSteps[currentStep].video else { return }
        
        // Запускаем видео сразу без задержки
        if self.isViewActive {
            if let player = self.videoPlayers[self.currentStep] {
                player.seek(to: .zero)
                player.play()
            }
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
    let video: String? // Имя видео файла из Assets
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
