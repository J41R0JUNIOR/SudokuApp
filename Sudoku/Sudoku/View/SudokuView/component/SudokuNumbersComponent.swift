//
//  SudokuNumbersComponent.swift
//  Sudoku
//
//  Created by Jairo Júnior on 20/08/24.
//

import SwiftUI
import SwiftData

struct SudokuNumbersComponent: View {
    @Binding var number: Int
    @Binding var correctNumber: Int
    @Binding var additional: [Int]
    
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    @EnvironmentObject var haptics: HapticsManager
    
    
    var body: some View {
        VStack{
            if number == correctNumber {
                Text("\(number)").foregroundStyle(.blue)
            } else {
                if number == 0 && !additional.isEmpty {
                    ArrayOfNumbers(array: $additional)
                        .foregroundStyle(.primary)
                }
                else if number == 0 && additional.isEmpty {
                    Text(" ")
                }
                else{
                    Text("\(number)").foregroundStyle(.red)
                }
            }
        }
        .font(.system(size: 30, weight: .bold))
    }
}


#Preview {
    let modelContent: ModelContainer = .appContainer
    let themeManager = ThemeManager()
    let hapticsManager = HapticsManager()
    return SudokuView().modelContainer(modelContent)
        .environmentObject(themeManager)
        .environmentObject(hapticsManager)
        .preferredColorScheme(themeManager.isDarkMode ? .dark : .light)
}
