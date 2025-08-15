//
//  DemoView.swift
//  ToneDown
//
//  Created by Dyuven on 10.08.2025.
//

import SwiftUI

struct DemoView: View {
    @EnvironmentObject var appState: AppState
    @Environment(\.dismiss) private var dismiss
    @State private var currentStep = 0
    @State private var isAnimating = false
    @State private var phoneColor: Color = .primary
    @State private var isTransitioning = false
    @State private var showAppContent = false
    @State private var autoPlayTimer: Timer?
    
    private let demoSteps = [
        DemoStep(
            title: L10n.Demo.Scenario.TikTok.title,
            subtitle: L10n.Demo.Scenario.TikTok.subtitle,
            description: L10n.Demo.Scenario.TikTok.description,
            icon: "play.rectangle.fill",
            appName: L10n.Demo.App.tiktok,
            isGrayscale: true
        ),
        DemoStep(
            title: L10n.Demo.Scenario.Exit.title,
            subtitle: L10n.Demo.Scenario.Exit.subtitle,
            description: L10n.Demo.Scenario.Exit.description,
            icon: "house.fill",
            appName: L10n.Demo.App.home,
            isGrayscale: false
        ),
        DemoStep(
            title: L10n.Demo.Scenario.Work.title,
            subtitle: L10n.Demo.Scenario.Work.subtitle,
            description: L10n.Demo.Scenario.Work.description,
            icon: "briefcase.fill",
            appName: L10n.Demo.App.work,
            isGrayscale: true
        ),
        DemoStep(
            title: L10n.Demo.Scenario.Sleep.title,
            subtitle: L10n.Demo.Scenario.Sleep.subtitle,
            description: L10n.Demo.Scenario.Sleep.description,
            icon: "moon.fill",
            appName: L10n.Demo.App.sleep,
            isGrayscale: true
        )
    ]
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Header - увеличенный
                VStack(spacing: 10) {
                    Text(L10n.Demo.title)
                        .font(.title.weight(.bold))
                        .multilineTextAlignment(.center)
                    
                    Text(L10n.Demo.subtitle)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                        .lineLimit(2)
                        .fixedSize(horizontal: false, vertical: true)
                }
                .padding(.horizontal, 20)
                .padding(.top, 20)
                .padding(.bottom, 16)
                
                // Main content area
                VStack(spacing: 20) {
                    // Phone Mockup - компактный размер
                    phoneDemo
                    
                    // Steps - компактные
                    stepContent
                    
                    // Controls - компактные
                    controlButtons
                }
                .padding(.horizontal, 20)
                
                Spacer(minLength: 16)
                
                // CTA Button - встроенная
                compactCtaButton
            }
        }
        .navigationViewStyle(.stack)
        .onAppear {
            startDemo()
        }
        .onDisappear {
            autoPlayTimer?.invalidate()
        }
    }
    
    // MARK: - Phone Demo
    private var phoneDemo: some View {
        let currentDemo = demoSteps[currentStep]
        
        return ZStack {
            // Phone frame with subtle shadow - компактный размер
            RoundedRectangle(cornerRadius: 28, style: .continuous)
                .fill(Color.black.opacity(0.1))
                .frame(width: 180, height: 360)
                .blur(radius: 6)
                .offset(y: 3)
            
            RoundedRectangle(cornerRadius: 28, style: .continuous)
                .stroke(Color.secondary.opacity(0.2), lineWidth: 2)
                .frame(width: 176, height: 356)
                .background(
                    RoundedRectangle(cornerRadius: 28, style: .continuous)
                        .fill(.ultraThinMaterial)
                )
            
            // Screen with grayscale filter animation - компактный
            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .fill(.white)
                .frame(width: 160, height: 340)
                .overlay(
                    RoundedRectangle(cornerRadius: 24, style: .continuous)
                        .fill(currentDemo.isGrayscale ? Color.black.opacity(0.1) : Color.clear)
                        .animation(.easeInOut(duration: 1.2), value: currentDemo.isGrayscale)
                )
                .saturation(currentDemo.isGrayscale ? 0.0 : 1.0)
                .animation(.easeInOut(duration: 1.2), value: currentDemo.isGrayscale)
            
            // Content overlay with realistic animations - компактный
            VStack(spacing: 0) {
                // Status bar
                statusBar(isGrayscale: currentDemo.isGrayscale)
                
                Spacer()
                
                // App content with transitions
                if showAppContent {
                    appContentView(for: currentDemo)
                        .transition(.asymmetric(
                            insertion: .scale.combined(with: .opacity),
                            removal: .scale.combined(with: .opacity)
                        ))
                }
                
                Spacer()
                
                // Home indicator
                homeIndicator(isGrayscale: currentDemo.isGrayscale)
            }
            .frame(width: 160, height: 340)
            .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
        }
        .scaleEffect(isTransitioning ? 0.98 : 1.0)
        .animation(.spring(response: 0.6, dampingFraction: 0.8), value: isTransitioning)
    }
    
    // MARK: - Status Bar
    private func statusBar(isGrayscale: Bool) -> some View {
        HStack {
            Text("9:41")
                .font(.caption.weight(.semibold))
            Spacer()
            HStack(spacing: 4) {
                Image(systemName: "signal")
                    .font(.caption2)
                Image(systemName: "wifi")
                    .font(.caption2)
                Image(systemName: "battery.100")
                    .font(.caption2)
            }
        }
        .foregroundColor(isGrayscale ? .secondary : .primary)
        .padding(.horizontal, 20)
        .padding(.top, 12)
        .animation(.easeInOut(duration: 0.8), value: isGrayscale)
    }
    
    // MARK: - Home Indicator
    private func homeIndicator(isGrayscale: Bool) -> some View {
        RoundedRectangle(cornerRadius: 2, style: .continuous)
            .fill(isGrayscale ? Color.secondary.opacity(0.5) : Color.primary.opacity(0.3))
            .frame(width: 140, height: 4)
            .padding(.bottom, 8)
            .animation(.easeInOut(duration: 0.8), value: isGrayscale)
    }
    
    // MARK: - App Content View
    private func appContentView(for demo: DemoStep) -> some View {
        VStack(spacing: 16) {
            // App icon with bounce animation
            appIcon(for: demo)
                .scaleEffect(isAnimating ? 1.2 : 1.0)
                .animation(.spring(response: 0.4, dampingFraction: 0.6), value: isAnimating)
            
            // App name
            Text(demo.appName)
                .font(.caption.weight(.medium))
                .foregroundColor(demo.isGrayscale ? .secondary : .primary)
                .animation(.easeInOut(duration: 0.8), value: demo.isGrayscale)
            
            // App specific content
            Group {
                switch demo.appName {
                case "TikTok":
                    tikTokContent(isGrayscale: demo.isGrayscale)
                case "Домой":
                    homeScreenContent(isGrayscale: demo.isGrayscale)
                case "Работа":
                    workContent(isGrayscale: demo.isGrayscale)
                case "Сон":
                    sleepContent(isGrayscale: demo.isGrayscale)
                default:
                    genericContent(isGrayscale: demo.isGrayscale)
                }
            }
            .animation(.easeInOut(duration: 1.0).delay(0.2), value: demo.isGrayscale)
        }
    }
    
    // MARK: - App Icon
    private func appIcon(for demo: DemoStep) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .fill(demo.isGrayscale ? Color.secondary.opacity(0.4) : getAppColor(for: demo.appName))
                .frame(width: 60, height: 60)
                .animation(.easeInOut(duration: 0.8), value: demo.isGrayscale)
            
            Image(systemName: demo.icon)
                .font(.system(size: 24, weight: .medium))
                .foregroundColor(.white)
        }
        .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
    }
    
    // MARK: - Specialized App Content
    private func tikTokContent(isGrayscale: Bool) -> some View {
        VStack(spacing: 12) {
            // Video player simulation
            ZStack {
                if isGrayscale {
                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                        .fill(Color.secondary.opacity(0.3))
                        .frame(width: 140, height: 80)
                } else {
                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                        .fill(LinearGradient(colors: [.purple, .pink], startPoint: .topLeading, endPoint: .bottomTrailing))
                        .frame(width: 140, height: 80)
                }
                
                VStack {
                    Image(systemName: "play.fill")
                        .font(.title2)
                        .foregroundColor(.white)
                    Text("Viral Video")
                        .font(.caption2.weight(.medium))
                        .foregroundColor(.white)
                }
            }
            .scaleEffect(isAnimating ? 1.05 : 1.0)
            
            HStack(spacing: 8) {
                Circle()
                    .fill(isGrayscale ? Color.secondary : Color.orange)
                    .frame(width: 20, height: 20)
                Text("@viral_creator")
                    .font(.caption2.weight(.medium))
                    .foregroundColor(isGrayscale ? .secondary : .primary)
                Spacer()
            }
            .frame(width: 140)
        }
    }
    
    private func homeScreenContent(isGrayscale: Bool) -> some View {
        VStack(spacing: 12) {
            Text("Главный экран")
                .font(.caption.weight(.medium))
                .foregroundColor(isGrayscale ? .secondary : .primary)
            
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 12), count: 4), spacing: 12) {
                ForEach(Array(zip(["message.fill", "phone.fill", "camera.fill", "map.fill"], 
                                 [Color.green, .blue, .gray, .orange])), id: \.0) { iconName, color in
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .fill(isGrayscale ? Color.secondary.opacity(0.4) : color)
                        .frame(width: 24, height: 24)
                        .overlay(
                            Image(systemName: iconName)
                                .font(.caption)
                                .foregroundColor(.white)
                        )
                        .scaleEffect(isAnimating ? 1.1 : 1.0)
                        .animation(.spring(response: 0.3, dampingFraction: 0.7).delay(Double.random(in: 0...0.2)), value: isAnimating)
                }
            }
            .frame(width: 120)
        }
    }
    
    private func workContent(isGrayscale: Bool) -> some View {
        VStack(spacing: 10) {
            HStack {
                Image(systemName: "clock.fill")
                    .foregroundColor(isGrayscale ? .secondary : .blue)
                Text("9:00 - 18:00")
                    .font(.caption.weight(.medium))
                    .foregroundColor(isGrayscale ? .secondary : .primary)
            }
            
            VStack(spacing: 6) {
                ForEach(0..<3, id: \.self) { index in
                    RoundedRectangle(cornerRadius: 4, style: .continuous)
                        .fill(isGrayscale ? Color.secondary.opacity(0.3) : Color.blue.opacity(0.6))
                        .frame(width: 100 - CGFloat(index * 10), height: 8)
                        .animation(.easeInOut(duration: 0.5).delay(Double(index) * 0.1), value: isGrayscale)
                }
            }
            
            Text("Focus активен")
                .font(.caption2.weight(.medium))
                .foregroundColor(isGrayscale ? .secondary : .blue)
        }
    }
    
    private func sleepContent(isGrayscale: Bool) -> some View {
        VStack(spacing: 10) {
            HStack {
                Image(systemName: "moon.fill")
                    .foregroundColor(isGrayscale ? .secondary : .indigo)
                Text("21:00")
                    .font(.caption.weight(.medium))
                    .foregroundColor(isGrayscale ? .secondary : .primary)
            }
            
            // Sleep mode visualization
            ZStack {
                Circle()
                    .stroke(isGrayscale ? Color.secondary.opacity(0.3) : Color.indigo.opacity(0.3), lineWidth: 2)
                    .frame(width: 60, height: 60)
                
                Circle()
                    .trim(from: 0, to: isAnimating ? 1.0 : 0.7)
                    .stroke(isGrayscale ? Color.secondary : Color.indigo, lineWidth: 3)
                    .frame(width: 60, height: 60)
                    .rotationEffect(.degrees(-90))
                    .animation(.easeInOut(duration: 2.0), value: isAnimating)
                
                Image(systemName: "moon.zzz.fill")
                    .font(.title3)
                    .foregroundColor(isGrayscale ? .secondary : .indigo)
            }
            
            Text("Режим сна")
                .font(.caption2.weight(.medium))
                .foregroundColor(isGrayscale ? .secondary : .indigo)
        }
    }
    
    private func genericContent(isGrayscale: Bool) -> some View {
        VStack(spacing: 8) {
            ForEach(0..<3, id: \.self) { index in
                RoundedRectangle(cornerRadius: 4, style: .continuous)
                    .fill(isGrayscale ? Color.secondary.opacity(0.3) : Color.blue.opacity(0.4))
                    .frame(width: 120 - CGFloat(index * 15), height: 12)
                    .animation(.easeInOut(duration: 0.5).delay(Double(index) * 0.1), value: isGrayscale)
            }
        }
    }
    
    private func getAppColor(for appName: String) -> Color {
        switch appName {
        case "TikTok": return .black
        case "Работа": return .blue
        case "Сон": return .indigo
        default: return .gray
        }
    }
    
    // MARK: - Step Content
    private var stepContent: some View {
        VStack(spacing: 14) {
            Text(demoSteps[currentStep].title)
                .font(.title3.weight(.semibold))
                .multilineTextAlignment(.center)
                .lineLimit(2)
                .fixedSize(horizontal: false, vertical: true)
            
            Text(demoSteps[currentStep].subtitle)
                .font(.body.weight(.medium))
                .multilineTextAlignment(.center)
                .lineLimit(2)
                .fixedSize(horizontal: false, vertical: true)
            
            Text(demoSteps[currentStep].description)
                .font(.subheadline)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .lineLimit(2)
                .fixedSize(horizontal: false, vertical: true)
        }
        .frame(height: 100) // Увеличенная высота
        .transition(.opacity.combined(with: .slide))
        .id(currentStep) // Force view recreation for smooth transition
    }
    
    // MARK: - Controls
    private var controlButtons: some View {
        HStack(spacing: 20) {
            // Previous
            Button {
                let newStep = currentStep > 0 ? currentStep - 1 : demoSteps.count - 1
                manualStepChange(to: newStep)
            } label: {
                Image(systemName: "chevron.left")
                    .font(.title2.weight(.semibold))
                    .foregroundColor(DS.Color.accent)
                    .frame(width: 44, height: 44)
                    .background(Circle().fill(Color.secondary.opacity(0.1)))
            }
            
            // Step indicators
            HStack(spacing: 8) {
                ForEach(0..<demoSteps.count, id: \.self) { index in
                    Circle()
                        .fill(index == currentStep ? DS.Color.accent : Color.secondary.opacity(0.3))
                        .frame(width: 8, height: 8)
                        .animation(.easeInOut(duration: 0.3), value: currentStep)
                }
            }
            
            // Next
            Button {
                let newStep = (currentStep + 1) % demoSteps.count
                manualStepChange(to: newStep)
            } label: {
                Image(systemName: "chevron.right")
                    .font(.title2.weight(.semibold))
                    .foregroundColor(DS.Color.accent)
                    .frame(width: 44, height: 44)
                    .background(Circle().fill(Color.secondary.opacity(0.1)))
            }
        }
    }
    
    // MARK: - Sticky CTA Button
    private var stickyCtaButton: some View {
        VStack(spacing: 8) {
            Text(L10n.Demo.priceDetails)
                .font(.caption)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .lineLimit(2)
                .fixedSize(horizontal: false, vertical: true)
            
            Button {
                // TODO: Implement premium purchase
                appState.purchasePremium()
                dismiss()
            } label: {
                Text(L10n.Demo.Button.buy)
                    .font(.headline.weight(.semibold))
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(DS.Color.accent)
                    .foregroundColor(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                    .shadow(color: DS.Shadow.soft, radius: 8, x: 0, y: 4)
            }
        }
        .padding(.horizontal, 20)
        .padding(.top, 16)
        .padding(.bottom, 20)
        .background(
            Rectangle()
                .fill(.ultraThinMaterial)
                .ignoresSafeArea(edges: .bottom)
        )
    }
    
    // MARK: - Compact CTA Button
    private var compactCtaButton: some View {
        VStack(spacing: 8) {
            Button {
                // TODO: Implement premium purchase
                appState.purchasePremium()
                dismiss()
            } label: {
                Text(L10n.Demo.Button.buy)
                    .font(.headline.weight(.semibold))
                    .frame(maxWidth: .infinity)
                    .frame(height: 44)
                    .background(DS.Color.accent)
                    .foregroundColor(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                    .shadow(color: DS.Shadow.soft, radius: 6, x: 0, y: 3)
            }
            
            Text(L10n.Demo.price)
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .padding(.horizontal, 20)
        .padding(.bottom, 16)
    }
    
    // MARK: - Old CTA Button (removed from layout)
    private var ctaButton: some View {
        VStack(spacing: 12) {
            Button {
                // TODO: Implement premium purchase
                appState.purchasePremium()
                dismiss()
            } label: {
                Text(L10n.Demo.Button.buy)
                    .font(.title2.weight(.semibold))
                    .frame(maxWidth: .infinity)
                    .frame(height: 56)
                    .background(DS.Color.accent)
                    .foregroundColor(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                    .shadow(color: DS.Shadow.soft, radius: 12, x: 0, y: 4)
            }
            
            Text(L10n.Demo.priceDetails)
                .font(.footnote)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .lineLimit(3)
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding(.horizontal, 20)
        .padding(.bottom, 20)
    }
    
    // MARK: - Methods
    private func startDemo() {
        // Show initial content
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                showAppContent = true
            }
        }
        
        updatePhoneState()
        
        // Auto-advance demo with sophisticated timing
        autoPlayTimer = Timer.scheduledTimer(withTimeInterval: 4.0, repeats: true) { timer in
            advanceToNextStep()
        }
    }
    
    private func advanceToNextStep() {
        // Transition out
        withAnimation(.easeInOut(duration: 0.4)) {
            isTransitioning = true
            showAppContent = false
        }
        
        // Change step
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            currentStep = (currentStep + 1) % demoSteps.count
            
            // Transition in
            withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                isTransitioning = false
                showAppContent = true
            }
            
            updatePhoneState()
        }
    }
    
    private func updatePhoneState() {
        // Trigger animation pulse
        withAnimation(.spring(response: 0.4, dampingFraction: 0.7)) {
            isAnimating = true
        }
        
        // Reset animation state
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            withAnimation(.easeOut(duration: 0.6)) {
                isAnimating = false
            }
        }
    }
    
    private func manualStepChange(to newStep: Int) {
        // Cancel auto-play temporarily
        autoPlayTimer?.invalidate()
        
        guard newStep != currentStep else { return }
        
        withAnimation(.easeInOut(duration: 0.3)) {
            isTransitioning = true
            showAppContent = false
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            currentStep = newStep
            
            withAnimation(.spring(response: 0.5, dampingFraction: 0.8)) {
                isTransitioning = false
                showAppContent = true
            }
            
            updatePhoneState()
        }
        
        // Resume auto-play after 5 seconds
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
            startDemo()
        }
    }
}

// MARK: - Demo Step Model
struct DemoStep {
    let title: String
    let subtitle: String
    let description: String
    let icon: String
    let appName: String
    let isGrayscale: Bool
}

#Preview {
    DemoView()
        .environmentObject(AppState())
}
