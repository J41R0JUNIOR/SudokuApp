//
//  SudokuNumbersComponent.swift
//  Sudoku
//
//  Created by Jairo Júnior on 20/08/24.
//

import SwiftUI
import SwiftData

struct SudokuFinalNumbers: View {
    @Binding var finalNumbeer: Int
    
    var body: some View {
        VStack{
            Text("\(finalNumbeer)").foregroundStyle(.primary)
        }
        .font(.system(size: 30, weight: .bold))
        
    }
}



#Preview {
    let modelContent: ModelContainer = .appContainer
    return SudokuView(selectedMode: .medium).modelContainer(modelContent)
}
