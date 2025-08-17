//
//  LocalizationHelper.swift
//  ToneDown
//
//  Created by Dyuven on 10.08.2025.
//

import Foundation
import SwiftUI

// MARK: - Localization Helper
/// Хелпер для управления локализацией в тестовых и продакшн сборках
enum LocalizationHelper {
    
    // MARK: - Build Configuration
    /// Определяет, является ли текущая сборка тестовой
    static var isTestBuild: Bool {
        #if DEBUG
        return true
        #else
        return false
        #endif
    }
    
    /// Принудительно устанавливает английский язык для тестовых сборок
    static var forcedLanguage: String? {
        if isTestBuild {
            return "en"
        }
        return nil
    }
    
    // MARK: - Current Language
    /// Возвращает текущий язык приложения
    static var currentLanguage: String {
        if let forcedLanguage = forcedLanguage {
            return forcedLanguage
        }
        return Bundle.main.preferredLocalizations.first ?? "en"
    }
    
    // MARK: - Language Display Name
    /// Возвращает отображаемое название языка
    static var currentLanguageDisplayName: String {
        let language = currentLanguage
        let locale = Locale(identifier: language)
        return locale.localizedString(forLanguageCode: language) ?? language.uppercased()
    }
    
    #if DEBUG
    /// Отладочная информация о текущей локализации
    static var debugInfo: String {
        return """
        🔍 Localization Debug Info:
        • Build Type: \(isTestBuild ? "DEBUG (Test)" : "RELEASE")
        • Forced Language: \(forcedLanguage ?? "None")
        • Current Language: \(currentLanguage)
        • Display Name: \(currentLanguageDisplayName)
        • System Languages: \(Bundle.main.preferredLocalizations.joined(separator: ", "))
        • Test String: "app.tagline" = "\(NSLocalizedString("app.tagline", comment: ""))"
        • Forced Test String: "\(LocalizationHelper.testLocalization())"
        """
    }
    
    /// Тестирует принудительную локализацию
    static func testLocalization() -> String {
        if let forcedLanguage = forcedLanguage {
            let bundle = Bundle.main
            if let path = bundle.path(forResource: forcedLanguage, ofType: "lproj"),
               let languageBundle = Bundle(path: path) {
                return languageBundle.localizedString(forKey: "app.tagline", value: "FAILED", table: nil)
            }
        }
        return "No forced language"
    }
    
    /// Принудительно получает локализованную строку для тестовых сборок
    static func localizedString(_ key: String, comment: String = "") -> String {
        if let forcedLanguage = forcedLanguage {
            let bundle = Bundle.main
            if let path = bundle.path(forResource: forcedLanguage, ofType: "lproj"),
               let languageBundle = Bundle(path: path) {
                return languageBundle.localizedString(forKey: key, value: key, table: nil)
            }
        }
        return NSLocalizedString(key, comment: comment)
    }
    #endif
}

// MARK: - String Extension
extension String {
    /// Returns localized string for the current key
    var localized: String {
        if let forcedLanguage = LocalizationHelper.forcedLanguage {
            // Для тестовых сборок принудительно используем английский
            let bundle = Bundle.main
            if let path = bundle.path(forResource: forcedLanguage, ofType: "lproj"),
               let languageBundle = Bundle(path: path) {
                return languageBundle.localizedString(forKey: self, value: self, table: nil)
            }
        }
        return NSLocalizedString(self, comment: "")
    }
    
    /// Returns localized string with format arguments
    func localized(_ arguments: CVarArg...) -> String {
        return String(format: self.localized, arguments: arguments)
    }
}

// MARK: - Localization Keys
struct L10n {
    
    // MARK: - App
    struct App {
        static let name = "app.name".localized
        static let tagline = "app.tagline".localized
        static let description = "app.description".localized
    }
    
    // MARK: - Home Screen
    struct Home {
        static let title = "home.title".localized
        static let subtitle = "home.subtitle".localized
        
        struct Button {
            static let setup = "home.button.setup".localized
            static let toggle = "home.button.toggle".localized
            static let toggleSubtitle = "home.button.toggle.subtitle".localized
            static let addCommand = "home.button.add.command".localized
        }
        
        struct Footer {
            static let setup = "home.footer.setup".localized
            static let works = "home.footer.works".localized
        }
    }
    
    // MARK: - Premium
    struct Premium {
        static let title = "premium.title".localized
        
        struct Button {
            static let demo = "premium.demo.button".localized
            static let learn = "premium.learn.button".localized
        }
    }

    // MARK: - Onboarding
    struct Onboarding {
        struct Button {
            static let next = "onboarding.button.continue".localized
            static let start = "onboarding.button.start".localized
        }

        struct Page1 {
            static let title = "onboarding.page1.title".localized
            static let description = "onboarding.page1.description".localized
        }

        struct Page2 {
            static let title = "onboarding.page2.title".localized
            static let description = "onboarding.page2.description".localized
        }

        struct Page3 {
            static let title = "onboarding.page3.title".localized
            static let description = "onboarding.page3.description".localized
        }

        struct Page4 {
            static let title = "onboarding.page4.title".localized
            static let description = "onboarding.page4.description".localized
        }
    }
    
    // MARK: - Setup Screen
    struct Setup {
        static let title = "setup.title".localized
        
        struct Button {
            static let done = "setup.button.done".localized
            static let add = "setup.button.add".localized
            static let added = "setup.button.added".localized
        }
        
        struct Create {
            static let title = "setup.create.title".localized
            static let subtitle = "setup.create.subtitle".localized
        }
        
        struct Info {
            static let title = "setup.info.title".localized
            static let description = "setup.info.description".localized
        }
        
        static let afterTitle = "setup.after.title".localized
    }
    
    // MARK: - Demo Screen
    struct Demo {
        static let title = "demo.title".localized
        static let subtitle = "demo.subtitle".localized
        static let price = "demo.price".localized
        static let priceDetails = "demo.price.details".localized
        
        struct Button {
            static let buy = "demo.button.buy".localized
        }
        
        struct Scenario {
            struct TikTok {
                static let title = "demo.scenario.tiktok.title".localized
                static let subtitle = "demo.scenario.tiktok.subtitle".localized
                static let description = "demo.scenario.tiktok.description".localized
            }
            
            struct Exit {
                static let title = "demo.scenario.exit.title".localized
                static let subtitle = "demo.scenario.exit.subtitle".localized
                static let description = "demo.scenario.exit.description".localized
            }
            
            struct Work {
                static let title = "demo.scenario.work.title".localized
                static let subtitle = "demo.scenario.work.subtitle".localized
                static let description = "demo.scenario.work.description".localized
            }
            
            struct Sleep {
                static let title = "demo.scenario.sleep.title".localized
                static let subtitle = "demo.scenario.sleep.subtitle".localized
                static let description = "demo.scenario.sleep.description".localized
            }
        }
        
        struct App {
            static let tiktok = "demo.app.tiktok".localized
            static let home = "demo.app.home".localized
            static let work = "demo.app.work".localized
            static let sleep = "demo.app.sleep".localized
        }
        
        struct Content {
            static let viral = "demo.content.viral".localized
            static let username = "demo.content.username".localized
            static let homescreen = "demo.content.homescreen".localized
            static let focusActive = "demo.content.focus.active".localized
            static let sleepMode = "demo.content.sleep.mode".localized
        }
    }
    
    // MARK: - Accessibility
    struct Accessibility {
        static let description = "accessibility.description".localized
        
        struct MainButton {
            static let setup = "accessibility.main.button.setup".localized
            static let toggle = "accessibility.main.button.toggle".localized
        }
        
        struct Hint {
            static let setup = "accessibility.main.hint.setup".localized
            static let toggle = "accessibility.main.hint.toggle".localized
        }
    }
    
    // MARK: - Buttons
    struct Button {
        static let close = "button.close".localized
        static let next = "button.next".localized
        static let previous = "button.previous".localized
    }
    
    // MARK: - Tabs
    struct Tab {
        static let home = "tab.home".localized
        static let automation = "tab.automation".localized
    }
    
    // MARK: - Automation Screen
    struct Automation {
        static let title = "automation.title".localized
        static let subtitle = "automation.subtitle".localized
        static let description = "automation.description".localized
        static let demoTitle = "automation.demo.title".localized
        static let featuresTitle = "automation.features.title".localized
        static let noSubscriptions = "automation.no.subscriptions".localized
        
        struct Feature {
            static let schedule = "automation.feature.schedule".localized
            static let scheduleDesc = "automation.feature.schedule.desc".localized
            static let apps = "automation.feature.apps".localized
            static let appsDesc = "automation.feature.apps.desc".localized
            static let focus = "automation.feature.focus".localized
            static let focusDesc = "automation.feature.focus.desc".localized
            static let location = "automation.feature.location".localized
            static let locationDesc = "automation.feature.location.desc".localized
        }
        
        // MARK: - Automation Alerts
        struct Alert {
            static let shortcutsRequired = "automation.alert.shortcuts.required".localized
            static let shortcutsRequiredMessage = "automation.alert.shortcuts.required.message".localized
            static let openAppStore = "automation.alert.open.appstore".localized
        }
        
        // MARK: - Automation Instructions
        struct Instruction {
            static let step1Title = "automation.instruction.step1.title".localized
            static let step1Description = "automation.instruction.step1.description".localized
            static let step2Title = "automation.instruction.step2.title".localized
            static let step2Description = "automation.instruction.step2.description".localized
            static let step3Title = { (appName: String) in
                String(format: "automation.instruction.step3.title".localized, appName)
            }
            static let step3Description = { (appName: String) in
                String(format: "automation.instruction.step3.description".localized, appName)
            }
            static let step4Title = "automation.instruction.step4.title".localized
            static let step4Description = { (shortcutName: String) in
                String(format: "automation.instruction.step4.description".localized, shortcutName)
            }
            static let step5Title = "automation.instruction.step5.title".localized
            static let step5Description = "automation.instruction.step5.description".localized
        }
        
        // MARK: - Automation Setup
        struct AutomationSetup {
            static let title = "automation.setup.title".localized
            static let subtitle = "automation.setup.subtitle".localized
            
            struct Button {
                static let autoSetup = "automation.setup.button.auto".localized
                static let done = "automation.setup.button.done".localized
            }
            
            static let commandsFirst = "automation.setup.commands.first".localized
            static let buttonAddCommands = "automation.setup.button.add.commands".localized
            static let commandsCompleted = "automation.setup.commands.completed".localized
            static let settingsPlaceholder = "automation.setup.settings.placeholder".localized
            static let infoTitle = "automation.setup.info.title".localized
            static let infoSubtitle = "automation.setup.info.subtitle".localized
        }
        
        // MARK: - Commands Setup
        struct CommandsSetup {
            static let title = "commands.setup.title".localized
            static let subtitle = "commands.setup.subtitle".localized
            
            struct Button {
                static let done = "commands.setup.button.done".localized
            }
            
            struct Banner {
                static let title = "commands.setup.banner.title".localized
                static let subtitle = "commands.setup.banner.subtitle".localized
            }
        }
    }
    
    // MARK: - App Triggers Screen
    struct AppTrigger {
        static let title = "app.trigger.title".localized
        static let subtitle = "app.trigger.subtitle".localized
        static let description = "app.trigger.description".localized
        static let activeCount = "app.trigger.active.count".localized
        static let activeInfo = { (count: Int) in 
            String(format: "app.trigger.active.info".localized, count)
        }
        
        struct Button {
            static let save = "app.trigger.button.save".localized
            static let close = "app.trigger.button.close".localized
            static let enable = "app.trigger.button.enable".localized
            static let disable = "app.trigger.button.disable".localized
            static let toneDown = "app.trigger.button.tone.down".localized
            static let toneRestore = "app.trigger.button.tone.restore".localized
            static let confirm = "app.trigger.button.confirm".localized
        }
        
        struct Category {
            static let all = "app.trigger.category.all".localized
            static let social = "app.trigger.category.social".localized
            static let entertainment = "app.trigger.category.entertainment".localized
        }
        
        struct Hint {
            static let twoShortcuts = "app.trigger.hint.two.shortcuts".localized
            static let importHint = "app.trigger.hint.import".localized
            static let importHintHint = "app.trigger.hint.import.hint".localized
        }
        
        struct Section {
            static let commands = "app.trigger.section.commands".localized
            static let apps = "app.trigger.section.apps".localized
        }
        
        static let afterTitle = "app.trigger.after.title".localized
        
        struct Actions {
            static let openShortcuts = "app.trigger.button.open.shortcuts".localized
        }
    }
}

// MARK: - Preview Helper
#if DEBUG
/// Хелпер для превью, который принудительно устанавливает английский язык
struct EnglishPreviewWrapper<Content: View>: View {
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        content
            .environment(\.locale, Locale(identifier: "en"))
    }
}

/// Хелпер для превью с русским языком
struct RussianPreviewWrapper<Content: View>: View {
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        content
            .environment(\.locale, Locale(identifier: "ru"))
    }
}
#endif

