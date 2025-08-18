//
//  ScheduleAutomationView.swift
//  ToneDown
//
//  Created by Dyuven on 10.08.2025.
//

import SwiftUI

// MARK: - Schedule Automation View
struct ScheduleAutomationView: View {
    @StateObject private var viewModel = ScheduleAutomationViewModel()
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                // Progress indicator
                ProgressIndicatorView(
                    currentStep: viewModel.currentStep,
                    totalSteps: viewModel.totalSteps,
                    onStepTap: viewModel.goToStep
                )
                
                // Current step card
                StepCardView(
                    step: viewModel.currentStepData,
                    onActionTap: viewModel.handleStepAction,
                    getOrCreatePlayer: viewModel.getOrCreatePlayer
                )
                
                // Navigation buttons
                NavigationButtonsView(
                    canGoBack: viewModel.canGoBack,
                    canGoNext: viewModel.canGoNext,
                    onBackTap: viewModel.goToPreviousStep,
                    onNextTap: viewModel.goToNextStep
                )
                
                Spacer(minLength: 24)
            }
            .padding(.top, 8)
        }
        .navigationTitle(LocalizedStringKey("schedule.setup.title"))
        .navigationBarTitleDisplayMode(.inline)
        .background(Color(.systemGroupedBackground))
        .onAppear {
            viewModel.viewDidAppear()
        }
        .onDisappear {
            viewModel.viewDidDisappear()
        }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)) { _ in
            viewModel.applicationWillResignActive()
        }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.didBecomeActiveNotification)) { _ in
            viewModel.applicationDidBecomeActive()
        }
    }
}

#Preview {
    ScheduleAutomationView()
        .environmentObject(AppState())
}
