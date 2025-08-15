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
        VStack(spacing: 32) {
            // Header
            VStack(spacing: 16) {
                Text("⚙️")
                    .font(.system(size: 56))
                Text("Создание базовых команд")
                    .font(.title.weight(.bold))
                Text("Сначала создайте команды для включения и выключения серого режима")
                    .font(.body)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 20)
            }
            
            // Info block
            VStack(alignment: .leading, spacing: 16) {
                HStack(spacing: 12) {
                    Image(systemName: "info.circle.fill")
                        .font(.title2)
                        .foregroundColor(DS.Color.accent)
                    
                    Text("Два шортката")
                        .font(.system(size: 16, weight: .semibold, design: .rounded))
                        .foregroundColor(.primary)
                }
                
                Text("Импортируйте готовые команды для управления серым режимом")
                    .font(.system(size: 14, weight: .medium, design: .rounded))
                    .foregroundColor(.secondary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .fixedSize(horizontal: false, vertical: true)
            }
            .padding(.vertical, 20)
            .padding(.horizontal, 20)
            .frame(maxWidth: .infinity)
            .background(
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .fill(DS.Color.accent.opacity(0.05))
                    .overlay(
                        RoundedRectangle(cornerRadius: 16, style: .continuous)
                            .stroke(DS.Color.accent.opacity(0.2), lineWidth: 1)
                    )
            )
            .padding(.horizontal, 20)
            
            // Import buttons
            VStack(spacing: 16) {
                Button(action: {
                    Task {
                        await viewModel.importEnableCommand()
                    }
                }) {
                    HStack(spacing: 16) {
                        Image(systemName: "plus.circle.fill")
                            .font(.title2)
                            .foregroundColor(DS.Color.accent)
                            .frame(width: 32, height: 32)
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Включить серый режим")
                                .font(.system(size: 16, weight: .semibold, design: .rounded))
                                .foregroundColor(.primary)
                            
                            Text("Команда для активации")
                                .font(.system(size: 14, weight: .medium, design: .rounded))
                                .foregroundColor(.secondary)
                        }
                        
                        Spacer()
                        
                        Image(systemName: "arrow.up.right.square.fill")
                            .font(.title3)
                            .foregroundColor(DS.Color.accent)
                    }
                    .padding(.vertical, 20)
                    .padding(.horizontal, 20)
                    .background(
                        RoundedRectangle(cornerRadius: 16, style: .continuous)
                            .fill(.ultraThinMaterial)
                            .overlay(
                                RoundedRectangle(cornerRadius: 16, style: .continuous)
                                    .stroke(DS.Color.accent.opacity(0.2), lineWidth: 1)
                            )
                    )
                }
                .buttonStyle(.plain)
                
                Button(action: {
                    Task {
                        await viewModel.importDisableCommand()
                    }
                }) {
                    HStack(spacing: 16) {
                        Image(systemName: "minus.circle.fill")
                            .font(.title2)
                            .foregroundColor(.secondary)
                            .frame(width: 32, height: 32)
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Восстановить цвета")
                                .font(.system(size: 16, weight: .semibold, design: .rounded))
                                .foregroundColor(.primary)
                            
                            Text("Команда для деактивации")
                                .font(.system(size: 14, weight: .medium, design: .rounded))
                                .foregroundColor(.secondary)
                        }
                        
                        Spacer()
                        
                        Image(systemName: "arrow.up.right.square.fill")
                            .font(.title3)
                            .foregroundColor(.secondary)
                    }
                    .padding(.vertical, 20)
                    .padding(.horizontal, 20)
                    .background(
                        RoundedRectangle(cornerRadius: 16, style: .continuous)
                            .fill(.ultraThinMaterial)
                            .overlay(
                                RoundedRectangle(cornerRadius: 16, style: .continuous)
                                    .stroke(.secondary.opacity(0.2), lineWidth: 1)
                            )
                    )
                }
                .buttonStyle(.plain)
            }
            .padding(.horizontal, 20)
            
            // Confirmation button
            VStack(spacing: 16) {
                Text("После добавления команд подтвердите создание")
                    .font(.subheadline.weight(.medium))
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                
                Button {
                    viewModel.confirmCommandsCreation()
                } label: {
                    HStack(spacing: 12) {
                        Image(systemName: "checkmark.circle.fill")
                            .font(.title3)
                        Text("Команды созданы")
                            .font(.headline.weight(.semibold))
                    }
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 56)
                    .background(
                        LinearGradient(
                            colors: [.green, .green.opacity(0.8)],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                    .shadow(color: .green.opacity(0.3), radius: 12, x: 0, y: 6)
                }
                .padding(.horizontal, 20)
            }
            .padding(.top, 16)
        }
        .padding(.top, 20)
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
            // Success message
            VStack(spacing: 16) {
                HStack(spacing: 12) {
                    Image(systemName: "checkmark.circle.fill")
                        .font(.title2)
                        .foregroundColor(.green)
                    VStack(alignment: .leading, spacing: 2) {
                        Text("Базовые команды созданы!")
                            .font(.headline.weight(.semibold))
                            .foregroundColor(.green)
                        Text("Теперь вы можете настроить автоматизацию")
                            .font(.caption)
                            .foregroundColor(.green.opacity(0.8))
                    }
                }
                .padding(.vertical, 12)
                .padding(.horizontal, 16)
                .background(
                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                        .fill(.green.opacity(0.1))
                )
            }
            .padding(.horizontal, 20)
            
            // Automation grid
            LazyVGrid(columns: [
                GridItem(.flexible(), spacing: 16),
                GridItem(.flexible(), spacing: 16)
            ], spacing: 16) {
                NavigationLink(destination: AppTriggersSetupView()) {
                    ModernAutomationCard(
                        icon: "apps.iphone",
                        title: "Приложения",
                        subtitle: "Автоматическое включение при открытии",
                        color: .purple,
                        isEnabled: true
                    )
                }
                .buttonStyle(.plain)
                
                ModernAutomationCard(
                    icon: "clock.fill",
                    title: "Расписание",
                    subtitle: "По времени суток",
                    color: .orange,
                    isEnabled: true
                )
                
                ModernAutomationCard(
                    icon: "moon.zzz.fill",
                    title: "Focus",
                    subtitle: "Интеграция с системой",
                    color: .indigo,
                    isEnabled: true
                )
                
                ModernAutomationCard(
                    icon: "location.fill",
                    title: "Геолокация",
                    subtitle: "По месту нахождения",
                    color: .green,
                    isEnabled: true
                )
            }
            .padding(.horizontal, 20)
            
            // Quick help
            VStack(spacing: 16) {
                Text("💡 Как настроить автоматизацию?")
                    .font(.subheadline.weight(.semibold))
                    .foregroundColor(.primary)
                
                Text("Выберите тип автоматизации и следуйте инструкциям. Все автоматизации будут использовать созданные вами базовые команды.")
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
                    Text("Пересоздать команды")
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
                Text("Требуется Premium")
                    .font(.title.weight(.bold))
                Text("Автоматизация доступна только для Premium пользователей")
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
                    Text("Получить Premium")
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
                    Text("Попробовать демо")
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
