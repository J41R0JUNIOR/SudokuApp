//
//  HapticsController.swift
//  Sudoku
//
//  Created by Jairo Júnior on 21/08/24.
//

import Foundation
import SwiftUI


class HapticsManager: ObservableObject {
    @AppStorage(EnumModel.haptics.rawValue) var isOnVibrationMode: Bool = UserDefaults.standard.bool(forKey: EnumModel.haptics.rawValue)
    
    func callVibration() {
        guard isOnVibrationMode else { return }
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
    }
    
    func toggleVibrationMode() {
        isOnVibrationMode.toggle()
    }
}
