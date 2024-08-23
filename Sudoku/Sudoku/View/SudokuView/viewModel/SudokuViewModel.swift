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
    
    func maxQtdToBinding(rowIndex:Int, columnIndex: Int, game: GameBoard) -> Binding<Int>{
        let maxQtdBinding = Binding (
            get: { game.maxQtd },
            set: { _ in}
        )
        
        return maxQtdBinding
    }
    
    func actualQtdBinding(rowIndex:Int, columnIndex: Int, game: GameBoard, modelContext: ModelContext) -> Binding<Int>{
        let actualQtdBinding = Binding (
            get: { game.actualQtd },
            set: { newValue in
                game.actualQtd = newValue
                try? modelContext.save()
            }
        )
        
        return actualQtdBinding
    }
    
//    func gamesBinding(rowIndex: Int, columnIndex: Int, games: [GameBoard], modelContext: ModelContext) -> Binding<[GameBoard]> {
//        return Binding(
//            get: { games },
//            set: { newValue in
//                games = newValue
//                try? modelContext.save()
//            }
//        )
//    }
}





