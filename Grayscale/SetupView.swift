//
//  SetupView.swift
//  Grayscale
//
//  Created by Dyuven on 10.08.2025.
//

import SwiftUI

struct SetupView: View {
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationView {
            VStack(spacing: 32) {
                
                Spacer()
                
                // Центральная кнопка создания ярлыка
                VStack(spacing: 16) {
                    Text("🚀")
                        .font(.system(size: 64))
                    
                    Text("Создать ярлык")
                        .font(.title.weight(.semibold))
                    
                    Text("Откроет готовый ярлык\nдля импорта одним нажатием")
                        .font(.body)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                }
                
                Button("Добавить ярлык") {
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
                    
                    Text("Откроется экран импорта готового ярлыка\nтебе нужно будет только нажать \"Добавить\"")
                        .font(.footnote)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                }
                .padding(.bottom, 20)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .navigationTitle("Настройка")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing: Button("Готово") { dismiss() })
        }
        .navigationViewStyle(.stack)
    }
}
