//
//  NavigationButtonsView.swift
//  ToneDown
//
//  Created by Dyuven on 10.08.2025.
//

import SwiftUI

// MARK: - Navigation Buttons View
struct NavigationButtonsView: View {
    let canGoBack: Bool
    let canGoNext: Bool
    let onBackTap: () -> Void
    let onNextTap: () -> Void
    
    var body: some View {
        HStack(spacing: 16) {
            if canGoBack {
                Button(action: onBackTap) {
                    HStack(spacing: 8) {
                        Image(systemName: "chevron.left")
                            .font(.subheadline.weight(.semibold))
                        Text(LocalizedStringKey("app.triggers.setup.button.back"))
                            .font(.headline.weight(.semibold))
                    }
                    .foregroundColor(DS.Color.accent)
                    .frame(maxWidth: .infinity)
                    .frame(height: 48)
                    .background(
                        RoundedRectangle(cornerRadius: 12, style: .continuous)
                            .fill(DS.Color.accent.opacity(0.1))
                    )
                }
            }
            
            if canGoNext {
                Button(action: onNextTap) {
                    HStack(spacing: 8) {
                        Text(LocalizedStringKey("app.triggers.setup.button.next"))
                            .font(.headline.weight(.semibold))
                        Image(systemName: "chevron.right")
                            .font(.subheadline.weight(.semibold))
                    }
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 48)
                    .background(
                        LinearGradient(
                            colors: [
                                DS.Color.accent,
                                DS.Color.accent.opacity(0.8)
                            ],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                }
            }
        }
        .padding(.horizontal, 20)
    }
}

#Preview {
    VStack(spacing: 20) {
        NavigationButtonsView(
            canGoBack: true,
            canGoNext: true,
            onBackTap: {},
            onNextTap: {}
        )
        
        NavigationButtonsView(
            canGoBack: false,
            canGoNext: true,
            onBackTap: {},
            onNextTap: {}
        )
        
        NavigationButtonsView(
            canGoBack: true,
            canGoNext: false,
            onBackTap: {},
            onNextTap: {}
        )
    }
}
