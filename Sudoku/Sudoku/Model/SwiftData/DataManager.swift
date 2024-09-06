//
//  DataManager.swift
//  Sudoku
//
//  Created by Jairo Júnior on 21/08/24.
//


import Foundation
import SwiftData

@Observable
class DataManager {
    private var modelContext: ModelContext
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
        self.mocData()
    }
    
    private func mocData() {
        // Mock or initial data setup if needed
    }
    
    func addGameBoard(grid: [[Int]] = [[]], solution: [[Int]] = [[]], mode: GameSelectionMode) {
        var value = 0
        
        switch mode{
        case .easy:
            value = 25
        case .medium:
            value = 45
        case .hard:
            value = 62
        }
        
        let gameBoard = GameBoard(grid: grid, solution: solution, mode: mode.rawValue, restNumbers: value)
        modelContext.insert(gameBoard)
    }
    
    func deleteGameBoard(indexSet: IndexSet, gameBoards: [GameBoard]) {
        for index in indexSet {
            let destination = gameBoards[index]
            modelContext.delete(destination)
        }
    }
    
    func deleteAllGameBoards(gameBoards: [GameBoard]) {
        for gameBoard in gameBoards {
            modelContext.delete(gameBoard)
        }
    }
}

