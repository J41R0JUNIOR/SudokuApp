//
//  GameViewModel.swift
//  Sudoku
//
//  Created by The Godfather Júnior on 27/03/26.
//

import Observation

@Observable
class GameViewModel {
    
    var grid: Grid
    var selectedCell: (row: Int, col: Int)?
    var cells: [[CellState]] = []
    
    let gridRepository: GridRepository
    let engine = Engine.shared
    
    init(gridRepository: GridRepository, grid: Grid) {
        self.gridRepository = gridRepository
        self.grid = grid
        computeCells()
    }
    
    func computeCells() {
        cells = (0..<9).map { row in
            (0..<9).map { col in
                let value = engine.getCellValue(
                    incomplete: grid.incomplete,
                    userGrid: grid.userGrid,
                    row: row,
                    col: col
                )
                
                let wrong = engine.isWrong(
                    userGrid: grid.userGrid,
                    complete: grid.complete,
                    row: row,
                    col: col
                )
                
                let isFixed = !engine.canEditCell(
                    incomplete: grid.incomplete,
                    row: row,
                    col: col
                )
                
                return CellState(
                    value: value,
                    wrong: wrong,
                    isFixed: isFixed
                )
            }
        }
    }
    
    func handleSelection(indice: Indice){
        if indice.row == selectedCell?.row && indice.col == selectedCell?.col {
            selectedCell = nil
            return
        }
        selectedCell = (indice.row, indice.col)
    }
    
    func handleInput(value: Int8?) {
        guard let selectedCell else { return }
        
        engine.makeMove(
            grid: &grid,
            row: selectedCell.row,
            col: selectedCell.col,
            value: value ?? 0
        )
        
        computeCells()
        
        gridRepository.update(data: grid)
    }
}
