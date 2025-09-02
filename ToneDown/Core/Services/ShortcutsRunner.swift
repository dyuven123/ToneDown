//
//  ShortcutsRunner.swift
//  ToneDown
//
//  Created by Dyuven on 10.08.2025.
//

import UIKit

enum ShortcutsRunner {
    static func runShortcut(named name: String) {
        let encoded = name.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? name
        guard let url = URL(string: "shortcuts://run-shortcut?name=\(encoded)") else { return }
        
        // comment.shortcuts.url.check
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }

    static func openShortcutsApp() {
        guard let url = URL(string: "shortcuts://") else { return }
        
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }

    static func openShortcutsGallery() {
        guard let url = URL(string: "shortcuts://gallery") else { return }
        
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    // MARK: - Base Commands Import (Enable/Disable Grayscale)
    private static let baseEnableLink = "https://www.icloud.com/shortcuts/dfedc28bc4b041a9957b1e8e319c662a"
    private static let baseDisableLink = "https://www.icloud.com/shortcuts/07dd970285fe4c9fa2d7984af849707f"
    
    static func importBaseEnableCommand() {
        openShortcutImport(from: baseEnableLink)
    }
    
    static func importBaseDisableCommand() {
        openShortcutImport(from: baseDisableLink)
    }
    
    // MARK: - Open specific iCloud Shortcut links per known app
    enum AppShortcut: String, CaseIterable {
        case instagram
        case tiktok
        case youtube
        
        var displayName: String {
            switch self {
            case .instagram: return "Instagram"
            case .tiktok: return "TikTok"
            case .youtube: return "YouTube"
            }
        }
    }
    
    enum ShortcutAction {
        case enableGrayscale
        case disableGrayscale
    }
    
    // Placeholder mapping: separate links for Enable/Disable
    private static let appEnableLinks: [AppShortcut: String] = [
        .instagram: "https://www.icloud.com/shortcuts/20c81061b1d946bb909f064b709ab456",
        .tiktok:    "https://www.icloud.com/shortcuts/20c81061b1d946bb909f064b709ab456",
        .youtube:   "https://www.icloud.com/shortcuts/20c81061b1d946bb909f064b709ab456"
    ]
    

    
    static func openAppSpecificShortcut(_ app: AppShortcut, action: ShortcutAction) {
        let link: String?
        switch action {
        case .enableGrayscale:
            link = appEnableLinks[app]
        case .disableGrayscale:
            link = baseDisableLink
        }
        guard let link, !link.isEmpty else { return }
        openShortcutImport(from: link)
    }
    
    static func openShortcutImport(from urlString: String) {
        guard let url = URL(string: urlString) else { return }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    // URL для автоматического создания команды Toggle Grayscale
    static func createToggleGrayscaleShortcut() {
        // Реальная ссылка на готовую команду Toggle Grayscale
        if let url = URL(string: "https://www.icloud.com/shortcuts/20c81061b1d946bb909f064b709ab456") {
            UIApplication.shared.open(url, options: [:]) { success in
                if !success {
                    // Fallback если ссылка не работает
                    DispatchQueue.main.async {
                        openCreateShortcut()
                    }
                }
            }
        } else {
            // Fallback если URL некорректен
            openCreateShortcut()
        }
    }
    
    // Fallback: открыть создание новой команды
    static func openCreateShortcut() {
        guard let url = URL(string: "shortcuts://create-shortcut") else { return }
        
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            openShortcutsApp()
        }
    }
    
    // Альтернативный метод: открыть галерею и найти похожие команды
    static func searchGrayscaleShortcuts() {
        // Поиск в галерее команд по ключевому слову "accessibility" или "grayscale"
        guard let url = URL(string: "shortcuts://gallery/search?query=accessibility") else {
            openShortcutsGallery()
            return
        }
        
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            openShortcutsGallery()
        }
    }
    
    // Открыть настройки доступности напрямую
    static func openAccessibilitySettings() {
        guard let url = URL(string: "App-Prefs:Accessibility&path=TRIPLE_CLICK_TITLE") else {
            // Fallback: общие настройки доступности
            guard let generalURL = URL(string: "App-Prefs:Accessibility") else { return }
            UIApplication.shared.open(generalURL, options: [:], completionHandler: nil)
            return
        }
        
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
}
