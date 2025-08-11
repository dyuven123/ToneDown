//
//  SetupView.swift
//  ToneDown
//
//  Created by Dyuven on 10.08.2025.
//

import SwiftUI

struct SetupView: View {
    @EnvironmentObject var appState: AppState
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationView {
            VStack(spacing: 32) {
                
                Spacer()
                
                // Центральная кнопка создания команды
                VStack(spacing: 16) {
                    Text("🚀")
                        .font(.system(size: 64))
                    
                    Text("Создать команду")
                        .font(.title.weight(.semibold))
                    
                    Text("Откроет готовую команду\nдля импорта одним нажатием")
                        .font(.body)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                }
                
                Button("Добавить команду") {
                    ShortcutsRunner.createToggleGrayscaleShortcut()
                } 
                .font(.title2.weight(.semibold))
                .frame(maxWidth: .infinity)
                .frame(height: 56)
                .background(DS.Color.accent)
                .foregroundColor(.white)
                .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                .shadow(color: DS.Shadow.soft, radius: 12, x: 0, y: 4)
                .padding(.horizontal, 20)
                
                Spacer()
                
                // Инструкция
                VStack(spacing: 8) {
                    Text("💡 **Что произойдет:**")
                        .font(.subheadline.weight(.medium))
                    
                    Text("Откроется экран импорта готовой команды\nтебе нужно будет только нажать \"Добавить\"")
                        .font(.footnote)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                }
                
                // Кнопка подтверждения после установки
                if !appState.hasCompletedSetup {
                    VStack(spacing: 16) {
                        Text("После добавления команды:")
                            .font(.subheadline.weight(.medium))
                        
                        Button {
                            appState.completeSetup()
                            dismiss()
                        } label: {
                            Text("✅ Я добавил команду")
                                .font(.body.weight(.medium))
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 12)
                                .background(Color.green)
                                .foregroundColor(.white)
                                .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                        }
                        .padding(.horizontal, 20)
                    }
                }
                
                Spacer(minLength: 20)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .navigationTitle("Настройка")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing: Button("Готово") { dismiss() })
        }
        .navigationViewStyle(.stack)
    }
}
