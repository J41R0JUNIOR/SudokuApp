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
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(themeManager)
                .environmentObject(hapticsManager)
                .preferredColorScheme(themeManager.isDarkMode ? .dark : .light)

        }.modelContainer(for: GameBoard.self)
    }
}

