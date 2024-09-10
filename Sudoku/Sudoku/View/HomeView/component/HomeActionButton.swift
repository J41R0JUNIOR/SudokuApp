//
//  ActionButton.swift
//  Sudoku
//
//  Created by Jairo Júnior on 21/08/24.
//

import SwiftUI
import SwiftData

struct HomeActionButton: View {
    @Query(sort: [SortDescriptor(\GameBoard.mode, order: .reverse)]) var games: [GameBoard]
    @EnvironmentObject var haptics: HapticsManager
    @EnvironmentObject var router: Router
    
    var title: String
    var mode: GameSelectionMode
    var dataManager: DataManager?
    var presentationMode: Binding<PresentationMode>
    var labelWidth: Double
    var sudokuGenerator: SudokuGenerator = .init()
    
    var body: some View {
        Button(action: {
            buttonAction()

        }, label: {
            Text(title)
                .bold()
                .foregroundStyle(.background)
                .frame(width: UIScreen.main.bounds.width * labelWidth)
        })
    }
    
    func buttonAction(){
        haptics.callVibration()
        
        let grid = sudokuGenerator.getGame(mode: mode)
        let solution = sudokuGenerator.gameArray
        
        dataManager?.deleteAllGameBoards(gameBoards: games)
        dataManager?.addGameBoard(grid: grid, solution: solution, mode: mode)
        presentationMode.wrappedValue.dismiss()
        
        router.push(.sudoku)
    }
}
