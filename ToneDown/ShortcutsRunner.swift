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
        
        // Проверяем, можем ли открыть URL (работает без LSApplicationQueriesSchemes для shortcuts://)
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
