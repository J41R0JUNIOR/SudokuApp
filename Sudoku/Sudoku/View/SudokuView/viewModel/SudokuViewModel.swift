//
//  SudokuViewModel.swift
//  Sudoku
//
//  Created by Jairo Júnior on 20/08/24.
//

import Foundation
import SwiftUI
import SwiftData

@Observable
class SudokuViewModel{
    var model = SudokuModel()
    
    
    
    func correctNumberToBinding(rowIndex:Int, columnIndex: Int, game: GameBoard) -> Binding<Int>{
        let correctNumberBinding = Binding(
            get: { game.solution[rowIndex][columnIndex] },
            set: { _ in}
        )
        return correctNumberBinding
    }
    
    func numberToBinding(rowIndex:Int, columnIndex: Int, game: GameBoard, modelContext: ModelContext) -> Binding<Int>{
        let numberBinding = Binding(
            get: { game.grid[rowIndex][columnIndex] },
            set: { newValue in
                game.grid[rowIndex][columnIndex] = newValue
                try? modelContext.save()
            }
        )
        
        return numberBinding
    }
    
    func maxQtdToBinding(rowIndex:Int, columnIndex: Int, game: GameBoard, modelContext: ModelContext) -> Binding<Int>{
        let maxQtdBinding = Binding (
            get: { game.solution[rowIndex][columnIndex] },
            set: { newValue in
                game.maxQtd = newValue
                try? modelContext.save()
            }
        )
        
        return maxQtdBinding
    }

}





