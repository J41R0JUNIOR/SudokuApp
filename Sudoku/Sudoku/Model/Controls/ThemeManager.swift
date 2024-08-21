//
//  ThemeManager.swift
//  Sudoku
//
//  Created by Jairo Júnior on 21/08/24.
//

import Foundation

import SwiftUI

class ThemeManager: ObservableObject {
    @AppStorage("isDarkMode") var isDarkMode: Bool = false {
        didSet {
            UserDefaults.standard.set(isDarkMode, forKey: "isDarkMode")
        }
    }

    init() {
        if let savedTheme = UserDefaults.standard.value(forKey: "isDarkMode") as? Bool {
            self.isDarkMode = savedTheme
        }
    }
}
