//
//  AppTriggersView.swift
//  ToneDown
//
//  Created by Dyuven on 10.08.2025.
//

import SwiftUI

struct AppTriggersView: View {
    @EnvironmentObject var appState: AppState
    @Environment(\.dismiss) private var dismiss
    @State private var appTriggers: [AppTrigger] = AppTrigger.popularApps
    @State private var selectedCategory: AppTrigger.AppCategory? = nil
    
    // Filtered apps based on selected category
    private var filteredApps: [AppTrigger] {
        if let category = selectedCategory {
            return appTriggers.filter { $0.category == category }
        }
        return appTriggers
    }
    
    // Active triggers count
    private var activeCount: Int {
        appTriggers.filter { $0.isEnabled }.count
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Header with stats
                headerSection
                
                // Category filters
                categoryFilterSection
                
                // Apps list
                ScrollView {
                    LazyVStack(spacing: 12) {
                        ForEach(filteredApps) { app in
                            AppTriggerRow(
                                app: app,
                                isEnabled: binding(for: app)
                            )
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 16)
                    .padding(.bottom, 100) // Space for floating button
                }
                
                Spacer()
            }
            .navigationTitle(L10n.AppTrigger.title)
            .navigationBarTitleDisplayMode(.large)
            .navigationBarItems(
                trailing: Button(L10n.Button.close) { dismiss() }
            )
            .overlay(alignment: .bottom) {
                // Floating info/save button
                floatingButton
            }
            .onAppear {
                loadUserSettings()
            }
        }
        .navigationViewStyle(.stack)
    }
    
    // MARK: - Header Section
    private var headerSection: some View {
        VStack(spacing: 12) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(L10n.AppTrigger.subtitle)
                        .font(.headline.weight(.medium))
                        .foregroundColor(.primary)
                    
                    Text(L10n.AppTrigger.description)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                
                Spacer()
                
                // Active count badge
                VStack(spacing: 4) {
                    Text("\(activeCount)")
                        .font(.title2.weight(.bold))
                        .foregroundColor(DS.Color.accent)
                    
                    Text(L10n.AppTrigger.activeCount)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(.ultraThinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 16)
        .background(.ultraThinMaterial)
    }
    
    // MARK: - Category Filter Section
    private var categoryFilterSection: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                // All categories button
                CategoryFilterButton(
                    title: L10n.AppTrigger.Category.all,
                    color: .gray,
                    isSelected: selectedCategory == nil
                ) {
                    selectedCategory = nil
                }
                
                // Individual category buttons
                ForEach(AppTrigger.AppCategory.allCases, id: \.self) { category in
                    CategoryFilterButton(
                        title: category.displayName,
                        color: category.color,
                        isSelected: selectedCategory == category
                    ) {
                        selectedCategory = selectedCategory == category ? nil : category
                    }
                }
            }
            .padding(.horizontal, 20)
        }
        .padding(.vertical, 12)
    }
    
    // MARK: - Floating Button
    private var floatingButton: some View {
        VStack(spacing: 12) {
            if activeCount > 0 {
                Text(L10n.AppTrigger.activeInfo(activeCount))
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
            }
            
            Button {
                saveSettings()
                dismiss()
            } label: {
                HStack(spacing: 8) {
                    Image(systemName: "checkmark.circle.fill")
                        .font(.headline)
                    Text(activeCount > 0 ? L10n.AppTrigger.Button.save : L10n.AppTrigger.Button.close)
                        .font(.headline.weight(.semibold))
                }
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .frame(height: 52)
                .background(
                    LinearGradient(
                        colors: [DS.Color.accent, DS.Color.accent.opacity(0.8)],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
                .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                .shadow(color: DS.Shadow.soft, radius: 12, x: 0, y: 4)
            }
        }
        .padding(.horizontal, 20)
        .padding(.bottom, 20)
        .background(
            LinearGradient(
                colors: [.clear, Color(.systemBackground).opacity(0.8), Color(.systemBackground)],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea(edges: .bottom)
        )
    }
    
    // MARK: - Helper Methods
    private func binding(for app: AppTrigger) -> Binding<Bool> {
        Binding(
            get: { 
                appTriggers.first { $0.id == app.id }?.isEnabled ?? false
            },
            set: { newValue in
                if let index = appTriggers.firstIndex(where: { $0.id == app.id }) {
                    appTriggers[index].isEnabled = newValue
                }
            }
        )
    }
    
    private func loadUserSettings() {
        // TODO: Load from UserDefaults or AppState
        // For now, use default values
    }
    
    private func saveSettings() {
        // TODO: Save to UserDefaults or AppState
        // For now, just print active apps
        let activeApps = appTriggers.filter { $0.isEnabled }
        print("Active app triggers: \(activeApps.map { $0.name })")
    }
}

// MARK: - App Trigger Row Component
struct AppTriggerRow: View {
    let app: AppTrigger
    @Binding var isEnabled: Bool
    
    var body: some View {
        HStack(spacing: 16) {
            // App icon
            Image(systemName: app.iconName)
                .font(.title3)
                .foregroundColor(app.category.color)
                .frame(width: 32, height: 32)
                .background(app.category.color.opacity(0.1))
                .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
            
            // App info
            VStack(alignment: .leading, spacing: 4) {
                Text(app.name)
                    .font(.subheadline.weight(.medium))
                    .foregroundColor(.primary)
                
                Text(app.category.displayName)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            // Toggle
            Toggle("", isOn: $isEnabled)
                .labelsHidden()
                .tint(DS.Color.accent)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .fill(.ultraThinMaterial)
                .overlay(
                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                        .stroke(isEnabled ? DS.Color.accent.opacity(0.3) : Color.clear, lineWidth: 1)
                )
        )
        .animation(.easeInOut(duration: 0.2), value: isEnabled)
    }
}

// MARK: - Category Filter Button Component
struct CategoryFilterButton: View {
    let title: String
    let color: Color
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.subheadline.weight(isSelected ? .semibold : .medium))
                .foregroundColor(isSelected ? .white : color)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(
                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                        .fill(isSelected ? color : color.opacity(0.1))
                )
        }
        .animation(.easeInOut(duration: 0.2), value: isSelected)
    }
}

#Preview {
    AppTriggersView()
        .environmentObject(AppState())
}
