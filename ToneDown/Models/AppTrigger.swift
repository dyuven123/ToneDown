//
//  AppTrigger.swift
//  ToneDown
//
//  Created by Dyuven on 10.08.2025.
//

import SwiftUI

// MARK: - App Trigger Model
struct AppTrigger: Identifiable, Codable {
    let id = UUID()
    let bundleId: String
    let name: String
    let iconName: String
    let category: AppCategory
    var isEnabled: Bool
    
    enum AppCategory: String, CaseIterable, Codable {
        case social = "social"
        case entertainment = "entertainment"
        case productivity = "productivity"
        case other = "other"
        
        var displayName: String {
            switch self {
            case .social: return L10n.AppTrigger.Category.social
            case .entertainment: return L10n.AppTrigger.Category.entertainment
            case .productivity: return L10n.AppTrigger.Category.productivity
            case .other: return L10n.AppTrigger.Category.other
            }
        }
        
        var color: Color {
            switch self {
            case .social: return .pink
            case .entertainment: return .purple
            case .productivity: return .blue
            case .other: return .gray
            }
        }
    }
}

// MARK: - Predefined Popular Apps
extension AppTrigger {
    static let popularApps: [AppTrigger] = [
        // Social Media
        AppTrigger(bundleId: "com.zhiliaoapp.musically", name: "TikTok", iconName: "music.note", category: .social, isEnabled: false),
        AppTrigger(bundleId: "com.burbn.instagram", name: "Instagram", iconName: "camera", category: .social, isEnabled: false),
        AppTrigger(bundleId: "com.atebits.Tweetie2", name: "Twitter/X", iconName: "bubble.left.and.bubble.right", category: .social, isEnabled: false),
        AppTrigger(bundleId: "com.facebook.Facebook", name: "Facebook", iconName: "person.3", category: .social, isEnabled: false),
        AppTrigger(bundleId: "com.snapchat.snapchat", name: "Snapchat", iconName: "camera.viewfinder", category: .social, isEnabled: false),
        AppTrigger(bundleId: "ru.ok.mobile", name: "Одноклассники", iconName: "person.circle", category: .social, isEnabled: false),
        AppTrigger(bundleId: "com.linkedin.LinkedIn", name: "LinkedIn", iconName: "briefcase", category: .social, isEnabled: false),
        
        // Entertainment
        AppTrigger(bundleId: "com.google.ios.youtube", name: "YouTube", iconName: "play.rectangle", category: .entertainment, isEnabled: false),
        AppTrigger(bundleId: "com.netflix.Netflix", name: "Netflix", iconName: "tv", category: .entertainment, isEnabled: false),
        AppTrigger(bundleId: "com.spotify.client", name: "Spotify", iconName: "music.note.list", category: .entertainment, isEnabled: false),
        AppTrigger(bundleId: "com.apple.tv", name: "Apple TV", iconName: "appletv", category: .entertainment, isEnabled: false),
        AppTrigger(bundleId: "com.disney.disneyplus", name: "Disney+", iconName: "sparkles.tv", category: .entertainment, isEnabled: false),
        AppTrigger(bundleId: "com.twitch.twitchtv", name: "Twitch", iconName: "gamecontroller", category: .entertainment, isEnabled: false),
        
        // Productivity (usually OFF by default)
        AppTrigger(bundleId: "com.apple.mobilemail", name: "Mail", iconName: "envelope", category: .productivity, isEnabled: false),
        AppTrigger(bundleId: "com.apple.mobilecal", name: "Calendar", iconName: "calendar", category: .productivity, isEnabled: false),
        AppTrigger(bundleId: "com.apple.mobilenotes", name: "Notes", iconName: "note.text", category: .productivity, isEnabled: false),
        AppTrigger(bundleId: "com.microsoft.Office.Outlook", name: "Outlook", iconName: "envelope.badge", category: .productivity, isEnabled: false),
        AppTrigger(bundleId: "com.notion.notion", name: "Notion", iconName: "doc.text", category: .productivity, isEnabled: false),
        
        // Other
        AppTrigger(bundleId: "com.apple.mobilesafari", name: "Safari", iconName: "safari", category: .other, isEnabled: false),
        AppTrigger(bundleId: "com.apple.AppStore", name: "App Store", iconName: "bag", category: .other, isEnabled: false),
        AppTrigger(bundleId: "com.apple.mobilephone", name: "Phone", iconName: "phone", category: .other, isEnabled: false),
        AppTrigger(bundleId: "com.apple.MobileSMS", name: "Messages", iconName: "message", category: .other, isEnabled: false),
    ]
}
