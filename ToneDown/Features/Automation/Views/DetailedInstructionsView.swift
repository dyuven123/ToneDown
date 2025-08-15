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
            title: "Команды уже созданы",
            description: "Базовые команды для включения и выключения серого режима уже добавлены в приложение Команды"
        ),
        InstructionStep(
            number: 2,
            title: "Откройте приложение Команды",
            description: "Найдите и запустите приложение Команды на вашем iPhone"
        ),
        InstructionStep(
            number: 3,
            title: "Создайте первую автоматизацию (включение)",
            description: "Нажмите на значок '+' и выберите 'Создать персональную автоматизацию'"
        ),
        InstructionStep(
            number: 4,
            title: "Выберите триггер 'Приложение'",
            description: "Прокрутите вниз и выберите 'Приложение' в разделе 'Приложение'"
        ),
        InstructionStep(
            number: 5,
            title: "Выберите приложения и настройте 'Открывается'",
            description: "Выберите ВСЕ приложения, для которых должна работать автоматизация (Instagram, TikTok, YouTube и т.д.) и убедитесь, что выбрано 'Открывается'"
        ),
        InstructionStep(
            number: 6,
            title: "Добавьте действие 'Выполнить команду'",
            description: "Нажмите 'Добавить действие' и найдите 'Выполнить команду'"
        ),
        InstructionStep(
            number: 7,
            title: "Выберите команду 'Grayscale On'",
            description: "Выберите команду 'Grayscale On' (включение серого режима) из списка"
        ),
        InstructionStep(
            number: 8,
            title: "Отключите подтверждение и сохраните",
            description: "Отключите 'Спрашивать перед запуском' и нажмите 'Готово'"
        ),
        InstructionStep(
            number: 9,
            title: "Создайте вторую автоматизацию (выключение)",
            description: "Повторите шаги 3-8, но выберите 'Закрывается', команду 'Grayscale Off' и те же приложения"
        ),
        InstructionStep(
            number: 10,
            title: "Проверьте работу",
            description: "Откройте и закройте приложение - серый режим должен включаться и выключаться автоматически"
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
                        Text("Подробные инструкции")
                            .font(.title.weight(.bold))
                        Text("Пошаговое руководство по настройке автоматизации")
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
                        Text("💡 Полезные советы")
                            .font(.title3.weight(.semibold))
                        
                        VStack(alignment: .leading, spacing: 12) {
                            TipRow(
                                icon: "checkmark.circle.fill",
                                text: "Для каждого приложения нужно создать ДВЕ автоматизации",
                                color: .green
                            )
                            TipRow(
                                icon: "info.circle.fill",
                                text: "Выберите ВСЕ нужные приложения сразу в первой автоматизации",
                                color: .blue
                            )
                            TipRow(
                                icon: "checkmark.circle.fill",
                                text: "Базовые команды уже созданы и готовы к использованию",
                                color: .green
                            )
                            TipRow(
                                icon: "lightbulb.fill",
                                text: "В обеих автоматизациях должны быть выбраны одинаковые приложения",
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
            .navigationTitle("Инструкции")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing: Button("Готово") {
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
                Text(instruction.title)
                    .font(.subheadline.weight(.semibold))
                    .foregroundColor(.primary)
                
                Text(instruction.description)
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
            
            Text(text)
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
