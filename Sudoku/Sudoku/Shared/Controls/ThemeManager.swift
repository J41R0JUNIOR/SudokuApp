//
//  ThemeManager.swift
//  Sudoku
//
//  Created by Jairo Júnior on 21/08/24.
//

import Foundation
import SwiftUI

class ThemeManager: ObservableObject {
    
    @AppStorage(UserDefaultsKeysToSave.darkMode.rawValue)
    var isDarkMode: Bool = true
    
    var colors: AppColors {
        isDarkMode ? darkTheme : lightTheme
    }
    
    // MARK: - Light Theme
    private let lightTheme = AppColors(
        primary: Color.black,
        background: Color(.white),
        cellBackground: Color(hex: "#FFFFFF"),
        cellAltBackground: Color(hex: "#EDEDED"),
        selected: Color(hex: "#4A90E2"),
        highlighted: Color(hex: "#A7C7E7"),
        
        textPrimary: Color.black,
        textSecondary: Color.white,
        textFixed: Color(hex: "#000000"),
        textCorrect: Color(hex: "#1E90FF"),
        textWrong: Color(hex: "#FF3B30")
    )
    
    // MARK: - Dark Theme
//    private let darkTheme = AppColors(
//        primary: Color.white,
//        background: Color(hex: "#121212"),
//        cellBackground: Color(hex: "#262626"),
//        cellAltBackground: Color.black,
//        selected: Color(hex: "#5AC8FA"),
//        highlighted: Color(hex: "#3A7CA5"),
//        
//        textPrimary: Color.white,
//        textSecondary: Color.black,
//        textFixed: Color.white,
//        textCorrect: Color(hex: "#4DA3FF"),
//        textWrong: Color(hex: "#FF6B6B")
//    )
    
    private let darkTheme = AppColors(
        primary: Color.white,
        background: Color(hex: "#121212"),
        cellBackground: Color(hex: "#262626"),
        cellAltBackground: Color.black,
        selected: Color(hex: "#5AC8FA"),
        highlighted: Color(hex: "#3A7CA5"),
        
        textPrimary: Color.white,
        textSecondary: Color.black,
        textFixed: Color.white,
        textCorrect: Color(hex: "#4DA3FF"),
        textWrong: Color(hex: "#FF6B6B")
    )
}

// MARK: - Color Model
struct AppColors {
    let primary: Color
    let background: Color
    let cellBackground: Color
    let cellAltBackground: Color
    let selected: Color
    let highlighted: Color
    
    let textPrimary: Color
    let textSecondary: Color
    let textFixed: Color
    let textCorrect: Color
    let textWrong: Color
}

// MARK: - HEX Support
extension Color {
    init(hex: String) {
        let hex = hex.replacingOccurrences(of: "#", with: "")
        
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        
        let r, g, b: UInt64
        
        switch hex.count {
        case 6:
            (r, g, b) = (int >> 16, int >> 8 & 0xFF, int & 0xFF)
        default:
            (r, g, b) = (255, 255, 255)
        }
        
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255
        )
    }
}
