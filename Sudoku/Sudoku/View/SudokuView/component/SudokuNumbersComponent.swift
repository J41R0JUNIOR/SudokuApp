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
    @Binding var showAlert: Bool

    @EnvironmentObject var haptics: HapticsManager

    
    var body: some View {
        VStack{
            if number == correctNumber {
                Text("\(number)").foregroundStyle(.blue)
                
            } else {
                NavigationModal(.sheet, value: NavigationContentViewCoordinator.sudokuNumbers(number: $number, correctNumber: $correctNumber, maxQtd: $maxQtd, actualQtd: $actualQtd, showAlert: $showAlert), data: NavigationContentViewCoordinator.self, presentationDetents: [.fraction(0.1)], label: {
                    
                    if number == 0 {
                        Text(" ")
                    }else{
                        Text("\(number)").foregroundStyle(.red)
                    }
                    
                }, asyncFunction: {
                    haptics.callVibration()
                })
            }
        }
        .font(.system(size: 30, weight: .bold))
        
    }
}


#Preview {
    let modelContent: ModelContainer = .appContainer
    return SudokuView(selectedMode: .medium).modelContainer(modelContent)
}
