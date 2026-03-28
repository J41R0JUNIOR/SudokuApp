//
//  ThemeManager.swift
//  Sudoku
//
//  Created by Jairo Júnior on 21/08/24.
//

import Foundation
import SwiftUI

class ThemeManager: ObservableObject {
    @AppStorage(UserDefaultsKeysToSave.darkMode.rawValue) var isDarkMode: Bool = false {
        didSet {
            UserDefaults.standard.set(isDarkMode, forKey: UserDefaultsKeysToSave.darkMode.rawValue)
        }
    }

    init() {
        if let savedTheme = UserDefaults.standard.value(forKey: UserDefaultsKeysToSave.darkMode.rawValue) as? Bool {
            self.isDarkMode = savedTheme
        }
    }
}
