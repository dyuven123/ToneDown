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
    @State private var showCommandsSetup = false
    // removed AppTriggersView
    
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
                        .sheet(isPresented: $showCommandsSetup) {
                    Group {
                        if #available(iOS 16.0, *) {
                            CommandsSetupView()
                                .presentationDetents([.large])
                                .presentationDragIndicator(.visible)
                        } else {
                            CommandsSetupView()
                        }
                    }
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
            let columns = [GridItem](repeating: GridItem(.flexible(), spacing: 16), count: 2)
            LazyVGrid(columns: columns, spacing: 16) {
                NavigationLink(destination: AppTriggersSetupView(showCommandsSetup: $showCommandsSetup)) {
                    AutomationCard(
                        icon: "apps.iphone",
                        title: L10n.Automation.Feature.apps,
                        subtitle: L10n.Automation.Feature.appsDesc,
                        color: .purple,
                        isEnabled: true,
                        isCompleted: appState.hasCompletedAutomationSetup
                    )
                }
                .disabled(appState.hasCompletedAutomationSetup)
                .buttonStyle(.plain)
                
                AutomationCard(
                    icon: "clock.fill",
                    title: L10n.Automation.Feature.schedule,
                    subtitle: L10n.Automation.Feature.scheduleDesc,
                    color: .orange,
                    isEnabled: true,
                    isCompleted: false
                )
                
                AutomationCard(
                    icon: "moon.zzz.fill",
                    title: L10n.Automation.Feature.focus,
                    subtitle: L10n.Automation.Feature.focusDesc,
                    color: .indigo,
                    isEnabled: true,
                    isCompleted: false
                )
                
                AutomationCard(
                    icon: "location.fill",
                    title: L10n.Automation.Feature.location,
                    subtitle: L10n.Automation.Feature.locationDesc,
                    color: .green,
                    isEnabled: true,
                    isCompleted: false
                )
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
    let isCompleted: Bool
    
    var body: some View {
            VStack(spacing: 12) {
                // Modern icon design
                Image(systemName: icon)
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(.white)
                    .frame(width: 40, height: 40)
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
                VStack(spacing: 8) {
                    HStack {
                        Text(title)
                            .font(.system(size: 14, weight: .semibold, design: .rounded))
                            .foregroundColor(.primary)
                            .multilineTextAlignment(.center)
                            .lineLimit(2)
                            .fixedSize(horizontal: false, vertical: true)
                        
                        if isCompleted {
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundColor(.green)
                                .font(.system(size: 16, weight: .semibold))
                        }
                    }
                    
                    if let subtitle = subtitle {
                        Text(subtitle)
                            .font(.system(size: 10, weight: .medium, design: .rounded))
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.center)
                            .lineLimit(4)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                }
                .padding(.horizontal, 4)
            }
            .frame(maxWidth: .infinity)
            .frame(height: 160)
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
    }

// MARK: - Commands Setup View (отдельный экран для добавления команд)
struct CommandsSetupView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        VStack(spacing: 0) {
            // Custom drag indicator for older iOS versions
            if #available(iOS 16.0, *) {
                // System will show drag indicator automatically
                Spacer()
                    .frame(height: 16)
            } else {
                RoundedRectangle(cornerRadius: 2.5)
                    .fill(Color.secondary.opacity(0.3))
                    .frame(width: 36, height: 5)
                    .padding(.top, 8)
                    .padding(.bottom, 16)
            }
            
            ScrollView {
                VStack(spacing: 24) {
                    // Header
                    VStack(spacing: 12) {
                        Text("⚙️")
                            .font(.system(size: 48))
                        Text(L10n.Automation.CommandsSetup.title)
                            .font(.title2.weight(.semibold))
                        Text(L10n.Automation.CommandsSetup.subtitle)
                            .font(.body)
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.center)
                    }
                    .frame(maxWidth: .infinity)

                    // Info block (moved above buttons)
                    InfoCalloutView(
                        title: L10n.AppTrigger.Hint.twoShortcuts,
                        subtitle: L10n.AppTrigger.Hint.importHint
                    )
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal, 16)

                    // Two import buttons
                    VStack(spacing: 12) {
                        PrimaryFilledButton(icon: "plus.circle.fill", title: L10n.AppTrigger.Button.toneDown, color: DS.Color.accent) {
                            ShortcutsRunner.importBaseEnableCommand()
                        }
                        PrimaryFilledButton(icon: "minus.circle.fill", title: L10n.AppTrigger.Button.toneRestore, color: .secondary) {
                            ShortcutsRunner.importBaseDisableCommand()
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal, 16)
                    
                    // Кнопка подтверждения после установки
                    if !appState.hasCompletedAutomationSetup {
                        VStack(spacing: 16) {
                            Text(L10n.AppTrigger.afterTitle)
                                .font(.subheadline.weight(.medium))
                                .frame(maxWidth: .infinity, alignment: .center)
                            
                            Button {
                                appState.completeAutomationSetup()
                                dismiss()
                            } label: {
                                Text(L10n.AppTrigger.Button.confirm)
                                    .font(.body.weight(.medium))
                                    .frame(maxWidth: .infinity)
                                    .padding(.vertical, 12)
                                    .background(Color.green)
                                    .foregroundColor(.white)
                                    .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.horizontal, 16)
                        }
                        .frame(maxWidth: .infinity)
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 20)
                .padding(.bottom, 20)
            }
        }
        .background(Color(.systemBackground))
    }
}

// MARK: - App Triggers Setup
struct AppTriggersSetupView: View {
    @EnvironmentObject var appState: AppState
    @Binding var showCommandsSetup: Bool
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                // Header
                VStack(spacing: 12) {
                    Text("📱")
                        .font(.system(size: 56))
                    Text(L10n.Automation.AutomationSetup.title)
                        .font(.title.weight(.semibold))
                    Text(L10n.Automation.AutomationSetup.subtitle)
                        .font(.body)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                }
                .padding(.top, 8)

                // Info block
                InfoCalloutView(
                    title: L10n.Automation.AutomationSetup.infoTitle,
                    subtitle: L10n.Automation.AutomationSetup.infoSubtitle
                )
                .padding(.horizontal, 16)
                
                // Кнопка для добавления команд (если еще не добавлены)
                if !appState.hasCompletedAutomationSetup {
                    VStack(spacing: 16) {
                        Text(L10n.Automation.AutomationSetup.commandsFirst)
                            .font(.subheadline.weight(.medium))
                        
                        Button {
                            // Показываем экран добавления команд как bottom sheet
                            showCommandsSetup = true
                        } label: {
                            Text(L10n.Automation.AutomationSetup.buttonAddCommands)
                                .font(.body.weight(.medium))
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 12)
                                .background(DS.Color.accent)
                                .foregroundColor(.white)
                                .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                        }
                        .padding(.horizontal, 20)
                    }
                } else {
                    // Показываем настройки автоматизации
                    VStack(spacing: 16) {
                        Text(L10n.Automation.AutomationSetup.commandsCompleted)
                            .font(.subheadline.weight(.medium))
                        
                        // Здесь будут настройки автоматизации
                        Text(L10n.Automation.AutomationSetup.settingsPlaceholder)
                            .font(.body)
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.center)
                    }
                    .padding(.horizontal, 20)
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 20)
        }
        .navigationTitle(L10n.Automation.AutomationSetup.title)
        .navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: - Subviews extracted to help type-checker
private struct AppTriggersHeader: View {
    var body: some View {
        VStack(spacing: 8) {
            Text(L10n.AppTrigger.subtitle)
                .font(.title3.weight(.semibold))
                .multilineTextAlignment(.center)
            Text(L10n.AppTrigger.description)
                .font(.footnote)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
        .padding(20)
        .background(
            LinearGradient(colors: [DS.Color.accent.opacity(0.15), DS.Color.accent.opacity(0.05)], startPoint: .topLeading, endPoint: .bottomTrailing)
        )
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .stroke(DS.Color.accent.opacity(0.2), lineWidth: 0.5)
        )
    }
}

private struct InfoCalloutView: View {
    let title: String
    let subtitle: String
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Image(systemName: "info.circle.fill").foregroundColor(DS.Color.accent)
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.subheadline.weight(.semibold))
                Text(subtitle)
                    .font(.footnote)
                    .foregroundColor(.secondary)
            }
        }
        .padding(12)
        .background(
            RoundedRectangle(cornerRadius: 14, style: .continuous)
                .fill(Color(.secondarySystemBackground))
        )
    }
}

private struct CommandsImportSection: View {
    var body: some View {
        VStack(spacing: 12) {
            PrimaryFilledButton(icon: "plus.circle.fill", title: L10n.AppTrigger.Button.toneDown, color: DS.Color.accent) {
                ShortcutsRunner.importBaseEnableCommand()
            }
            PrimaryFilledButton(icon: "minus.circle.fill", title: L10n.AppTrigger.Button.toneRestore, color: .secondary) {
                ShortcutsRunner.importBaseDisableCommand()
            }
        }
    }
}

private struct AppsSection: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(L10n.AppTrigger.Section.apps)
                .font(.subheadline.weight(.semibold))
            
            VStack(alignment: .leading, spacing: 8) {
                Text("Instagram • TikTok • YouTube")
                    .font(.footnote)
                    .foregroundColor(.secondary)
                
                SecondaryOutlineButton(icon: "arrow.up.right.square.fill", title: L10n.AppTrigger.Actions.openShortcuts) {
                    ShortcutsRunner.openShortcutsApp()
                }
            }
        }
    }
}

private struct PrimaryFilledButton: View {
    let icon: String
    let title: String
    let color: Color
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 10) {
                Image(systemName: icon)
                Text(title)
                    .font(.headline.weight(.semibold))
            }
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .frame(height: 52)
            .background(color)
            .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
        }
    }
}

private struct SecondaryOutlineButton: View {
    let icon: String
    let title: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 8) {
                Image(systemName: icon)
                Text(title)
                    .font(.subheadline.weight(.semibold))
            }
            .foregroundColor(DS.Color.accent)
            .frame(maxWidth: .infinity)
            .frame(height: 44)
            .background(DS.Color.accent.opacity(0.12))
            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
        }
    }
}

private struct ImportAppButton: View {
    let appName: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(appName)
                .font(.footnote.weight(.semibold))
                .foregroundColor(.white)
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
                .background(DS.Color.accent)
                .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
        }
        .buttonStyle(.plain)
    }
}

private struct AppImportRow: View {
    let appName: String
    let onEnable: () -> Void
    let onDisable: () -> Void
    
    var body: some View {
        HStack(spacing: 8) {
            Text(appName)
                .font(.footnote.weight(.semibold))
                .frame(width: 90, alignment: .leading)
            
            ImportAppButton(appName: L10n.AppTrigger.Button.enable) {
                onEnable()
            }
            ImportAppButton(appName: L10n.AppTrigger.Button.disable) {
                onDisable()
            }
        }
    }
}

#Preview {
    AutomationView()
        .environmentObject(AppState())
}
