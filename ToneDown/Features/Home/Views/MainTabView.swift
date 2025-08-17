//
//  MainTabView.swift
//  ToneDown
//
//  Created by Dyuven on 10.08.2025.
//

import SwiftUI

struct MainTabView: View {
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        TabView {
            // comment.home.tab
            HomeView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text(L10n.Tab.home)
                }
                .tag(0)
            
            // comment.automation.tab
            AutomationView()
                .tabItem {
                    Image(systemName: appState.hasPremium ? "wand.and.stars.inverse" : "wand.and.stars")
                    Text(L10n.Tab.automation)
                }
                .tag(1)
                .badge(appState.hasPremium ? nil : "💎")
        }
        .accentColor(DS.Color.accent)
    }
}

#Preview {
    MainTabView()
        .environmentObject(AppState())
}
