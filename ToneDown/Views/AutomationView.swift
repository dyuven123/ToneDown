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
                VStack(spacing: 24) {
                    // Header
                    headerSection
                    
                    if appState.hasPremium {
                        // Premium content - настройки автоматизации
                        premiumContent
                    } else {
                        // Free user content - upsell
                        freeUserContent
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, 16)
            }
            .navigationTitle(L10n.Automation.title)
            .navigationBarTitleDisplayMode(.large)
        }
        .navigationViewStyle(.stack)
        .sheet(isPresented: $showDemo) {
            DemoView()
        }
        .sheet(isPresented: $showPurchase) {
            PurchaseView()
        }
    }
    
    // MARK: - Header Section
    private var headerSection: some View {
        VStack(spacing: 12) {
            HStack {
                Image(systemName: "wand.and.stars")
                    .font(.title2)
                    .foregroundColor(DS.Color.accent)
                
                Text(L10n.Automation.subtitle)
                    .font(.headline.weight(.medium))
                    .foregroundColor(.primary)
                
                Spacer()
                
                if appState.hasPremium {
                    premiumBadge
                }
            }
            
            Text(L10n.Automation.description)
                .font(.subheadline)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(.vertical, 16)
        .padding(.horizontal, 20)
        .background(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .fill(.ultraThinMaterial)
        )
    }
    
    // MARK: - Premium Badge
    private var premiumBadge: some View {
        HStack(spacing: 6) {
            Image(systemName: "crown.fill")
                .font(.caption)
            Text("Premium")
                .font(.caption.weight(.medium))
        }
        .foregroundColor(.white)
        .padding(.horizontal, 12)
        .padding(.vertical, 6)
        .background(
            LinearGradient(
                colors: [DS.Color.accent, DS.Color.accent.opacity(0.8)],
                startPoint: .leading,
                endPoint: .trailing
            )
        )
        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
    }
    
    // MARK: - Premium Content
    private var premiumContent: some View {
        VStack(spacing: 20) {
            // Automation categories
            automationCategories
        }
    }
    
    // MARK: - Free User Content
    private var freeUserContent: some View {
        VStack(spacing: 24) {
            // Demo preview
            demoPreview
            
            // Features list
            featuresList
            
            // Purchase CTA
            purchaseCTA
        }
    }
    
    // MARK: - Demo Preview
    private var demoPreview: some View {
        VStack(spacing: 16) {
            Text(L10n.Automation.demoTitle)
                .font(.title2.weight(.semibold))
                .multilineTextAlignment(.center)
            
            Button {
                showDemo = true
            } label: {
                HStack(spacing: 12) {
                    Image(systemName: "play.circle.fill")
                        .font(.title3)
                    Text(L10n.Premium.Button.demo)
                        .font(.headline.weight(.medium))
                }
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .frame(height: 52)
                .background(DS.Color.accent)
                .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                .shadow(color: DS.Shadow.soft, radius: 8, x: 0, y: 4)
            }
        }
        .padding(.vertical, 20)
        .padding(.horizontal, 20)
        .background(
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(DS.Color.accent.opacity(0.05))
                .overlay(
                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                        .stroke(DS.Color.accent.opacity(0.2), lineWidth: 1)
                )
        )
    }
    
    // MARK: - Features List
    private var featuresList: some View {
        VStack(spacing: 16) {
            Text(L10n.Automation.featuresTitle)
                .font(.title3.weight(.semibold))
                .frame(maxWidth: .infinity, alignment: .leading)
            
            VStack(spacing: 12) {
                FeatureRow(
                    icon: "clock.fill",
                    title: L10n.Automation.Feature.schedule,
                    description: L10n.Automation.Feature.scheduleDesc,
                    color: .orange
                )
                
                FeatureRow(
                    icon: "apps.iphone",
                    title: L10n.Automation.Feature.apps,
                    description: L10n.Automation.Feature.appsDesc,
                    color: .purple
                )
                
                FeatureRow(
                    icon: "moon.zzz.fill",
                    title: L10n.Automation.Feature.focus,
                    description: L10n.Automation.Feature.focusDesc,
                    color: .indigo
                )
                
                FeatureRow(
                    icon: "location.fill",
                    title: L10n.Automation.Feature.location,
                    description: L10n.Automation.Feature.locationDesc,
                    color: .green
                )
            }
        }
    }
    
    // MARK: - Purchase CTA
    private var purchaseCTA: some View {
        VStack(spacing: 16) {
            VStack(spacing: 8) {
                Text(L10n.Demo.priceDetails)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                
                Text(L10n.Automation.noSubscriptions)
                    .font(.caption.weight(.medium))
                    .foregroundColor(DS.Color.accent)
            }
            
            Button {
                showPurchase = true
            } label: {
                HStack(spacing: 8) {
                    Image(systemName: "crown.fill")
                        .font(.headline)
                    Text(L10n.Demo.Button.buy)
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
                .shadow(color: DS.Shadow.soft, radius: 12, x: 0, y: 6)
            }
        }
        .padding(.bottom, 20)
    }
    
    // MARK: - Automation Categories (Premium)
    private var automationCategories: some View {
        VStack(spacing: 16) {
            Text("Настройки автоматизации")
                .font(.title3.weight(.semibold))
                .frame(maxWidth: .infinity, alignment: .leading)
            
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 16), count: 2), spacing: 16) {
                AutomationCard(
                    icon: "clock.fill",
                    title: "Расписание",
                    subtitle: "По времени",
                    color: .orange,
                    isEnabled: true
                ) {
                    // Navigate to schedule settings
                }
                
                AutomationCard(
                    icon: "apps.iphone",
                    title: "Приложения",
                    subtitle: "Smart triggers",
                    color: .purple,
                    isEnabled: true
                ) {
                    // Navigate to app triggers
                }
                
                AutomationCard(
                    icon: "moon.zzz.fill",
                    title: "Focus режимы",
                    subtitle: "Интеграция",
                    color: .indigo,
                    isEnabled: true
                ) {
                    // Navigate to focus modes
                }
                
                AutomationCard(
                    icon: "location.fill",
                    title: "Геолокация",
                    subtitle: "По местам",
                    color: .green,
                    isEnabled: true
                ) {
                    // Navigate to location settings
                }
            }
        }
    }
}

// MARK: - Feature Row Component
struct FeatureRow: View {
    let icon: String
    let title: String
    let description: String
    let color: Color
    
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: icon)
                .font(.title3)
                .foregroundColor(color)
                .frame(width: 32, height: 32)
                .background(color.opacity(0.1))
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
            
            Image(systemName: "lock.fill")
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .padding(.vertical, 8)
    }
}

// MARK: - Automation Card Component
struct AutomationCard: View {
    let icon: String
    let title: String
    let subtitle: String
    let color: Color
    let isEnabled: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 12) {
                Image(systemName: icon)
                    .font(.title2)
                    .foregroundColor(color)
                    .frame(width: 40, height: 40)
                    .background(color.opacity(0.1))
                    .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                
                VStack(spacing: 4) {
                    Text(title)
                        .font(.subheadline.weight(.medium))
                        .foregroundColor(.primary)
                    
                    Text(subtitle)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
            .frame(maxWidth: .infinity)
            .frame(height: 120)
            .background(.ultraThinMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .stroke(color.opacity(0.2), lineWidth: 1)
            )
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    AutomationView()
        .environmentObject(AppState())
}
