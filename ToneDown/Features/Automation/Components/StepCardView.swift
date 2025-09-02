//
//  StepCardView.swift
//  ToneDown
//
//  Created by Dyuven on 10.08.2025.
//

import SwiftUI
import AVKit

// MARK: - Step Card View
struct StepCardView: View {
    let step: SetupStep
    let onActionTap: () -> Void
    let getOrCreatePlayer: (Int, URL) -> AVPlayer
    
    var body: some View {
        VStack(spacing: 16) {
            // Step header
            HStack(spacing: 16) {
                ZStack {
                    Circle()
                        .fill(step.color)
                        .frame(width: 48, height: 48)
                    
                    Text("\(step.number)")
                        .font(.title2.weight(.bold))
                        .foregroundColor(.white)
                }
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(LocalizedStringKey(step.title))
                        .font(.title3.weight(.semibold))
                        .foregroundColor(.primary)
                    
                    Text(LocalizedStringKey(step.description))
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .fixedSize(horizontal: false, vertical: true)
                }
                
                Spacer()
            }
            
            // Video content
            if let videoName = step.video {
                VideoContentView(
                    videoName: videoName,
                    stepNumber: step.number,
                    getOrCreatePlayer: getOrCreatePlayer
                )
            } else {
                PlaceholderView()
            }
            
            // Action button
            if step.number == 1 || step.number == 4 {
                ActionButtonView(
                    step: step,
                    onTap: onActionTap
                )
            }
        }
        .padding(.vertical, 20)
        .padding(.horizontal, 20)
        .background(
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(.ultraThinMaterial)
                .overlay(
                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                        .stroke(DS.Color.accent.opacity(0.2), lineWidth: 1)
                )
        )
        .padding(.horizontal, 20)
        .frame(maxWidth: .infinity)
    }
}

// MARK: - Video Content View
private struct VideoContentView: View {
    let videoName: String
    let stepNumber: Int
    let getOrCreatePlayer: (Int, URL) -> AVPlayer
    
    var body: some View {
        Group {
            if let videoURL = Bundle.main.url(forResource: videoName, withExtension: "mp4", subdirectory: "Resources/Videos") {
                VideoPlayerView(
                    videoURL: videoURL,
                    stepNumber: stepNumber,
                    getOrCreatePlayer: getOrCreatePlayer
                )
            } else if let videoURL = Bundle.main.url(forResource: videoName, withExtension: "mp4") {
                VideoPlayerView(
                    videoURL: videoURL,
                    stepNumber: stepNumber,
                    getOrCreatePlayer: getOrCreatePlayer
                )
            } else {
                Text("Видео не найдено: \(videoName).mp4")
                    .font(.caption)
                    .foregroundColor(.red)
                    .padding()
            }
        }
    }
}

// MARK: - Video Player View
private struct VideoPlayerView: View {
    let videoURL: URL
    let stepNumber: Int
    let getOrCreatePlayer: (Int, URL) -> AVPlayer
    
    var body: some View {
        VStack(spacing: 0) {
            VideoPlayer(player: getOrCreatePlayer(stepNumber, videoURL))
                .aspectRatio(9/16, contentMode: .fit)
                .frame(maxHeight: .infinity)
                .background(
                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                        .fill(
                            LinearGradient(
                                colors: [
                                    DS.Color.accent.opacity(0.1),
                                    DS.Color.accent.opacity(0.05),
                                    DS.Color.accent.opacity(0.02)
                                ],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 20, style: .continuous)
                                .stroke(
                                    LinearGradient(
                                        colors: [
                                            DS.Color.accent.opacity(0.3),
                                            DS.Color.accent.opacity(0.1)
                                        ],
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    ),
                                    lineWidth: 2
                                )
                        )
                )
                .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                .shadow(
                    color: DS.Color.accent.opacity(0.2),
                    radius: 20,
                    x: 0,
                    y: 8
                )
                .shadow(
                    color: .black.opacity(0.1),
                    radius: 8,
                    x: 0,
                    y: 4
                )
            
            HStack(spacing: 8) {
                Image(systemName: "play.circle.fill")
                    .font(.caption)
                    .foregroundColor(DS.Color.accent)
                Text(LocalizedStringKey("app.triggers.setup.video.playing"))
                    .font(.caption2.weight(.medium))
                    .foregroundColor(.secondary)
            }
            .padding(.top, 8)
        }
    }
}

// MARK: - Placeholder View
private struct PlaceholderView: View {
    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .fill(
                        LinearGradient(
                            colors: [
                                DS.Color.accent.opacity(0.1),
                                DS.Color.accent.opacity(0.05),
                                DS.Color.accent.opacity(0.02)
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 20, style: .continuous)
                            .stroke(
                                LinearGradient(
                                    colors: [
                                        DS.Color.accent.opacity(0.3),
                                        DS.Color.accent.opacity(0.1)
                                    ],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                ),
                                lineWidth: 2
                            )
                    )
                
                VStack(spacing: 16) {
                    Image(systemName: "photo")
                        .font(.system(size: 48))
                        .foregroundColor(DS.Color.accent.opacity(0.6))
                    Text(LocalizedStringKey("app.triggers.setup.placeholder.title"))
                        .font(.subheadline.weight(.medium))
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                }
                .padding(32)
            }
            .frame(maxWidth: .infinity)
            .shadow(
                color: DS.Color.accent.opacity(0.2),
                radius: 20,
                x: 0,
                y: 8
            )
            .shadow(
                color: .black.opacity(0.1),
                radius: 8,
                x: 0,
                y: 4
            )
        }
    }
}

// MARK: - Action Button View
private struct ActionButtonView: View {
    let step: SetupStep
    let onTap: () -> Void
    
    var body: some View {
        Button(action: onTap) {
            HStack(spacing: 12) {
                Image(systemName: step.icon)
                    .font(.title3)
                Text(LocalizedStringKey(step.action))
                    .font(.headline.weight(.semibold))
            }
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .frame(height: 56)
            .background(
                LinearGradient(
                    colors: [step.color, step.color.opacity(0.8)],
                    startPoint: .leading,
                    endPoint: .trailing
                )
            )
            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
            .shadow(color: step.color.opacity(0.3), radius: 12, x: 0, y: 6)
        }
    }
}

#Preview {
    StepCardView(
        step: SetupStep(
            number: 1,
            title: "app.triggers.setup.step1.title",
            description: "app.triggers.setup.step1.description",
            action: "app.triggers.setup.step1.action",
            icon: "plus.circle.fill",
            color: .green,
            video: "step1_create_automation"
        ),
        onActionTap: {},
        getOrCreatePlayer: { _, _ in AVPlayer() }
    )
}
