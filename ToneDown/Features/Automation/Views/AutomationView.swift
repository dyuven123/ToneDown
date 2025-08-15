//
//  AutomationView.swift
//  ToneDown
//
//  Created by Dyuven on 10.08.2025.
//

import SwiftUI

struct AutomationView: View {
    @StateObject private var viewModel = AutomationViewModel()
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
            // Инициализируем ViewModel при появлении экрана
        }
    }
}

#Preview {
    AutomationView()
        .environmentObject(AppState())
}
