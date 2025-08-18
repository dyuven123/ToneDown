//
//  LocationAutomationViewModel.swift
//  ToneDown
//
//  Created by Dyuven on 10.08.2025.
//

import SwiftUI
import AVKit
import AVFoundation
import Combine

// MARK: - Location Automation ViewModel
class LocationAutomationViewModel: NSObject, ObservableObject {
    // MARK: - Published Properties
    @Published var currentStep = 0
    @Published var isViewActive = false
    
    // MARK: - Private Properties
    private var videoPlayers: [Int: AVPlayer] = [:]
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Setup Steps Data
    let setupSteps = [
        SetupStep(
            number: 1,
            title: "location.setup.step1.title",
            description: "location.setup.step1.description",
            action: "location.setup.step1.action",
            icon: "plus.circle.fill",
            color: .green,
            video: "location_step1_create_automation"
        ),
        SetupStep(
            number: 2,
            title: "location.setup.step2.title",
            description: "location.setup.step2.description",
            action: "location.setup.step2.action",
            icon: "location.fill",
            color: .blue,
            video: "location_step2_select_location"
        ),
        SetupStep(
            number: 3,
            title: "location.setup.step3.title",
            description: "location.setup.step3.description",
            action: "location.setup.step3.action",
            icon: "checkmark.circle.fill",
            color: .green,
            video: "location_step3_select_grayscale_on"
        ),
        SetupStep(
            number: 4,
            title: "location.setup.step4.title",
            description: "location.setup.step4.description",
            action: "location.setup.step4.action",
            icon: "plus.circle.fill",
            color: .green,
            video: "location_step4_create_second_automation"
        ),
        SetupStep(
            number: 5,
            title: "location.setup.step5.title",
            description: "location.setup.step5.description",
            action: "location.setup.step5.action",
            icon: "location.fill",
            color: .orange,
            video: "location_step5_select_exit_location"
        ),
        SetupStep(
            number: 6,
            title: "location.setup.step6.title",
            description: "location.setup.step6.description",
            action: "location.setup.step6.action",
            icon: "xmark.circle.fill",
            color: .red,
            video: "location_step6_select_grayscale_off"
        ),
        SetupStep(
            number: 7,
            title: "location.setup.step7.title",
            description: "location.setup.step7.description",
            action: "location.setup.step7.action",
            icon: "play.circle.fill",
            color: .blue,
            video: "location_step7_test_automation"
        )
    ]
    
    // MARK: - Computed Properties
    var totalSteps: Int { setupSteps.count }
    var currentStepData: SetupStep { setupSteps[currentStep] }
    var canGoBack: Bool { currentStep > 0 }
    var canGoNext: Bool { currentStep < totalSteps - 1 }
    var shouldShowActionButton: Bool { currentStepData.number == 1 || currentStepData.number == 4 }
    
    // MARK: - Initialization
    override init() {
        super.init()
        setupBindings()
    }
    
    // MARK: - Public Methods
    @MainActor
    func goToStep(_ step: Int) {
        guard step >= 0 && step < totalSteps else { return }
        
        withAnimation(.easeInOut(duration: 0.3)) {
            currentStep = step
            restartVideoForCurrentStep()
        }
    }
    
    @MainActor
    func goToNextStep() {
        guard canGoNext else { return }
        goToStep(currentStep + 1)
    }
    
    @MainActor
    func goToPreviousStep() {
        guard canGoBack else { return }
        goToStep(currentStep - 1)
    }
    
    func handleStepAction() {
        switch currentStepData.number {
        case 1, 4:
            openAutomationsScreen()
        default:
            break
        }
    }
    
    @MainActor
    func viewDidAppear() {
        isViewActive = true
        
        // Запускаем видео для текущего шага, если оно готово
        if let player = videoPlayers[currentStep] {
            if player.currentItem?.status == .readyToPlay {
                player.play()
            } else {
                // Если видео еще не готово, настраиваем наблюдатель
                setupVideoReadyObserver(for: player)
            }
        }
    }
    
    @MainActor
    func viewDidDisappear() {
        isViewActive = false
        pauseAllVideos()
    }
    
    @MainActor
    func applicationWillResignActive() {
        isViewActive = false
        pauseAllVideos()
    }
    
    @MainActor
    func applicationDidBecomeActive() {
        isViewActive = true
        restartVideoForCurrentStep()
    }
    
    // MARK: - Video Management
    func getOrCreatePlayer(for stepNumber: Int, with url: URL) -> AVPlayer {
        if let existingPlayer = videoPlayers[stepNumber] {
            return existingPlayer
        } else {
            let newPlayer = AVPlayer(url: url)
            
            // Настраиваем зацикливание видео
            setupVideoLooping(for: newPlayer)
            
            // Настраиваем наблюдатель за готовностью плеера
            setupVideoReadyObserver(for: newPlayer)
            
            videoPlayers[stepNumber] = newPlayer
            return newPlayer
        }
    }
    
    @MainActor
    func restartVideoForCurrentStep() {
        guard let videoName = currentStepData.video else { return }
        
        // Убираем задержку для перезапуска при смене шага
        if let player = videoPlayers[currentStep] {
            // Убеждаемся, что зацикливание настроено для текущего плеера
            setupVideoLooping(for: player)
            player.seek(to: .zero)
            player.play()
        }
    }
    
    // MARK: - Private Methods
    private func setupBindings() {
        $currentStep
            .sink { [weak self] _ in
                Task { @MainActor in
                    self?.restartVideoForCurrentStep()
                }
            }
            .store(in: &cancellables)
    }
    
    private func setupVideoLooping(for player: AVPlayer) {
        // Добавляем наблюдатель за окончанием видео
        NotificationCenter.default.addObserver(
            forName: NSNotification.Name.AVPlayerItemDidPlayToEndTime,
            object: player.currentItem,
            queue: OperationQueue.main
        ) { [weak self, weak player] _ in
            // Когда видео заканчивается, начинаем его сначала
            player?.seek(to: .zero)
            player?.play()
        }
    }
    
    private func setupVideoReadyObserver(for player: AVPlayer) {
        // Наблюдаем за готовностью плеера
        player.currentItem?.addObserver(self, forKeyPath: "status", options: [.new], context: nil)
    }
    
    private func openAutomationsScreen() {
        if let url = URL(string: "shortcuts://automation") {
            UIApplication.shared.open(url)
        } else {
            // Fallback - открываем приложение Команды
            if let shortcutsURL = URL(string: "shortcuts://") {
                UIApplication.shared.open(shortcutsURL)
            }
        }
    }
    
    private func pauseAllVideos() {
        for player in videoPlayers.values {
            player.pause()
        }
    }
    
    // MARK: - Cleanup
    deinit {
        cancellables.removeAll()
        
        // Убираем всех наблюдателей и останавливаем видео
        for (_, player) in videoPlayers {
            // Убираем наблюдатели зацикливания
            NotificationCenter.default.removeObserver(self, name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: player.currentItem)
            
            // Убираем KVO наблюдатели
            player.currentItem?.removeObserver(self, forKeyPath: "status")
            
            // Убираем наблюдатели готовности
            NotificationCenter.default.removeObserver(self, name: NSNotification.Name.AVPlayerItemNewErrorLogEntry, object: player.currentItem)
            
            player.pause()
        }
        
        // Очищаем словарь
        videoPlayers.removeAll()
    }
    
    // MARK: - KVO
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "status" {
            if let playerItem = object as? AVPlayerItem {
                if playerItem.status == .readyToPlay {
                    // Плеер готов к воспроизведению
                    Task { @MainActor in
                        // Находим плеер по playerItem
                        if let player = self.findPlayer(for: playerItem),
                           let stepNumber = self.getStepNumber(for: player),
                           stepNumber == self.currentStep,
                           self.isViewActive == true {
                            // Автоматически запускаем видео
                            player.play()
                        }
                    }
                }
            }
        }
    }
    
    private func getStepNumber(for player: AVPlayer) -> Int? {
        for (stepNumber, storedPlayer) in videoPlayers {
            if storedPlayer === player {
                return stepNumber
            }
        }
        return nil
    }
    
    private func findPlayer(for playerItem: AVPlayerItem) -> AVPlayer? {
        for (_, player) in videoPlayers {
            if player.currentItem === playerItem {
                return player
            }
        }
        return nil
    }
}
