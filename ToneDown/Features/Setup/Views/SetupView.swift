//
//  SetupView.swift
//  ToneDown
//
//  Created by Dyuven on 10.08.2025.
//

import SwiftUI

struct SetupView: View {
    @EnvironmentObject var appState: AppState
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationView {
            VStack(spacing: 32) {
                
                Spacer()
                
                // comment.central.command.creation.button
                VStack(spacing: 16) {
                    Text("🚀")
                        .font(.system(size: 64))
                    
                    Text(LocalizedStringKey("setup.create.command.title"))
                        .font(.title.weight(.semibold))
                    
                    Text(LocalizedStringKey("setup.create.command.subtitle"))
                        .font(.body)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                }
                
                Button(LocalizedStringKey("setup.button.add.command")) {
                    ShortcutsRunner.createToggleGrayscaleShortcut()
                } 
                .font(.title2.weight(.semibold))
                .frame(maxWidth: .infinity)
                .frame(height: 56)
                .background(DS.Color.accent)
                .foregroundColor(.white)
                .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                .shadow(color: DS.Shadow.soft, radius: 12, x: 0, y: 4)
                .padding(.horizontal, 20)
                
                Spacer()
                
                // comment.instruction
                VStack(spacing: 8) {
                    Text(LocalizedStringKey("setup.info.title"))
                        .font(.subheadline.weight(.medium))
                    
                    Text(LocalizedStringKey("setup.info.description"))
                        .font(.footnote)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                }
                
                // comment.confirmation.button.after.setup
                if !appState.hasCompletedSetup {
                    VStack(spacing: 16) {
                        Text(LocalizedStringKey("setup.after.title"))
                            .font(.subheadline.weight(.medium))
                        
                        Button {
                            appState.completeSetup()
                            dismiss()
                        } label: {
                            Text(LocalizedStringKey("setup.button.confirm"))
                                .font(.body.weight(.medium))
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 12)
                                .background(Color.green)
                                .foregroundColor(.white)
                                .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                        }
                        .padding(.horizontal, 20)
                    }
                }
                
                Spacer(minLength: 20)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .navigationTitle(LocalizedStringKey("setup.title"))
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing: Button(LocalizedStringKey("setup.button.done")) { dismiss() })
        }
        .navigationViewStyle(.stack)
    }
}
