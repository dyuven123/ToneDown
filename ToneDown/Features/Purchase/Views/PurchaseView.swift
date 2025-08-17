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
                    
                    Text(LocalizedStringKey("purchase.title"))
                        .font(.title.weight(.bold))
                        .multilineTextAlignment(.center)
                    
                    Text(LocalizedStringKey("purchase.subtitle"))
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                }
                
                // Features
                VStack(spacing: 16) {
                    PurchaseFeature(
                        icon: "clock.fill",
                        title: "purchase.feature.schedule.title",
                        description: "purchase.feature.schedule.description"
                    )
                    
                    PurchaseFeature(
                        icon: "apps.iphone",
                        title: "purchase.feature.apps.title",
                        description: "purchase.feature.apps.description"
                    )
                    
                    PurchaseFeature(
                        icon: "moon.zzz.fill",
                        title: "purchase.feature.focus.title",
                        description: "purchase.feature.focus.description"
                    )
                    
                    PurchaseFeature(
                        icon: "location.fill",
                        title: "purchase.feature.location.title",
                        description: "purchase.feature.location.description"
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
                        Text(LocalizedStringKey("purchase.button.buy.price"))
                            .font(.headline.weight(.semibold))
                            .frame(maxWidth: .infinity)
                            .frame(height: 56)
                            .background(DS.Color.accent)
                            .foregroundColor(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                            .shadow(color: DS.Shadow.soft, radius: 12, x: 0, y: 4)
                    }
                    
                    Text(LocalizedStringKey("purchase.footer"))
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                }
            }
            .padding(.horizontal, 20)
            .navigationBarItems(
                leading: Button(LocalizedStringKey("purchase.button.close")) { dismiss() }
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
                Text(LocalizedStringKey(title))
                    .font(.subheadline.weight(.medium))
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text(LocalizedStringKey(description))
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
