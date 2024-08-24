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
    @Binding var maxQtd: Int
    @Binding var actualQtd: Int
    @Binding var showGameOverAlert: Bool
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
                NavigationModal(.sheet, value: NavigationContentViewCoordinator.sudokuNumbers(number: $number, correctNumber: $correctNumber, maxQtd: $maxQtd, actualQtd: $actualQtd, showGameOverAlert: $showGameOverAlert), data: NavigationContentViewCoordinator.self, presentationDetents: [.fraction(0.1)], label: {
                    
                    if number == 0 && !additional.isEmpty {
//                        Text("")
                        ArrayOfNumbers(array: $additional)
                            .foregroundStyle(.primary)
                            .border(.brown)
                    }else if number == 0 {
                        Text(" ")

                    }
                    else{
                        Text("\(number)").foregroundStyle(.red)
//                        ArrayOfNumbers(array: [1,4,3,6])
                    }
                    
                }, anyFunction: {
                    haptics.callVibration()
                })
            }
        }
        .font(.system(size: 30, weight: .bold))
        
    }
}


#Preview {
    let modelContent: ModelContainer = .appContainer
    let themeManager = ThemeManager()
    let hapticsManager = HapticsManager()
    return SudokuView(selectedMode: .medium).modelContainer(modelContent)
        .environmentObject(themeManager)
        .environmentObject(hapticsManager)
        .preferredColorScheme(themeManager.isDarkMode ? .dark : .light)
}
