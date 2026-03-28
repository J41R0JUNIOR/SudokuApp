//
//  SudokuApp.swift
//  Sudoku
//
//  Created by Jairo Júnior on 19/08/24.
//
import SwiftUI

@main
struct SudokuApp: App {
    @StateObject private var themeManager = ThemeManager()
    @StateObject private var hapticsManager = HapticsManager()
    @StateObject private var navigator = Router.shared
    @StateObject private var engine = Engine.shared
    @Environment(\.modelContext) private var context

    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(navigator)
                .environmentObject(themeManager)
                .environmentObject(hapticsManager)
                .environmentObject(engine)
                .accentColor(.primary)
                .preferredColorScheme(
                    themeManager.isDarkMode ? .dark : .light
                )
        }
        .modelContainer(for: SD_Grid_Model.self)
    }
}
