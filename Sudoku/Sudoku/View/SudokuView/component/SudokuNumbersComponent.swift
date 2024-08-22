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
    
    var body: some View {
        VStack{
            if number == correctNumber {
                Text("\(number)").foregroundStyle(.blue)
            } else if number == 0 {
                NavigationModal(.sheet, value: NavigationContentViewCoordinator.sudokuNumbers(number: $number), data: NavigationContentViewCoordinator.self, presentationDetents: [.fraction(0.1)], label: {
                    Text(" ")
                }, asyncFunction: {})
            } else {
                NavigationModal(.sheet, value: NavigationContentViewCoordinator.sudokuNumbers(number: $number), data: NavigationContentViewCoordinator.self, presentationDetents: [.fraction(0.1)], label: {
                    Text("\(number)").foregroundStyle(.red)
                }, asyncFunction: {})
            }
        }
        .font(.system(size: 30, weight: .bold))
        
    }
}


#Preview {
    let modelContent: ModelContainer = .appContainer
    return SudokuView(selectedMode: .medium).modelContainer(modelContent)
}
