//
//  ProgressIndicatorView.swift
//  ToneDown
//
//  Created by Dyuven on 10.08.2025.
//

import SwiftUI

// MARK: - Progress Indicator View
struct ProgressIndicatorView: View {
    let currentStep: Int
    let totalSteps: Int
    let onStepTap: (Int) -> Void
    
    var body: some View {
        VStack(spacing: 12) {
            HStack(spacing: 12) {
                ForEach(0..<totalSteps, id: \.self) { index in
                    Button {
                        onStepTap(index)
                    } label: {
                        ZStack {
                            Circle()
                                .fill(index <= currentStep ? DS.Color.accent : Color(.separator))
                                .frame(width: 16, height: 16)
                            
                            if index < currentStep {
                                Image(systemName: "checkmark")
                                    .font(.caption2.weight(.bold))
                                    .foregroundColor(.white)
                            }
                        }
                        .scaleEffect(index == currentStep ? 1.2 : 1.0)
                        .animation(.easeInOut(duration: 0.3), value: currentStep)
                    }
                    .buttonStyle(.plain)
                }
            }
            
            Text(String(format: LocalizationHelper.localizedString("app.triggers.setup.step", comment: ""), currentStep + 1, totalSteps))
                .font(.caption.weight(.medium))
                .foregroundColor(.secondary)
        }
        .padding(.horizontal, 20)
    }
}

#Preview {
    ProgressIndicatorView(
        currentStep: 2,
        totalSteps: 7,
        onStepTap: { _ in }
    )
}
