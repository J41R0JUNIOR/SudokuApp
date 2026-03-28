//
//  GameViewModel.swift
//  Sudoku
//
//  Created by The Godfather Júnior on 27/03/26.
//

import Observation

@Observable
class GameViewModel {
    
    var gameGrids: Grid?
    var selectedCell: (row: Int, col: Int)?
    
    let gridRepository: GridRepository
    let engine = Engine.shared
    
    init(gridRepository: GridRepository) {
        self.gridRepository = gridRepository
    }
    
    func loadGame() {
        if let saved = gridRepository.load() {
            self.gameGrids = saved
        } else {
            let newGame = engine.generateGrid(mode: .easy)
            self.gameGrids = newGame
            gridRepository.create(data: newGame)
        }
    }
    
    func handleSelection(indice: Indice){
        if (indice.row == selectedCell?.row && indice.col == selectedCell?.col) {
            selectedCell = nil
            return
        }
        selectedCell = (indice.row, indice.col)
    }
    
    func handleInput(value: Int8?) {
        guard let selectedCell = selectedCell else { return }
        guard var game = gameGrids else { return }
        
        let row = selectedCell.row
        let col = selectedCell.col
        
        if !engine.canEditCell(
            incomplete: game.incomplete,
            row: row,
            col: col
        ) {
            return
        }
        
        game.userGrid[row][col] = value ?? 0
        
        self.gameGrids = game
        
        if gridRepository.load() != nil {
            gridRepository.update(data: game)
        } else {
            gridRepository.create(data: game)
        }
    }
}
