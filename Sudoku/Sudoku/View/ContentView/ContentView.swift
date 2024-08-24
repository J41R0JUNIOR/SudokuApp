//
//  ContentView.swift
//  Sudoku
//
//  Created by Jairo Júnior on 20/08/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Image(systemName: "house")
                }
            SettingComponents()
                .tabItem {
                    Image(systemName: "gear")
                }
        }.navigationLinkValues(NavigationContentViewCoordinator.self)
            .accentColor(.primary)
    }
}

#Preview {
    let modelContent: ModelContainer = .appContainer
    let themeManager = ThemeManager()
    let hapticsManager = HapticsManager()
    
    return ContentView()
        .navigationLinkValues(NavigationContentViewCoordinator.self)
        .modelContainer(modelContent)
        .environmentObject(themeManager)
        .environmentObject(hapticsManager)
        .preferredColorScheme(themeManager.isDarkMode ? .dark : .light)
}
