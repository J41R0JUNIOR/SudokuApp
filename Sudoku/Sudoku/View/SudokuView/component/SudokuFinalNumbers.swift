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
         
                Text("\(finalNumbeer)").foregroundStyle(.black)
           
        }
        .font(.system(size: 30, weight: .bold))
        
    }
}
 
//#Preview(body: {
//    SudokuFinalNumbers(finalNumbeer: .constant(3))
//})


#Preview {
    let modelContent: ModelContainer = .appContainer
    return SudokuView(selectedMode: .medium).modelContainer(modelContent)
}
