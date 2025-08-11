//
//  PurchaseView.swift
//  ToneDown
//
//  Created by Dyuven on 10.08.2025.
//

import SwiftUI

struct PurchaseView: View {
    @EnvironmentObject var appState: AppState
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            VStack(spacing: 32) {
                Spacer()
                
                // Icon
                VStack(spacing: 16) {
                    Image(systemName: "crown.fill")
                        .font(.system(size: 64))
                        .foregroundColor(DS.Color.accent)
                    
                    Text("Premium Автоматизация")
                        .font(.title.weight(.bold))
                        .multilineTextAlignment(.center)
                    
                    Text("Получите полный контроль над автоматизацией")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                }
                
                // Features
                VStack(spacing: 16) {
                    PurchaseFeature(
                        icon: "clock.fill",
                        title: "Автоматическое расписание",
                        description: "Включение/выключение по времени"
                    )
                    
                    PurchaseFeature(
                        icon: "apps.iphone",
                        title: "Smart триггеры приложений",
                        description: "Автоматика для TikTok, Instagram и других"
                    )
                    
                    PurchaseFeature(
                        icon: "moon.zzz.fill",
                        title: "Focus режимы",
                        description: "Интеграция с режимами концентрации"
                    )
                    
                    PurchaseFeature(
                        icon: "location.fill",
                        title: "Геолокация",
                        description: "Автоматизация по местоположению"
                    )
                }
                
                Spacer()
                
                // Purchase button
                VStack(spacing: 12) {
                    Button {
                        // TODO: Implement StoreKit purchase
                        // For now, just simulate purchase
                        appState.purchasePremium()
                        dismiss()
                    } label: {
                        Text("✨ Купить за 999₽")
                            .font(.headline.weight(.semibold))
                            .frame(maxWidth: .infinity)
                            .frame(height: 56)
                            .background(DS.Color.accent)
                            .foregroundColor(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                            .shadow(color: DS.Shadow.soft, radius: 12, x: 0, y: 4)
                    }
                    
                    Text("Одна покупка навсегда • Никаких подписок")
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                }
            }
            .padding(.horizontal, 20)
            .navigationBarItems(
                leading: Button("Закрыть") { dismiss() }
            )
        }
        .navigationViewStyle(.stack)
    }
}

// MARK: - Purchase Feature Component
struct PurchaseFeature: View {
    let icon: String
    let title: String
    let description: String
    
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: icon)
                .font(.title3)
                .foregroundColor(DS.Color.accent)
                .frame(width: 32, height: 32)
                .background(DS.Color.accent.opacity(0.1))
                .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
            
            VStack(spacing: 4) {
                Text(title)
                    .font(.subheadline.weight(.medium))
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text(description)
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            
            Image(systemName: "checkmark.circle.fill")
                .font(.title3)
                .foregroundColor(.green)
        }
        .padding(.vertical, 8)
    }
}

#Preview {
    PurchaseView()
        .environmentObject(AppState())
}
