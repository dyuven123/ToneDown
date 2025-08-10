//
//  ToneDownApp.swift
//  ToneDown
//
//  Created by Dyuven on 10.08.2025.
//  iOS 15.0+
//

import SwiftUI

@main
struct ToneDownApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView()
                .preferredColorScheme(nil) // поддерживаем и светлую, и тёмную
        }
    }
}
