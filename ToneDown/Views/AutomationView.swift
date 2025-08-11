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
    @State private var showAppTriggers = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 24) {
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
            .navigationBarTitleDisplayMode(.inline)
        }
        .navigationViewStyle(.stack)
        .sheet(isPresented: $showDemo) {
            DemoView()
        }
        .sheet(isPresented: $showPurchase) {
            PurchaseView()
        }
        .sheet(isPresented: $showAppTriggers) {
            AppTriggersView()
        }
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
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 16), count: 2), spacing: 16) {
                AutomationCard(
                    icon: "apps.iphone",
                    title: L10n.Automation.Feature.apps,
                    subtitle: L10n.Automation.Feature.appsDesc,
                    color: .purple,
                    isEnabled: true
                ) {
                    showAppTriggers = true
                }
                
                AutomationCard(
                    icon: "clock.fill",
                    title: L10n.Automation.Feature.schedule,
                    subtitle: L10n.Automation.Feature.scheduleDesc,
                    color: .orange,
                    isEnabled: true
                ) {
                    // Navigate to schedule settings
                }
                
                AutomationCard(
                    icon: "moon.zzz.fill",
                    title: L10n.Automation.Feature.focus,
                    subtitle: L10n.Automation.Feature.focusDesc,
                    color: .indigo,
                    isEnabled: true
                ) {
                    // Navigate to focus modes
                }
                
                AutomationCard(
                    icon: "location.fill",
                    title: L10n.Automation.Feature.location,
                    subtitle: L10n.Automation.Feature.locationDesc,
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
    let subtitle: String?
    let color: Color
    let isEnabled: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 14) {
                // Modern icon design
                Image(systemName: icon)
                    .font(.system(size: 24, weight: .semibold))
                    .foregroundColor(.white)
                    .frame(width: 48, height: 48)
                    .background(
                        LinearGradient(
                            colors: [color, color.opacity(0.8)],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
                    .shadow(color: color.opacity(0.3), radius: 8, x: 0, y: 4)
                
                // Title and subtitle with better spacing
                VStack(spacing: 6) {
                    Text(title)
                        .font(.system(size: 15, weight: .semibold, design: .rounded))
                        .foregroundColor(.primary)
                        .multilineTextAlignment(.center)
                        .lineLimit(1)
                    
                    if let subtitle = subtitle {
                        Text(subtitle)
                            .font(.system(size: 12, weight: .medium, design: .rounded))
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.center)
                            .lineLimit(2)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                }
                .padding(.horizontal, 8)
            }
            .frame(maxWidth: .infinity)
            .frame(height: 130)
            .background(
                RoundedRectangle(cornerRadius: 18, style: .continuous)
                    .fill(.ultraThinMaterial)
                    .overlay(
                        RoundedRectangle(cornerRadius: 18, style: .continuous)
                            .stroke(Color(.separator).opacity(0.3), lineWidth: 0.5)
                    )
            )
            .shadow(color: Color.black.opacity(0.04), radius: 8, x: 0, y: 2)
        }
        .buttonStyle(CardButtonStyle())
    }
}

// MARK: - Card Button Style
struct CardButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.96 : 1.0)
            .animation(.easeInOut(duration: 0.1), value: configuration.isPressed)
    }
}

#Preview {
    AutomationView()
        .environmentObject(AppState())
}
