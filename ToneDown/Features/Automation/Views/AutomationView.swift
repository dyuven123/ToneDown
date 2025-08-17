//
//  AutomationView.swift
//  ToneDown
//
//  Created by Dyuven on 10.08.2025.
//

import SwiftUI

struct AutomationView: View {
    @StateObject private var viewModel: AutomationViewModel
    @EnvironmentObject var appState: AppState
    @State private var showDemo = false
    @State private var showPurchase = false
    
    init() {
        // ViewModel будет инициализирован в onAppear с AppState
        self._viewModel = StateObject(wrappedValue: AutomationViewModel())
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 0) {
                    // Centered title
                    Text(LocalizedStringKey("automation.view.title"))
                        .font(.largeTitle.weight(.bold))
                        .frame(maxWidth: .infinity)
                        .padding(.top, 16)
                        .padding(.bottom, 12)
                    
                    if appState.hasPremium {
                        if viewModel.hasCreatedBaseCommands {
                            AutomationContent(viewModel: viewModel)
                        } else {
                            BaseCommandsSetupContent(viewModel: viewModel)
                        }
                    } else {
                        FreeUserContent(showDemo: $showDemo, showPurchase: $showPurchase)
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
        .onAppear {
            // Передаем AppState в ViewModel и проверяем статус команд
            viewModel.updateAppState(appState)
            Task {
                await viewModel.refreshCommandsStatus()
            }
        }
        // Убираем ненужные проверки при возвращении в приложение
        // Просто доверяем сохраненному состоянию
    }
}

#Preview {
    AutomationView()
        .environmentObject(AppState())
}
