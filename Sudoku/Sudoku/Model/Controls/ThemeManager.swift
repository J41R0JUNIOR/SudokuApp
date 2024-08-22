//
//  ThemeManager.swift
//  Sudoku
//
//  Created by Jairo Júnior on 21/08/24.
//

import Foundation
import SwiftUI

class ThemeManager: ObservableObject {
    @AppStorage(EnumModel.darkMode.rawValue) var isDarkMode: Bool = false {
        didSet {
            UserDefaults.standard.set(isDarkMode, forKey: EnumModel.darkMode.rawValue)
        }
    }

    init() {
        if let savedTheme = UserDefaults.standard.value(forKey: EnumModel.darkMode.rawValue) as? Bool {
            self.isDarkMode = savedTheme
        }
    }
}
