//
//  LocalizationHelper.swift
//  ToneDown
//
//  Created by Dyuven on 10.08.2025.
//

import Foundation

// MARK: - Localization Helper
extension String {
    /// Returns localized string for the current key
    var localized: String {
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
        }
        
        struct Category {
            static let all = "app.trigger.category.all".localized
            static let social = "app.trigger.category.social".localized
            static let entertainment = "app.trigger.category.entertainment".localized
            static let productivity = "app.trigger.category.productivity".localized
            static let other = "app.trigger.category.other".localized
        }
    }
}

