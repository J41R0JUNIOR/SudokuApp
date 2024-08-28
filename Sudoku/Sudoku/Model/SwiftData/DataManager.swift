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
    
    func addGameBoard(grid: [[Int]] = [[]], solution: [[Int]] = [[]], mode: String = " ") {
        let gameBoard = GameBoard(grid: grid, solution: solution, mode: mode)
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

