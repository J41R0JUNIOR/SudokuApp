//
//  HomeViewModel.swift
//  Sudoku
//
//  Created by Jairo Júnior on 21/08/24.
//
import Foundation

@Observable
class HomeViewModel {
    
    var showAlert: Bool = false
    var showNewGameSheet: Bool = false
    var choice: GameSelectionMode = .medium
    var grid: Grid?
    let repository: GridRepository
    
    init(repository: GridRepository) {
        self.repository = repository
    }
    
    func generateNewGame(engine: Engine) {
        let newGrid = engine.generateGrid(mode: choice)
        
        self.grid = newGrid
        repository.create(data: newGrid)
    }
    
    func loadLastGame() {
        self.grid = repository.load()
    }
}
