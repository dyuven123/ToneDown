//
//  AutomationContent.swift
//  ToneDown
//
//  Created by Dyuven on 10.08.2025.
//

import SwiftUI

// MARK: - Base Commands Setup Content
struct BaseCommandsSetupContent: View {
    @ObservedObject var viewModel: AutomationViewModel
    
    // MARK: - Initialization
    init(viewModel: AutomationViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack(spacing: 20) {
            // Header
            VStack(spacing: 12) {
                Text("⚙️")
                    .font(.system(size: 40))
                Text(LocalizedStringKey("automation.content.basic.commands.title"))
                    .font(.title2.weight(.bold))
                Text(LocalizedStringKey("automation.content.basic.commands.subtitle"))
                    .font(.body)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 16)
            }
            
            // Info block
            VStack(alignment: .leading, spacing: 12) {
                HStack(spacing: 10) {
                    Image(systemName: "info.circle.fill")
                        .font(.title3)
                        .foregroundColor(DS.Color.accent)
                    
                    Text(LocalizedStringKey("automation.content.two.shortcuts.title"))
                        .font(.system(size: 15, weight: .semibold, design: .rounded))
                        .foregroundColor(.primary)
                }
                
                Text(LocalizedStringKey("automation.content.two.shortcuts.subtitle"))
                    .font(.system(size: 13, weight: .medium, design: .rounded))
                    .foregroundColor(.secondary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .fixedSize(horizontal: false, vertical: true)
            }
            .padding(.vertical, 16)
            .padding(.horizontal, 16)
            .frame(maxWidth: .infinity)
            .background(
                RoundedRectangle(cornerRadius: 14, style: .continuous)
                    .fill(DS.Color.accent.opacity(0.05))
                    .overlay(
                        RoundedRectangle(cornerRadius: 14, style: .continuous)
                            .stroke(DS.Color.accent.opacity(0.2), lineWidth: 1)
                    )
            )
            .padding(.horizontal, 16)
            
            // Import buttons
            VStack(spacing: 12) {
                Button(action: {
                    Task {
                        await viewModel.importEnableCommand()
                    }
                }) {
                    HStack(spacing: 14) {
                        VStack(alignment: .leading, spacing: 3) {
                            Text(LocalizedStringKey("automation.content.enable.grayscale.title"))
                                .font(.system(size: 15, weight: .semibold, design: .rounded))
                                .foregroundColor(.white)
                            
                            Text(LocalizedStringKey("automation.content.enable.grayscale.subtitle"))
                                .font(.system(size: 13, weight: .medium, design: .rounded))
                                .foregroundColor(.white.opacity(0.8))
                        }
                        
                        Spacer()
                        
                        Image(systemName: "arrow.up.right.square.fill")
                            .font(.subheadline)
                            .foregroundColor(.white)
                    }
                    .padding(.vertical, 16)
                    .padding(.horizontal, 16)
                    .background(
                        LinearGradient(
                            colors: [DS.Color.accent, DS.Color.accent.opacity(0.8)],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
                    .shadow(color: DS.Color.accent.opacity(0.3), radius: 8, x: 0, y: 4)
                }
                .buttonStyle(.plain)
                
                Button(action: {
                    Task {
                        await viewModel.importDisableCommand()
                    }
                }) {
                    HStack(spacing: 14) {
                        VStack(alignment: .leading, spacing: 3) {
                            Text(LocalizedStringKey("automation.content.restore.colors.title"))
                                .font(.system(size: 15, weight: .semibold, design: .rounded))
                                .foregroundColor(.white)
                            
                            Text(LocalizedStringKey("automation.content.restore.colors.subtitle"))
                                .font(.system(size: 13, weight: .medium, design: .rounded))
                                .foregroundColor(.white.opacity(0.8))
                        }
                        
                        Spacer()
                        
                        Image(systemName: "arrow.up.right.square.fill")
                            .font(.subheadline)
                            .foregroundColor(.white)
                    }
                    .padding(.vertical, 16)
                    .padding(.horizontal, 16)
                    .background(
                        LinearGradient(
                            colors: [DS.Color.accent, DS.Color.accent.opacity(0.8)],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
                    .shadow(color: DS.Color.accent.opacity(0.3), radius: 8, x: 0, y: 4)
                }
                .buttonStyle(.plain)
            }
            .padding(.horizontal, 16)
            
            // Confirmation button
            VStack(spacing: 16) {
                // Инструкция для пользователя
                VStack(spacing: 8) {
                    HStack(spacing: 8) {
                        Image(systemName: "arrow.left.arrow.right")
                            .font(.subheadline)
                            .foregroundColor(.blue)
                        Text(LocalizedStringKey("automation.content.important.title"))
                            .font(.subheadline.weight(.semibold))
                            .foregroundColor(.blue)
                    }
                    
                    Text(LocalizedStringKey("automation.content.important.subtitle"))
                        .font(.caption)
                        .foregroundColor(.blue)
                        .multilineTextAlignment(.center)
                }
                .padding(.vertical, 12)
                .padding(.horizontal, 16)
                .background(
                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                        .fill(.blue.opacity(0.1))
                        .overlay(
                            RoundedRectangle(cornerRadius: 12, style: .continuous)
                                .stroke(.blue.opacity(0.3), lineWidth: 1)
                        )
                )
                .padding(.horizontal, 16)
                
                Text(LocalizedStringKey("automation.content.confirm.after.adding"))
                    .font(.subheadline.weight(.medium))
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                
                Button {
                    Task {
                        await viewModel.confirmCommandsCreation()
                    }
                } label: {
                    HStack(spacing: 10) {
                        Image(systemName: "checkmark.circle.fill")
                            .font(.subheadline)
                        Text(LocalizedStringKey("automation.content.commands.created"))
                            .font(.headline.weight(.semibold))
                    }
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 52)
                    .background(
                        LinearGradient(
                            colors: [.green, .green.opacity(0.8)],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
                    .shadow(color: .green.opacity(0.3), radius: 8, x: 0, y: 4)
                }
                .padding(.horizontal, 16)
            }
            .padding(.top, 8)
        }
        .padding(.top, 12)
    }
}

// MARK: - Automation Content (shown after base commands are created)
struct AutomationContent: View {
    @ObservedObject var viewModel: AutomationViewModel
    
    // MARK: - Initialization
    init(viewModel: AutomationViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack(spacing: 24) {
            // Automation grid
            LazyVGrid(columns: [
                GridItem(.flexible(), spacing: 16),
                GridItem(.flexible(), spacing: 16)
            ], spacing: 16) {
                NavigationLink(destination: AppTriggersSetupView()) {
                    ModernAutomationCard(
                        icon: "apps.iphone",
                        title: "automation.content.apps.title",
                        subtitle: "automation.content.apps.subtitle",
                        color: .purple,
                        isEnabled: true
                    )
                }
                .buttonStyle(.plain)
                
                ModernAutomationCard(
                    icon: "clock.fill",
                    title: "automation.content.schedule.title",
                    subtitle: "automation.content.schedule.subtitle",
                    color: .orange,
                    isEnabled: true
                )
                
                ModernAutomationCard(
                    icon: "moon.zzz.fill",
                    title: "Focus",
                    subtitle: "automation.content.focus.subtitle",
                    color: .indigo,
                    isEnabled: true
                )
                
                ModernAutomationCard(
                    icon: "location.fill",
                    title: "automation.content.location.title",
                    subtitle: "automation.content.location.subtitle",
                    color: .green,
                    isEnabled: true
                )
            }
            .padding(.horizontal, 20)
            
            // Quick help
            VStack(spacing: 16) {
                Text(LocalizedStringKey("automation.content.how.to.setup"))
                    .font(.subheadline.weight(.semibold))
                    .foregroundColor(.primary)
                
                Text(LocalizedStringKey("automation.content.instructions"))
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
            }
            .padding(.vertical, 16)
            .padding(.horizontal, 20)
            .background(
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .fill(.ultraThinMaterial)
            )
            .padding(.horizontal, 20)
            
            // Reset commands button
            Button {
                viewModel.resetCommands()
            } label: {
                HStack(spacing: 8) {
                    Image(systemName: "arrow.clockwise")
                        .font(.subheadline)
                    Text(LocalizedStringKey("automation.content.recreate.commands"))
                        .font(.subheadline.weight(.medium))
                }
                .foregroundColor(.secondary)
                .padding(.vertical, 8)
                .padding(.horizontal, 16)
                .background(
                    RoundedRectangle(cornerRadius: 8, style: .continuous)
                        .fill(.secondary.opacity(0.1))
                )
            }
            .padding(.horizontal, 20)
        }
        .padding(.top, 20)
    }
}

// MARK: - Free User Content
struct FreeUserContent: View {
    @Binding var showDemo: Bool
    @Binding var showPurchase: Bool
    
    var body: some View {
        VStack(spacing: 24) {
            // Premium required message
            VStack(spacing: 16) {
                Text("🔒")
                    .font(.system(size: 56))
                Text(LocalizedStringKey("automation.content.premium.required"))
                    .font(.title.weight(.bold))
                Text(LocalizedStringKey("automation.content.premium.description"))
                    .font(.body)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 20)
            }
            
            // Purchase button
            Button {
                showPurchase = true
            } label: {
                HStack(spacing: 12) {
                    Image(systemName: "crown.fill")
                        .font(.title3)
                    Text(LocalizedStringKey("automation.content.get.premium"))
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
                .shadow(color: DS.Color.accent.opacity(0.3), radius: 12, x: 0, y: 6)
            }
            .padding(.horizontal, 20)
            
            // Demo button
            Button {
                showDemo = true
            } label: {
                HStack(spacing: 12) {
                    Image(systemName: "play.circle.fill")
                        .font(.title3)
                    Text(LocalizedStringKey("automation.content.try.demo"))
                        .font(.headline.weight(.semibold))
                }
                .foregroundColor(DS.Color.accent)
                .frame(maxWidth: .infinity)
                .frame(height: 56)
                .background(
                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                        .fill(DS.Color.accent.opacity(0.1))
                )
            }
            .padding(.horizontal, 20)
        }
        .padding(.top, 20)
    }
}

#Preview {
    VStack(spacing: 40) {
        BaseCommandsSetupContent(viewModel: AutomationViewModel())
            .environmentObject(AppState())
        
        Divider()
        
        AutomationContent(viewModel: AutomationViewModel())
            .environmentObject(AppState())
        
        Divider()
        
        FreeUserContent(showDemo: .constant(false), showPurchase: .constant(false))
    }
    .padding()
}
