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
            SettingView()
                .tabItem {
                    Image(systemName: "gear")
                }
        }.navigationLinkValues(NavigationContentViewCoordinator.self)
    }
}

#Preview {
    let modelContent: ModelContainer = .appContainer
    
    return ContentView().modelContainer(modelContent)
}
