//
//  HomeViewModel.swift
//  Sudoku
//
//  Created by Jairo Júnior on 21/08/24.
//

import Foundation

@Observable
class HomeViewModel{
    @State var choice: GameSelectionMode = .medium
    @State var showAlert = false
    @State var showNewGameSheet = false
    @State var dataManager: DataManager?
}
