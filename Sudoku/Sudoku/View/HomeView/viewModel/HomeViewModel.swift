//
//  HomeViewModel.swift
//  Sudoku
//
//  Created by Jairo Júnior on 21/08/24.
//

import Foundation

@Observable
class HomeViewModel{
    var choice: GameSelectionMode = .medium
    var showAlert = false
    var showNewGameSheet = false
    var dataManager: DataManager?
}
