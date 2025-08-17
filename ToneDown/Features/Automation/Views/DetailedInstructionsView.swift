//
//  DetailedInstructionsView.swift
//  ToneDown
//
//  Created by Dyuven on 10.08.2025.
//

import SwiftUI

// MARK: - Detailed Instructions View
struct DetailedInstructionsView: View {
    @Environment(\.dismiss) private var dismiss
    
    private let instructions = [
        InstructionStep(
            number: 1,
            title: "detailed.instructions.commands.created.title",
            description: "detailed.instructions.commands.created.description"
        ),
        InstructionStep(
            number: 2,
            title: "detailed.instructions.open.shortcuts.title",
            description: "detailed.instructions.open.shortcuts.description"
        ),
        InstructionStep(
            number: 3,
            title: "detailed.instructions.create.first.automation.title",
            description: "detailed.instructions.create.first.automation.description"
        ),
        InstructionStep(
            number: 4,
            title: "detailed.instructions.select.app.trigger.title",
            description: "detailed.instructions.select.app.trigger.description"
        ),
        InstructionStep(
            number: 5,
            title: "detailed.instructions.select.apps.configure.title",
            description: "detailed.instructions.select.apps.configure.description"
        ),
        InstructionStep(
            number: 6,
            title: "detailed.instructions.add.run.command.title",
            description: "detailed.instructions.add.run.command.description"
        ),
        InstructionStep(
            number: 7,
            title: "detailed.instructions.select.grayscale.on.title",
            description: "detailed.instructions.select.grayscale.on.description"
        ),
        InstructionStep(
            number: 8,
            title: "detailed.instructions.disable.confirmation.title",
            description: "detailed.instructions.disable.confirmation.description"
        ),
        InstructionStep(
            number: 9,
            title: "detailed.instructions.create.second.automation.title",
            description: "detailed.instructions.create.second.automation.description"
        ),
        InstructionStep(
            number: 10,
            title: "detailed.instructions.test.work.title",
            description: "detailed.instructions.test.work.description"
        )
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 24) {
                    // Header
                    VStack(spacing: 12) {
                        Text("📋")
                            .font(.system(size: 48))
                        Text(LocalizedStringKey("detailed.instructions.title"))
                            .font(.title.weight(.bold))
                        Text(LocalizedStringKey("detailed.instructions.subtitle"))
                            .font(.body)
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.center)
                    }
                    .padding(.top, 20)
                    
                    // Instructions list
                    VStack(spacing: 16) {
                        ForEach(instructions, id: \.number) { instruction in
                            InstructionRow(instruction: instruction)
                        }
                    }
                    .padding(.horizontal, 20)
                    
                    // Tips section
                    VStack(spacing: 16) {
                        Text(LocalizedStringKey("detailed.instructions.useful.tips"))
                            .font(.title3.weight(.semibold))
                        
                        VStack(alignment: .leading, spacing: 12) {
                            TipRow(
                                icon: "checkmark.circle.fill",
                                text: "detailed.instructions.tip.two.automations",
                                color: .green
                            )
                            TipRow(
                                icon: "info.circle.fill",
                                text: "detailed.instructions.tip.select.all.apps",
                                color: .blue
                            )
                            TipRow(
                                icon: "checkmark.circle.fill",
                                text: "detailed.instructions.tip.base.commands.ready",
                                color: .green
                            )
                            TipRow(
                                icon: "lightbulb.fill",
                                text: "detailed.instructions.tip.same.apps.both",
                                color: .purple
                            )
                        }
                        .padding(.vertical, 16)
                        .padding(.horizontal, 20)
                        .background(
                            RoundedRectangle(cornerRadius: 16, style: .continuous)
                                .fill(.ultraThinMaterial)
                        )
                        .padding(.horizontal, 20)
                    }
                    
                    Spacer(minLength: 40)
                }
            }
            .navigationTitle(LocalizedStringKey("detailed.instructions.navigation.title"))
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing: Button(LocalizedStringKey("detailed.instructions.button.done")) {
                dismiss()
            })
        }
    }
}

// MARK: - Instruction Row
struct InstructionRow: View {
    let instruction: InstructionStep
    
    var body: some View {
        HStack(spacing: 16) {
            ZStack {
                Circle()
                    .fill(DS.Color.accent)
                    .frame(width: 32, height: 32)
                
                Text("\(instruction.number)")
                    .font(.subheadline.weight(.bold))
                    .foregroundColor(.white)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(LocalizedStringKey(instruction.title))
                    .font(.subheadline.weight(.semibold))
                    .foregroundColor(.primary)
                
                Text(LocalizedStringKey(instruction.description))
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .lineLimit(3)
            }
            
            Spacer()
        }
        .padding(.vertical, 12)
        .padding(.horizontal, 16)
        .background(
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .fill(.ultraThinMaterial)
        )
    }
}

// MARK: - Tip Row
struct TipRow: View {
    let icon: String
    let text: String
    let color: Color
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .font(.subheadline)
                .foregroundColor(color)
            
            Text(LocalizedStringKey(text))
                .font(.subheadline)
                .foregroundColor(.primary)
            
            Spacer()
        }
    }
}

// MARK: - Instruction Step Model
struct InstructionStep {
    let number: Int
    let title: String
    let description: String
}

#Preview {
    DetailedInstructionsView()
}
